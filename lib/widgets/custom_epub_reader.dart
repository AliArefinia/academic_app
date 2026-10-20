import 'package:academic/core/settings/app_settings.dart';
import 'package:academic/l10n/l10n.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/core/theme/const.dart';
import 'package:path_provider/path_provider.dart';
import 'package:archive/archive.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart' as html_dom;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:academic/core/services/reading_progress_service.dart';
import 'package:academic/data/api/home/model/reading_progress_model.dart';
import 'package:academic/data/api/product/model/product_model.dart';
import 'package:academic/core/helper/premium_helper.dart';
import 'package:get_it/get_it.dart';
import 'dart:typed_data';

class CustomEpubReader extends StatefulWidget {
  final String epubPath;
  final Color themeColor;
  final bool enableNightMode;
  final bool enableTts;
  final bool allowSharing;
  final Function(String text)? onAddNote;
  final Function(int bookId, String text)? onAddBookClipping;
  final ProductModel? product;
  final int? initialPage;
  final bool isSample;

  const CustomEpubReader({
    Key? key,
    required this.epubPath,
    this.themeColor = Colors.blue,
    this.enableNightMode = false,
    this.enableTts = false,
    this.allowSharing = true, // Changed to true by default
    this.onAddNote,
    this.onAddBookClipping,
    this.product,
    this.initialPage,
    this.isSample = false,
  }) : super(key: key);

  @override
  State<CustomEpubReader> createState() => _CustomEpubReaderState();
}

class _CustomEpubReaderState extends State<CustomEpubReader>
    with SingleTickerProviderStateMixin {
  late Future<void> _initFuture;
  String _currentContent = '';
  int _currentPage = 0;
  Timer? _progressSaveTimer;
  ReadingProgressService? _progressService;
  List<String> _pages = [];
  List<String> _htmlPages = [];
  List<Chapter> _chapters = [];
  double _fontSize = 18.0;
  String _fontFamily = 'yakanBakh';
  FontWeight _fontWeight = FontWeight.w400;
  bool _isNightMode = AppSettings.instance.isDarkActive;
  List<Highlight> _highlights = [];
  ScrollController _scrollController = ScrollController();
  Uint8List? _coverImageBytes;
  PageController? _pageController;
  Axis _scrollDirection = Axis.horizontal;
  bool _showGridView = false;
  late ScrollController _gridViewScrollController;
  late TabController _tabController;
  final Map<String, String> _availableFonts = {
    'yakanBakh': l10n.fontYekanBakh,
    'Vazirmatn': l10n.fontVazir,
    'Anjoman': l10n.fontAnjoman,
    'IRANYekanX': l10n.fontIranYekan,
  };
  double _lineSpacing = 1.8;
  Set<int> _savedPages = {};
  int _bottomSheetTabIndex = 0;

  // New list to store content units (HTML strings)
  List<String> _contentUnits = [];

  // Map to store the starting page index for each content file path (relative to OPF)
  Map<String, int> _contentFilePathToPageIndex = {};

  // Store content file paths relative to OPF directory, matching TOC hrefs
  List<String> _opfRelativeContentFilePaths = [];

  // New state variable to store paginated page data
  List<Map<String, dynamic>> _paginatedPageData = [];

  // New state variable to store page element keys
  List<Map<String, GlobalKey>> _pageElementKeys = [];

  // New list to store scroll controllers for each page
  List<ScrollController> _pageScrollControllers = [];

  // Add new state variable for plain text
  List<String> _pagesPlainText = [];

  // Add new state variables for display text
  List<String> _displayHtml = [];
  List<String> _displayText = [];

  // Store plain text for each page
  List<String> _pageTexts = [];

  bool _isInitialized = false;
  int? _pendingTargetPage;

  // Convert HTML to plain text and store it
  void _processPageContent(String html, int pageIndex) {
    final doc = html_parser.parse(html);
    final paragraphs = doc.querySelectorAll('p');
    final plainText = paragraphs.map((p) => p.text).join('\n\n');

    if (pageIndex >= _pageTexts.length) {
      _pageTexts.add(plainText);
    } else {
      _pageTexts[pageIndex] = plainText;
    }
  }

  Widget _buildPageContent(String html, int pageIndex) {
    final doc = html_parser.parse(html);
    // اگر تصویر وجود دارد، همان را نمایش بده
    final images = doc.querySelectorAll('img');
    if (images.isNotEmpty) {
      final imgSrc = images.first.attributes['src'];
      if (imgSrc != null && imgSrc.isNotEmpty) {
        return FutureBuilder<Uint8List?>(
          future: _loadImageFromEpub(imgSrc),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData && snapshot.data != null) {
              return Center(
                child: Image.memory(
                  snapshot.data!,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const SizedBox.shrink();
                  },
                ),
              );
            }
            return const SizedBox.shrink();
          },
        );
      }
    }
    // اگر متن وجود دارد، نمایش بده (از کل body نه فقط <p>)
    final plainText = (doc.body?.text?.trim().isNotEmpty == true)
        ? (doc.body?.text ?? '').trim()
        : (doc.text ?? '').trim();
    while (_pageTexts.length <= pageIndex) {
      _pageTexts.add('');
    }
    _pageTexts[pageIndex] = plainText;
    if (plainText.isEmpty) {
      return const SizedBox.shrink();
    }
    // نمایش متن با برجسته
    final highlights = _highlights
        .where((h) =>
            h.pageIndex == pageIndex &&
            (h.bookId == widget.epubPath || h.bookId == widget.product?.id))
        .toList();
    highlights.sort((a, b) => a.start.compareTo(b.start));
    List<TextSpan> spans = [];
    int currentPos = 0;
    for (final highlight in highlights) {
      if (highlight.start > currentPos) {
        spans.add(TextSpan(
          text: plainText.substring(currentPos, highlight.start),
          style: _baseStyle(),
        ));
      }
      spans.add(TextSpan(
        text: plainText.substring(highlight.start, highlight.end),
        style: _baseStyle().copyWith(
          backgroundColor: highlight.color,
        ),
      ));
      currentPos = highlight.end;
    }
    if (currentPos < plainText.length) {
      spans.add(TextSpan(
        text: plainText.substring(currentPos),
        style: _baseStyle(),
      ));
    }
    return SelectableText.rich(
      TextSpan(children: spans),
      textDirection: TextDirection.rtl,
      showCursor: true,
      cursorWidth: 2,
      cursorColor: widget.themeColor,
      cursorRadius: const Radius.circular(1),
      toolbarOptions: const ToolbarOptions(
        copy: true,
        selectAll: true,
        cut: false,
        paste: false,
      ),
      contextMenuBuilder: (context, editableTextState) {
        final List<ContextMenuButtonItem> buttonItems = [
          if (widget.allowSharing && widget.onAddNote != null)
            ContextMenuButtonItem(
              onPressed: () {
                final sel = editableTextState.textEditingValue.selection;
                if (sel.start >= 0 && sel.end > sel.start) {
                  final selected =
                      plainText.substring(sel.start, sel.end).trim();
                  if (selected.isNotEmpty) {
                    widget.onAddNote?.call(selected);
                    editableTextState.hideToolbar();
                  }
                }
              },
              type: ContextMenuButtonType.custom,
              label: l10n.addToNoteCardsEmoji,
            ),
          if (widget.allowSharing && widget.onAddBookClipping != null && widget.product?.idAsInt != null)
            ContextMenuButtonItem(
              onPressed: () {
                final sel = editableTextState.textEditingValue.selection;
                if (sel.start >= 0 && sel.end > sel.start) {
                  final selected =
                      plainText.substring(sel.start, sel.end).trim();
                  if (selected.isNotEmpty && widget.product?.idAsInt != null) {
                    widget.onAddBookClipping?.call(widget.product!.idAsInt!, selected);
                    editableTextState.hideToolbar();
                  }
                }
              },
              type: ContextMenuButtonType.custom,
              label: l10n.bookClippingEmoji,
            ),
          ContextMenuButtonItem(
            onPressed: () {
              final sel = editableTextState.textEditingValue.selection;
              if (sel.start >= 0 && sel.end > sel.start) {
                // Get selected text from the displayed text (with highlights)
                final displayedText = editableTextState.textEditingValue.text;
                final selectedText = displayedText.substring(sel.start, sel.end).trim();
                
                if (selectedText.isNotEmpty) {
                  // Find the actual position in plainText by searching for the selected text
                  final actualPositions = _findTextInPlainText(plainText, selectedText, pageIndex);
                  if (actualPositions != null) {
                    _addHighlight(
                      selectedText,
                      actualPositions['start']!,
                      actualPositions['end']!,
                      color: Colors.yellow.withOpacity(0.3),
                      pageIndex: pageIndex,
                    );
                  }
                }
              }
              editableTextState.hideToolbar();
            },
            type: ContextMenuButtonType.custom,
            label: l10n.highlightYellow,
          ),
          ContextMenuButtonItem(
            onPressed: () {
              final sel = editableTextState.textEditingValue.selection;
              if (sel.start >= 0 && sel.end > sel.start) {
                // Get selected text from the displayed text (with highlights)
                final displayedText = editableTextState.textEditingValue.text;
                final selectedText = displayedText.substring(sel.start, sel.end).trim();
                
                if (selectedText.isNotEmpty) {
                  // Find the actual position in plainText by searching for the selected text
                  final actualPositions = _findTextInPlainText(plainText, selectedText, pageIndex);
                  if (actualPositions != null) {
                    _addHighlight(
                      selectedText,
                      actualPositions['start']!,
                      actualPositions['end']!,
                      color: Colors.green.withOpacity(0.3),
                      pageIndex: pageIndex,
                    );
                  }
                }
              }
              editableTextState.hideToolbar();
            },
            type: ContextMenuButtonType.custom,
            label: l10n.highlightGreen,
          ),
          ContextMenuButtonItem(
            onPressed: () {
              final sel = editableTextState.textEditingValue.selection;
              if (sel.start >= 0 && sel.end > sel.start) {
                // Get selected text from the displayed text (with highlights)
                final displayedText = editableTextState.textEditingValue.text;
                final selectedText = displayedText.substring(sel.start, sel.end).trim();
                
                if (selectedText.isNotEmpty) {
                  // Find the actual position in plainText by searching for the selected text
                  final actualPositions = _findTextInPlainText(plainText, selectedText, pageIndex);
                  if (actualPositions != null) {
                    _addHighlight(
                      selectedText,
                      actualPositions['start']!,
                      actualPositions['end']!,
                      color: Colors.orange.withOpacity(0.3),
                      pageIndex: pageIndex,
                    );
                  }
                }
              }
              editableTextState.hideToolbar();
            },
            type: ContextMenuButtonType.custom,
            label: l10n.highlightOrange,
          ),
          ContextMenuButtonItem(
            onPressed: () {
              final sel = editableTextState.textEditingValue.selection;
              if (sel.start >= 0 && sel.end > sel.start) {
                // Get selected text from the displayed text (with highlights)
                final displayedText = editableTextState.textEditingValue.text;
                final selectedText = displayedText.substring(sel.start, sel.end).trim();
                
                if (selectedText.isNotEmpty) {
                  // Find the actual position in plainText by searching for the selected text
                  final actualPositions = _findTextInPlainText(plainText, selectedText, pageIndex);
                  if (actualPositions != null) {
                    _addHighlight(
                      selectedText,
                      actualPositions['start']!,
                      actualPositions['end']!,
                      color: Colors.blue.withOpacity(0.3),
                      pageIndex: pageIndex,
                    );
                  }
                }
              }
              editableTextState.hideToolbar();
            },
            type: ContextMenuButtonType.custom,
            label: l10n.highlightBlue,
          ),
        ];
        return AdaptiveTextSelectionToolbar.buttonItems(
          anchors: editableTextState.contextMenuAnchors,
          buttonItems: buttonItems,
        );
      },
    );
  }

  Widget _buildColorButton(Color color, String emoji, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey),
        ),
        child: Center(
          child: Text(
            emoji,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }

  /// Find the actual position of selected text in plainText
  /// This is needed because selection positions from SelectableText.rich
  /// may not match plainText positions when highlights are already present
  Map<String, int>? _findTextInPlainText(String plainText, String selectedText, int pageIndex) {
    if (selectedText.trim().isEmpty) return null;
    
    // Normalize the selected text for better matching
    final normalizedSelected = _normalizeText(selectedText);
    final normalizedPlainText = _normalizeText(plainText);
    
    if (normalizedSelected.isEmpty) return null;
    
    // Get existing highlights for this page
    final pageHighlights = _highlights
        .where((h) =>
            h.pageIndex == pageIndex &&
            (h.bookId == widget.epubPath || h.bookId == widget.product?.id))
        .toList();
    
    // Try to find the text in plainText, avoiding overlaps with existing highlights
    int searchStart = 0;
    while (true) {
      final normalizedIndex = normalizedPlainText.indexOf(normalizedSelected, searchStart);
      if (normalizedIndex == -1) break;
      
      // Convert normalized index to actual plainText index
      final actualPositions = _normalizedToActualPosition(plainText, normalizedIndex, normalizedSelected.length);
      if (actualPositions == null) {
        searchStart = normalizedIndex + 1;
        continue;
      }
      
      // Check if this position overlaps with any existing highlight
      final overlaps = pageHighlights.any((h) =>
          (actualPositions['start']! < h.end && actualPositions['end']! > h.start));
      
      if (!overlaps) {
        return actualPositions;
      }
      
      searchStart = normalizedIndex + 1;
    }
    
    // If no non-overlapping position found, try simple search
    final simpleIndex = plainText.indexOf(selectedText);
    if (simpleIndex != -1) {
      return {'start': simpleIndex, 'end': simpleIndex + selectedText.length};
    }
    
    // Last resort: use normalized search result
    final firstNormalizedIndex = normalizedPlainText.indexOf(normalizedSelected);
    if (firstNormalizedIndex != -1) {
      return _normalizedToActualPosition(plainText, firstNormalizedIndex, normalizedSelected.length);
    }
    
    return null;
  }
  
  /// Convert normalized text index to actual text position
  Map<String, int>? _normalizedToActualPosition(String originalText, int normalizedIndex, int normalizedLength) {
    // Build a mapping between normalized and actual positions
    final normalizedText = _normalizeText(originalText);
    if (normalizedIndex + normalizedLength > normalizedText.length) return null;
    
    // Find start position
    int actualStart = 0;
    int normalizedPos = 0;
    
    for (int i = 0; i < originalText.length && normalizedPos < normalizedIndex; i++) {
      final char = originalText[i];
      // Count this character in normalized text if it's not a special whitespace
      if (char != '\n' && char != '\r' && char != '\t') {
        normalizedPos++;
      }
      actualStart = i + 1;
    }
    
    // Find end position
    int actualEnd = actualStart;
    int normalizedEnd = normalizedIndex + normalizedLength;
    
    for (int i = actualStart; i < originalText.length && normalizedPos < normalizedEnd; i++) {
      final char = originalText[i];
      if (char != '\n' && char != '\r' && char != '\t') {
        normalizedPos++;
      }
      actualEnd = i + 1;
    }
    
    // Verify the found text
    if (actualStart < originalText.length && actualEnd <= originalText.length) {
      final foundText = _normalizeText(originalText.substring(actualStart, actualEnd));
      final expectedText = normalizedText.substring(normalizedIndex, normalizedIndex + normalizedLength);
      if (foundText == expectedText) {
        return {'start': actualStart, 'end': actualEnd};
      }
    }
    
    return null;
  }

  void _addHighlight(String text, int start, int end,
      {Color? color, int? pageIndex}) {
    if (pageIndex != null && pageIndex >= 0 && pageIndex < _pages.length) {
      // Validate the highlight
      if (start >= 0 && end > start && end <= _pageTexts[pageIndex].length) {
        final selectedText = _pageTexts[pageIndex].substring(start, end).trim();
        if (selectedText.isNotEmpty) {
          // Check if this highlight already exists to avoid duplicates
          final existingHighlight = _highlights.any((h) =>
              h.pageIndex == pageIndex &&
              h.start == start &&
              h.end == end &&
              h.text == selectedText);

          if (!existingHighlight) {
            setState(() {
              _highlights.add(Highlight(
                text: selectedText,
                start: start,
                end: end,
                color: color ?? Colors.yellow.withOpacity(0.3),
                pageIndex: pageIndex,
                timestamp: DateTime.now(),
                bookId: widget.epubPath, // Use epubPath as bookId
              ));
            });

            // Save highlights immediately
            _saveHighlights();

            // Show a snackbar to confirm the highlight
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(l10n.textHighlightedSuccessfully),
                duration: const Duration(seconds: 2),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        }
      }
    }
  }

  // Add this helper method to extract visible content from HTML
  String _extractVisibleContent(String html) {
    final doc = html_parser.parseFragment(html);
    // Try to find the main content container
    final body = doc.querySelector('body') ??
        doc.querySelector('section[epub\\:type="bodymatter"]') ??
        doc.querySelector('section');

    // If no specific container found, use the entire fragment
    return body?.innerHtml ?? doc.outerHtml;
  }

  // Add this helper method to clean HTML content
  String _cleanHtmlContent(String rawHtml) {
    // First try to parse as a full HTML document
    final doc = html_parser.parse(rawHtml);

    // Try to get content from body
    final bodyEl = doc.querySelector('body');
    if (bodyEl != null) {
      return bodyEl.innerHtml;
    }

    // If no body, try to remove head section
    final cleaned = rawHtml.replaceFirst(RegExp(r'(?s)<head>.*?</head>'), '');

    // If still no body, try to find main content section
    final contentDoc = html_parser.parse(cleaned);
    final mainSection =
        contentDoc.querySelector('section[epub\\:type="bodymatter"]') ??
            contentDoc.querySelector('section') ??
            contentDoc.querySelector('article');

    return mainSection?.innerHtml ?? cleaned;
  }

  /// Manual HTML -> RichText converter for heading, img, a, inline color, align, etc.
  /// Now uses SelectableText.rich for text blocks with context menu highlight options.
  Map<String, dynamic> _buildRichContent(String html, {int? contentPageIndex}) {
    // First, get clean display HTML
    final fragment = html_parser.parseFragment(html);
    final rawDisplay =
        fragment.querySelector('body')?.innerHtml ?? fragment.outerHtml;
    final displayHtml = rawDisplay.trim(); // Remove leading/trailing whitespace

    // Store display HTML and text for this page
    if (contentPageIndex != null) {
      final pageText =
          html_parser.parseFragment(displayHtml).text?.trim() ?? '';
      if (contentPageIndex >= _displayHtml.length) {
        _displayHtml.add(displayHtml);
        _displayText.add(pageText);
      } else {
        _displayHtml[contentPageIndex] = displayHtml;
        _displayText[contentPageIndex] = pageText;
      }
    }

    // Parse the display HTML for rendering
    final doc = html_parser.parseFragment(displayHtml);
    List<Widget> contentWidgets = [];
    Map<String, GlobalKey> elementIdKeys = {};

    // Get all highlights for this page and sort by start position
    final pageHighlights = _highlights
        .where((h) =>
            h.pageIndex == contentPageIndex &&
            (h.bookId == widget.epubPath || h.bookId == widget.product?.id))
        .toList()
      ..sort((a, b) => a.start.compareTo(b.start));

    // Track character position in display text
    int globalIndex = 0;

    // This will build a list of InlineSpans for the current block
    List<InlineSpan> currentBlockSpans = [];
    TextAlign currentBlockAlign = TextAlign.right;
    bool hasExplicitTextAlign = false;

    void flushCurrentBlock() {
      if (currentBlockSpans.isNotEmpty) {
        TextAlign finalTextAlign = currentBlockAlign;
        if (!hasExplicitTextAlign) {
          final textSample = currentBlockSpans
              .map((span) => span is TextSpan ? span.text : '')
              .join()
              .trim();
          if (_isLikelyLTR(textSample)) {
            finalTextAlign = TextAlign.left;
          } else {
            finalTextAlign = TextAlign.right;
          }
        }
        contentWidgets.add(SelectableText.rich(
          TextSpan(children: currentBlockSpans, style: _baseStyle()),
          textDirection: TextDirection.rtl,
          textAlign: finalTextAlign,
          showCursor: true,
          toolbarOptions: const ToolbarOptions(copy: true, selectAll: true),
          contextMenuBuilder: (context, editableTextState) {
            final List<ContextMenuButtonItem> buttonItems = [];
            
            // Add book clipping option if available
            if (widget.allowSharing && widget.onAddBookClipping != null && widget.product?.idAsInt != null) {
              buttonItems.add(
                ContextMenuButtonItem(
                  onPressed: () {
                    final sel = editableTextState.textEditingValue.selection;
                    if (sel.start >= 0 &&
                        sel.end > sel.start &&
                        contentPageIndex != null) {
                      final plain = _displayText[contentPageIndex];
                      final selected =
                          plain.substring(sel.start, sel.end).trim();
                      if (selected.isNotEmpty && widget.product?.idAsInt != null) {
                        widget.onAddBookClipping?.call(widget.product!.idAsInt!, selected);
                        editableTextState.hideToolbar();
                      }
                    }
                  },
                  type: ContextMenuButtonType.custom,
                  label: l10n.bookClippingEmoji,
                ),
              );
            }
            
            // Add highlight options
            buttonItems.addAll([
              // 🟡 yellow
              ContextMenuButtonItem(
                  onPressed: () {
                    final sel = editableTextState.textEditingValue.selection;
                    if (sel.start >= 0 &&
                        sel.end > sel.start &&
                        contentPageIndex != null) {
                      final plain = _displayText[contentPageIndex];
                      final selected =
                          plain.substring(sel.start, sel.end).trim();
                      if (selected.isNotEmpty) {
                        _addHighlight(
                          selected,
                          sel.start,
                          sel.end,
                          color: Colors.yellow.withOpacity(0.5),
                          pageIndex: contentPageIndex,
                        );
                      }
                    }
                    editableTextState.hideToolbar();
                  },
                  type: ContextMenuButtonType.custom,
                  label: '🟡',
                ),
                // 🟢 green
                ContextMenuButtonItem(
                  onPressed: () {
                    final sel = editableTextState.textEditingValue.selection;
                    if (sel.start >= 0 &&
                        sel.end > sel.start &&
                        contentPageIndex != null) {
                      final plain = _displayText[contentPageIndex];
                      final selected =
                          plain.substring(sel.start, sel.end).trim();
                      if (selected.isNotEmpty) {
                        _addHighlight(
                          selected,
                          sel.start,
                          sel.end,
                          color: Colors.green.withOpacity(0.5),
                          pageIndex: contentPageIndex,
                        );
                      }
                    }
                    editableTextState.hideToolbar();
                  },
                  type: ContextMenuButtonType.custom,
                  label: '🟢',
                ),
                // 🟠 orange
                ContextMenuButtonItem(
                  onPressed: () {
                    final sel = editableTextState.textEditingValue.selection;
                    if (sel.start >= 0 &&
                        sel.end > sel.start &&
                        contentPageIndex != null) {
                      final plain = _displayText[contentPageIndex];
                      final selected =
                          plain.substring(sel.start, sel.end).trim();
                      if (selected.isNotEmpty) {
                        _addHighlight(
                          selected,
                          sel.start,
                          sel.end,
                          color: Colors.orange.withOpacity(0.5),
                          pageIndex: contentPageIndex,
                        );
                      }
                    }
                    editableTextState.hideToolbar();
                  },
                  type: ContextMenuButtonType.custom,
                  label: '🟠',
                ),
                // 🔵 blue
                ContextMenuButtonItem(
                  onPressed: () {
                    final sel = editableTextState.textEditingValue.selection;
                    if (sel.start >= 0 &&
                        sel.end > sel.start &&
                        contentPageIndex != null) {
                      final plain = _displayText[contentPageIndex];
                      final selected =
                          plain.substring(sel.start, sel.end).trim();
                      if (selected.isNotEmpty) {
                        _addHighlight(
                          selected,
                          sel.start,
                          sel.end,
                          color: Colors.blue.withOpacity(0.5),
                          pageIndex: contentPageIndex,
                        );
                      }
                    }
                    editableTextState.hideToolbar();
                  },
                  type: ContextMenuButtonType.custom,
                  label: '🔵',
                ),
                // 💗 pink
                ContextMenuButtonItem(
                  onPressed: () {
                    final sel = editableTextState.textEditingValue.selection;
                    if (sel.start >= 0 &&
                        sel.end > sel.start &&
                        contentPageIndex != null) {
                      final plain = _displayText[contentPageIndex];
                      final selected =
                          plain.substring(sel.start, sel.end).trim();
                      if (selected.isNotEmpty) {
                        _addHighlight(
                          selected,
                          sel.start,
                          sel.end,
                          color: Colors.pinkAccent.withOpacity(0.5),
                          pageIndex: contentPageIndex,
                        );
                      }
                    }
                    editableTextState.hideToolbar();
                  },
                  type: ContextMenuButtonType.custom,
                  label: '💗',
                ),
            ]);
            
            return AdaptiveTextSelectionToolbar.buttonItems(
              anchors: editableTextState.contextMenuAnchors,
              buttonItems: buttonItems,
            );
          },
        ));
        currentBlockSpans = [];
        currentBlockAlign = TextAlign.right;
        hasExplicitTextAlign = false;
      }
    }

    void processTextNode(html_dom.Text node) {
      final nodeText = node.text;
      final nodeLen = nodeText.length;
      int localIndex = 0;
      List<InlineSpan> nodeSpans = [];

      // Find all highlights that overlap with this text node
      final overlappingHighlights = pageHighlights.where((h) {
        final nodeStart = globalIndex;
        final nodeEnd = globalIndex + nodeLen;
        return h.start < nodeEnd && h.end > nodeStart;
      }).toList();

      // Sort overlapping highlights by start position
      overlappingHighlights.sort((a, b) => a.start.compareTo(b.start));

      // Process each overlapping highlight
      for (final highlight in overlappingHighlights) {
        // Calculate the actual start and end positions within this node
        final nodeStart = globalIndex;
        final nodeEnd = globalIndex + nodeLen;

        // Calculate the relative start and end positions for this highlight within the node
        final relativeStart = max(0, highlight.start - nodeStart);
        final relativeEnd = min(nodeLen, highlight.end - nodeStart);

        // Add text before highlight if needed
        if (relativeStart > localIndex) {
          final beforeText = nodeText.substring(localIndex, relativeStart);
          if (beforeText.isNotEmpty) {
            nodeSpans.add(TextSpan(
              text: beforeText,
              style: _baseStyle(),
            ));
          }
        }

        // Add highlighted text
        if (relativeEnd > relativeStart) {
          final highlightText = nodeText.substring(relativeStart, relativeEnd);
          if (highlightText.isNotEmpty) {
            nodeSpans.add(TextSpan(
              text: highlightText,
              style: _baseStyle().copyWith(
                backgroundColor: highlight.color,
              ),
            ));
          }
          localIndex = relativeEnd;
        }
      }

      // Add remaining text
      if (localIndex < nodeText.length) {
        final remainingText = nodeText.substring(localIndex);
        if (remainingText.isNotEmpty) {
          nodeSpans.add(TextSpan(
            text: remainingText,
            style: _baseStyle(),
          ));
        }
      }

      // Add all spans to current block
      if (nodeSpans.isNotEmpty) {
        currentBlockSpans.addAll(nodeSpans);
      }
      globalIndex += nodeLen;
    }

    void parseNode(html_dom.Node node) {
      if (node is html_dom.Text) {
        final trimmedText = node.text.trim();
        if (trimmedText.isEmpty) {
          if (node.text.contains('\n')) {
            currentBlockSpans.add(const TextSpan(text: '\n'));
          }
          globalIndex += node.text.length;
          return;
        }
        processTextNode(node);
      } else if (node is html_dom.Element) {
        // Handle block-level elements
        if (['p', 'div', 'h1', 'h2', 'h3', 'blockquote', 'ul', 'ol']
            .contains(node.localName)) {
          flushCurrentBlock();

          // Check for text-align style
          final styleAttr = node.attributes['style'];
          if (styleAttr != null) {
            final alignMatch =
                RegExp(r'text-align:\s*(left|right|center|justify)')
                    .firstMatch(styleAttr);
            if (alignMatch != null) {
              final align = alignMatch.group(1);
              switch (align) {
                case 'left':
                  currentBlockAlign = TextAlign.left;
                  break;
                case 'center':
                  currentBlockAlign = TextAlign.center;
                  break;
                case 'justify':
                  currentBlockAlign = TextAlign.justify;
                  break;
                default:
                  currentBlockAlign = TextAlign.right;
                  break;
              }
              hasExplicitTextAlign = true;
            }
          }

          // Process children
          node.nodes.forEach(parseNode);

          // Add spacing after block elements
          if (node != doc.nodes.last) {
            currentBlockSpans.add(const TextSpan(text: '\n\n'));
          }
        } else {
          // Process inline elements
          node.nodes.forEach(parseNode);
        }
      }
    }

    // Process all nodes
    for (final node in doc.nodes) {
      parseNode(node);
    }

    // Flush any remaining spans
    flushCurrentBlock();

    return {
      'widgets': Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: contentWidgets),
      'elementIdKeys': elementIdKeys,
    };
  }

  TextStyle _baseStyle() {
    return TextStyle(
      fontSize: _fontSize,
      fontFamily: _fontFamily,
      fontWeight: _fontWeight,
      height: _lineSpacing,
      color: _isNightMode ? Colors.white : Colors.black,
    );
  }

  @override
  void initState() {
    super.initState();
    _initFuture = _initializeReader();
    _progressService = ReadingProgressService(GetIt.I<SharedPreferences>());
    _currentPage = widget.initialPage ?? 0;
    _pageController = PageController(initialPage: _currentPage);
    _gridViewScrollController = ScrollController();
    _tabController = TabController(length: 3, vsync: this);

    // Add page change listener
    _pageController?.addListener(() {
      final page = _pageController?.page?.round() ?? 0;
      if (page != _currentPage) {
        setState(() {
          _currentPage = page;
        });
        // Save progress when page changes
        _saveProgress();
      }
    });
  }

  Future<void> _initializeReader() async {
    try {
      await _loadEpub();
      await _loadHighlights();
      await _loadSavedPages();
      await _loadSettings();

      // Use initialPage if provided, otherwise try to get from saved progress
      int targetPage = 0;
      if (widget.initialPage != null) {
        targetPage = widget.initialPage!;
      } else if (widget.product != null) {
        final savedProgress =
            await _progressService?.getProgress(widget.product!.id ?? '');
        if (savedProgress != null) {
          targetPage = savedProgress.lastPosition;
        }
      }

      // Store the target page for later use after pagination
      _pendingTargetPage = targetPage;

      setState(() {
        _isInitialized = true;
      });
    } catch (e) {
      debugPrint('Error initializing reader: $e');
    }
  }

  Future<void> _loadHighlights() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('highlights');
    if (data != null) {
      try {
        final list = jsonDecode(data) as List;
        setState(() {
          // Load highlights for current book using bookId
          _highlights = list
              .map((e) => Highlight.fromJson(e))
              .where((h) =>
                  h.bookId == widget.epubPath || h.bookId == widget.product?.id)
              .toList();
        });
      } catch (e) {
        // If there's an error parsing highlights, clear them
        setState(() {
          _highlights = [];
        });
      }
    }
  }

  Future<void> _loadSavedPages() async {
    final prefs = await SharedPreferences.getInstance();
    final savedPagesData = prefs.getString('savedPages_${widget.product?.id}');
    if (savedPagesData != null) {
      final List<dynamic> decoded = jsonDecode(savedPagesData);
      setState(() {
        _savedPages = decoded.map((e) => e as int).toSet();
      });
    }
  }

  Future<void> _savePage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (_savedPages.contains(_currentPage)) {
        _savedPages.remove(_currentPage);
      } else {
        _savedPages.add(_currentPage);
      }
    });
    await prefs.setString(
      'savedPages_${widget.product?.id}',
      jsonEncode(_savedPages.toList()),
    );
  }

  Future<void> _saveProgress() async {
    if (widget.product == null || _progressService == null) {
      return;
    }

    // Only save progress for books that are purchased or have subscription access
    final isPurchased = widget.product!.isPurchased ?? false;
    final isPremiumUser = PremiumHelper.isPremiumUser();
    final hasSubscription = widget.product!.hasSubscription ?? false;
    
    // Don't save progress for sample books unless they are purchased or have subscription access
    if (widget.isSample && !isPurchased && !(hasSubscription && isPremiumUser)) {
      return;
    }

    try {
      final currentPage = _currentPage;
      final totalPages = _pages.length;

      final progress = ReadingProgressModel(
        product: widget.product!,
        progress: totalPages > 0 ? currentPage / totalPages : 0,
        lastPosition: currentPage,
        lastReadAt: DateTime.now(),
        cachedEpubPath: widget.epubPath,
      );

      await _progressService!.saveProgress(progress);
    } catch (e) {
      // Handle error silently
    }
  }

  @override
  void dispose() {
    _saveProgress();
    _pageController?.dispose();
    _gridViewScrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadEpub() async {
    try {
      final bytes = await File(widget.epubPath).readAsBytes();
      final archive = ZipDecoder().decodeBytes(bytes);

      // Find the OPF file
      String? opfPath;
      for (final file in archive) {
        if (file.name.endsWith('.opf')) {
          opfPath = file.name;
          break;
        }
      }

      if (opfPath == null) throw Exception('OPF file not found');

      // Parse OPF file
      final opfContent =
          String.fromCharCodes(archive.findFile(opfPath)!.content as List<int>);
      final opfDoc = html_parser.parse(opfContent);

      // Find toc.ncx or toc.xhtml
      String? tocPath;
      String? tocId;

      // First try to find toc.ncx (EPUB 2)
      final tocSpine = opfDoc.querySelector('spine');
      if (tocSpine != null) {
        final toc = tocSpine.attributes['toc'];
        if (toc != null) {
          final tocItem = opfDoc.querySelector('item#${toc}');
          if (tocItem != null) {
            tocPath = tocItem.attributes['href'];
            tocId = toc;
          }
        }
      }

      // If not found, try to find toc.xhtml (EPUB 3)
      if (tocPath == null) {
        final tocItem = opfDoc.querySelector('item[properties="nav"]');
        if (tocItem != null) {
          tocPath = tocItem.attributes['href'];
          tocId = tocItem.attributes['id'];
        }
      }

      if (tocPath != null) {
        // Construct full path to toc file
        final opfDir = opfPath.substring(0, opfPath.lastIndexOf('/') + 1);
        final fullTocPath = opfDir + tocPath;
        final tocFile = archive.findFile(fullTocPath);

        if (tocFile != null) {
          final tocContent = utf8.decode(tocFile.content as List<int>);
          final tocDoc = html_parser.parse(tocContent);

          // Parse chapters from toc.ncx (EPUB 2)
          final navPoints = tocDoc.querySelectorAll('navPoint');
          if (navPoints.isNotEmpty) {
            _chapters = _parseNavPoints(navPoints);
          } else {
            // Parse chapters from toc.xhtml (EPUB 3)
            final nav = tocDoc.querySelector('nav[epub\\:type="toc"]');
            if (nav != null) {
              final ol = nav.querySelector('ol');
              if (ol != null) {
                _chapters = _parseNavItems(ol);
              }
            }
          }
        }
      }

      // Find cover image path (EPUB 2 and EPUB 3)
      String? coverHref;

      // EPUB 3: Check for <metadata><meta property="cover">...</meta></metadata>
      final coverMeta = opfDoc.querySelector('meta[property="cover"]');
      if (coverMeta != null) {
        final coverId = coverMeta.attributes['content'];
        if (coverId != null) {
          final coverItem = opfDoc.querySelector('item#${coverId}');
          if (coverItem != null) {
            coverHref = coverItem.attributes['href'];
          }
        }
      }

      // EPUB 2: Check for <metadata><meta name="cover" content="..."/></metadata>
      if (coverHref == null) {
        final coverMeta2 = opfDoc.querySelector('meta[name="cover"]');
        if (coverMeta2 != null) {
          final coverId = coverMeta2.attributes['content'];
          if (coverId != null) {
            final coverItem = opfDoc.querySelector('item#${coverId}');
            if (coverItem != null) {
              coverHref = coverItem.attributes['href'];
            }
          }
        }
      }

      // If cover href found, extract the image bytes
      if (coverHref != null) {
        final opfDir = opfPath.substring(0, opfPath.lastIndexOf('/') + 1);
        final fullCoverPath = opfDir + coverHref;
        final coverFile = archive.findFile(fullCoverPath);
        if (coverFile != null) {
          _coverImageBytes = coverFile.content as Uint8List;
        }
      }

      // Get content files from spine
      final spine = opfDoc.querySelector('spine');
      if (spine == null) throw Exception('Spine not found');

      final items = spine.querySelectorAll('itemref');

      // Use a list to store the paths to content files in order
      List<String> contentFilePaths = [];

      for (final item in items) {
        final idref = item.attributes['idref'];
        final manifestItem = opfDoc.querySelector('item#${idref}');
        if (manifestItem != null) {
          final href = manifestItem.attributes['href'];
          if (href != null) {
            // Store path relative to OPF directory
            _opfRelativeContentFilePaths.add(href);

            // Construct the full path to the content file relative to EPUB root
            final opfDir = opfPath.substring(0, opfPath.lastIndexOf('/') + 1);
            final contentFilePath = opfDir + href;
            contentFilePaths
                .add(contentFilePath); // Keep this list for reading files
          }
        }
      }

      // Clear previous pages and add cover as the first item if available
      _pages.clear();
      /*if (_coverImageBytes != null) {
        // Add a placeholder string for the cover page. 
        // The build method will check for the cover image at index 0.
        _pages.add('--COVER_PAGE--'); 
      }*/

      // Now read and process the content files in the correct order
      // Map content file paths to their order index for later page mapping
      final Map<String, int> contentFileOrder = {};
      int orderIndex = 0;

      // New list to store content units (HTML strings)
      List<String> _contentUnits = [];

      for (final contentFilePath in contentFilePaths) {
        final contentFile = archive.findFile(contentFilePath);
        if (contentFile != null) {
          // Store the base filename as the key
          final baseFileName = contentFilePath.split('/').last;
          contentFileOrder[baseFileName] = orderIndex++;

          // Decode bytes as UTF-8 before parsing HTML
          final rawHtmlContent = utf8.decode(contentFile.content as List<int>);

          // Clean the HTML content before adding it as a content unit
          final cleanedContent = _cleanHtmlContent(rawHtmlContent);
          if (cleanedContent.isNotEmpty && cleanedContent.trim().length > 10) {
            _contentUnits.add(cleanedContent);
          }
        }
      }

      // After processing content files, map chapter sources to page indices
      // We will map chapters to content unit indices first, then to page indices after pagination
      _mapChaptersToContentUnits(contentFilePaths);

      // Paginate the entire book content
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          // Paginate content units and store the result with unit index
          final paginatedPageData = _paginateContentUnits(_contentUnits);
          _paginatedPageData =
              paginatedPageData; // Store in a new state variable
          _pages.clear();
          _pageElementKeys.clear(); // Clear the new list for keys
          _contentFilePathToPageIndex.clear();

          // Initialize scroll controllers for each content page
          _pageScrollControllers.clear(); // Clear any existing controllers
          for (int i = 0; i < _paginatedPageData.length; i++) {
            // Use paginatedPageData length for accurate count
            _pageScrollControllers.add(ScrollController());
          }

          // Populate _pages and _contentFilePathToPageIndex from paginated page data
          for (int i = 0; i < _paginatedPageData.length; i++) {
            final pageData = _paginatedPageData[i];
            final pageHtml = pageData['html'] as String;
            final originalUnitIndex = pageData['unitIndex'] as int;
            // Use the OPF-relative file path as the map key
            final opfRelativeFilePath =
                _opfRelativeContentFilePaths[originalUnitIndex];

            // Map file path to the first page index it appears on
            if (!_contentFilePathToPageIndex.containsKey(opfRelativeFilePath)) {
              _contentFilePathToPageIndex[opfRelativeFilePath] =
                  _pages.length; // Map to the current index in _pages
            }

            _pages.add(pageHtml); // Add only the HTML content to _pages
            // Re-build rich content for this page to get the element ID keys and store them
            // This is inefficient as we are building twice. A better approach would be to
            // build the widgets and get keys *during* pagination, or pass the keys back
            // from _paginateContentUnits. For now, doing it here to move forward.
            final rebuiltPageData = _buildRichContent(
              pageHtml,
              contentPageIndex: i,
            );
            _pageElementKeys.add(
                rebuiltPageData['elementIdKeys'] as Map<String, GlobalKey>);
          }

          _currentPage = 0;
          _currentContent =
              _pages.isNotEmpty ? _pages[0] : l10n.noReadableContent;
          _mapChaptersToPages(); // Map chapter to actual page indices after pagination

          // Initialize scroll controllers for each content page
          // This needs to happen *after* _pages is populated and *inside* the setState
          // block to ensure controllers are available when PageView builds.
          setState(() {
            _pageScrollControllers.clear(); // Clear any existing controllers
            for (int i = 0; i < _pages.length; i++) {
              _pageScrollControllers.add(ScrollController());
            }
          });
        });
      });
    } catch (e) {
      debugPrint('Error initializing EPUB: $e');
      setState(() {
        _currentContent = 'Error loading EPUB: ${e.toString()}';
      });
    }
  }

  List<Chapter> _parseNavPoints(List<html_dom.Element> navPoints) {
    List<Chapter> chapters = [];
    for (final navPoint in navPoints) {
      final text = navPoint.querySelector('text')?.text ?? '';
      final src = navPoint.querySelector('content')?.attributes['src'] ?? '';
      final chapter = Chapter(title: text, src: src);

      // Recursively parse nested navPoints
      // OLD: final nestedNavPoints = navPoint.querySelectorAll(':scope > navPoint');
      // NEW: Only direct children with tag 'navPoint'
      final nestedNavPoints =
          navPoint.children.where((e) => e.localName == 'navPoint').toList();
      if (nestedNavPoints.isNotEmpty) {
        chapter.children = _parseNavPoints(nestedNavPoints);
      }
      chapters.add(chapter);
    }
    return chapters;
  }

  List<Chapter> _parseNavItems(html_dom.Element element) {
    List<Chapter> chapters = [];
    final items = element.children
        .where((e) => e.localName == 'li')
        .toList(); // Ensure only direct 'li' children

    for (final item in items) {
      final link = item.querySelector('a');
      if (link != null) {
        final title = link.text;
        final src = link.attributes['href'] ?? '';
        final chapter = Chapter(title: title, src: src);

        // Recursively parse nested lists (ol/ul)
        final nestedList = item.querySelector('ol') ?? item.querySelector('ul');
        if (nestedList != null) {
          chapter.children = _parseNavItems(nestedList);
        }
        chapters.add(chapter);
      }
    }

    return chapters;
  }

  void _changeFontSize(double delta) {
    setState(() {
      _fontSize = (_fontSize + delta).clamp(12.0, 32.0);
      _saveSettings();
    });
  }

  void _toggleNightMode() {
    setState(() {
      _isNightMode = !_isNightMode;
      _saveSettings();
    });
  }

  Future<void> _saveHighlights() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final data = jsonEncode(_highlights.map((h) => h.toJson()).toList());
      await prefs.setString('highlights', data);
    } catch (e) {
      // Handle save error silently
    }
  }

  // Convert a Flutter Color to a CSS hex string (e.g. "#FFAABB")
  String _colorToCss(Color color) {
    // color.value is 0xAARRGGBB; we want "#RRGGBB"
    final hex = color.value.toRadixString(16).padLeft(8, '0');
    return '#${hex.substring(2)}';
  }

  // Helper method to build rich text with highlights
  Widget _buildRichText(String html, int pageIndex) {
    final doc = html_parser.parse(html);
    final paragraphs = doc.querySelectorAll('p');
    List<Widget> paragraphWidgets = [];

    for (final p in paragraphs) {
      final pText = p.text;
      final pDirection =
          p.attributes['dir'] == 'rtl' ? TextDirection.rtl : TextDirection.ltr;

      // Get highlights for this paragraph
      final paragraphHighlights = _highlights.where((h) {
        return h.pageIndex == pageIndex &&
            h.start >= 0 &&
            h.end <= pText.length;
      }).toList();

      if (paragraphHighlights.isEmpty) {
        // No highlights, just add the text
        paragraphWidgets.add(
          SelectableText(
            pText,
            style: _baseStyle(),
            textDirection: pDirection,
            onSelectionChanged: (selection, cause) {
              if (selection.isValid && !selection.isCollapsed) {
                final selectedText =
                    pText.substring(selection.start, selection.end);
                _addHighlight(
                  selectedText,
                  selection.start,
                  selection.end,
                  pageIndex: pageIndex,
                );
              }
            },
          ),
        );
      } else {
        // Build TextSpan with highlights
        List<TextSpan> spans = [];
        int currentPos = 0;

        for (final highlight in paragraphHighlights) {
          // Add text before highlight
          if (highlight.start > currentPos) {
            spans.add(TextSpan(
              text: pText.substring(currentPos, highlight.start),
              style: _baseStyle(),
            ));
          }

          // Add highlighted text
          spans.add(TextSpan(
            text: pText.substring(highlight.start, highlight.end),
            style: _baseStyle().copyWith(
              backgroundColor: highlight.color,
            ),
          ));

          currentPos = highlight.end;
        }

        // Add remaining text
        if (currentPos < pText.length) {
          spans.add(TextSpan(
            text: pText.substring(currentPos),
            style: _baseStyle(),
          ));
        }

        paragraphWidgets.add(
          SelectableText.rich(
            TextSpan(children: spans),
            textDirection: pDirection,
            onSelectionChanged: (selection, cause) {
              if (selection.isValid && !selection.isCollapsed) {
                final selectedText =
                    pText.substring(selection.start, selection.end);
                _addHighlight(
                  selectedText,
                  selection.start,
                  selection.end,
                  pageIndex: pageIndex,
                );
              }
            },
          ),
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: paragraphWidgets,
    );
  }

  /// Normalize whitespace and line breaks for consistent text matching
  String _normalizeText(String text) {
    return text
        .replaceAll(RegExp(r'\s+'), ' ') // collapse multiple spaces
        .replaceAll(RegExp(r'[\n\r]+'), ' ') // replace line breaks with space
        .trim(); // trim leading/trailing spaces
  }

  // Helper method to print document structure for debugging
  void _printDocumentStructure(html_dom.Document doc) {
    debugPrint('[CustomEpubReader] Document structure:');
    debugPrint('Body exists: ${doc.body != null}');
    debugPrint('Head exists: ${doc.head != null}');
    debugPrint('Document text: ${doc.text}');
    debugPrint('Document outer HTML: ${doc.outerHtml}');
  }

  // Helper method to get plain text from HTML
  String _getPlainText(String html) {
    final doc = html_parser.parse(html);
    return doc.text ?? '';
  }

  // Helper method to find text position in HTML
  Map<String, int>? _findTextPosition(String html, String text) {
    final fragment = html_parser.parseFragment(html);
    final displayHtml =
        fragment.querySelector('body')?.innerHtml ?? fragment.outerHtml;
    final displayText = html_parser.parseFragment(displayHtml).text ?? '';

    final normalizedDisplay = _normalizeText(displayText);
    final normalizedSel = _normalizeText(text);

    if (normalizedSel.isEmpty) return null;

    final start = normalizedDisplay.indexOf(normalizedSel);
    if (start == -1) return null;

    return {'start': start, 'end': start + normalizedSel.length};
  }

  // Helper method to validate text selection
  bool _isValidTextSelection(String html, String text, int start, int end) {
    final plainText = _getPlainText(html);
    if (start < 0 || end > plainText.length || start >= end) {
      return false;
    }
    final selectedText = plainText.substring(start, end);
    return selectedText == text;
  }

  void _deleteHighlight(int index) {
    setState(() {
      _highlights.removeAt(index);
    });
    _saveHighlights();
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: _isNightMode 
          ? Colors.grey[900]
          : Colors.white,
      builder: (_) => DraggableScrollableSheet(
        expand: false,
        builder: (context, scrollController) {
          return Container(
            color: _isNightMode 
                ? Colors.grey[900]
                : Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Drag handle and title row
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: _isNightMode ? Colors.grey[600] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                // Tab Bar
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: _isNightMode ? Colors.grey[700]! : Colors.grey[300]!,
                        width: 1,
                      ),
                    ),
                  ),
                child: TabBar(
                  controller: _tabController,
                  tabs: [
                    Tab(text: l10n.chapters),
                    Tab(text: l10n.highlights),
                    Tab(text: l10n.saved),
                  ],
                  indicatorColor:
                      widget.themeColor, // Use theme color for indicator
                  labelColor: widget
                      .themeColor, // Use theme color for selected tab label
                  unselectedLabelColor: _isNightMode
                      ? Colors.white70
                      : Colors
                          .black54, // Use a suitable color for unselected labels
                  onTap: (index) {
                    setState(() {
                      _bottomSheetTabIndex = index;
                    });
                  },
                ),
              ),
              // Tab Content
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Chapters Tab
                    ListView.builder(
                      controller: scrollController,
                      itemCount: _chapters
                          .length, // Assuming _chapters now holds top-level chapters
                      itemBuilder: (context, index) {
                        final chapter = _chapters[index];

                        // Build a recursive widget for the chapter and its children
                        return _buildChapterTreeItem(chapter);
                      },
                    ),
                    // Highlights Tab
                    Column(
                      children: [
                        if (_highlights.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextButton.icon(
                              icon: const Icon(Icons.delete_sweep, size: 18),
                              label: Text(l10n.deleteAllHighlights),
                              onPressed: () {
                                setState(() {
                                  _highlights.clear();
                                  _saveHighlights();
                                });
                                Navigator.pop(context);
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.red,
                              ),
                            ),
                          ),
                        Expanded(
                          child: ListView.separated(
                            controller: scrollController,
                            itemCount: _highlights.length,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    Divider(
                                        height: 1, 
                                        color: _isNightMode 
                                            ? Colors.grey[700]! 
                                            : const Color(0xFFE0E0E0)),
                            itemBuilder: (context, i) {
                              final h = _highlights[i];
                              return ListTile(
                                leading: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                      color: h.color, shape: BoxShape.circle),
                                ),
                                title: Text(
                                  h.text.length > 30
                                      ? '${h.text.substring(0, 30)}...'
                                      : h.text,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: _isNightMode ? Colors.white : Colors.black,
                                  ),
                                ),
                                subtitle: Text(
                                  DateFormat('yyyy-MM-dd – kk:mm')
                                      .format(h.timestamp),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: _isNightMode ? Colors.white70 : Colors.black54,
                                  ),
                                ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: _isNightMode ? Colors.white70 : Colors.black54,
                            ),
                            onPressed: () {
                              _deleteHighlight(i);
                              Navigator.pop(context);
                            },
                          ),
                                onTap: () {
                                  Navigator.pop(context);
                                  final targetPage = h.pageIndex +
                                      (_coverImageBytes != null ? 1 : 0);
                                  _pageController?.jumpToPage(targetPage);
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    // Saved Pages Tab
                    ListView.builder(
                      controller: scrollController,
                      itemCount: _savedPages.length,
                      itemBuilder: (context, index) {
                        final pageIndex = _savedPages.elementAt(index);
                        final contentPageIndex = _coverImageBytes != null
                            ? pageIndex - 1
                            : pageIndex;
                        String pagePreview = '';
                        if (contentPageIndex >= 0 &&
                            contentPageIndex < _pages.length) {
                          // Parse HTML to get plain text for preview
                          final pageDoc =
                              html_parser.parse(_pages[contentPageIndex]);
                          pagePreview = pageDoc.body?.text ??
                              ''; // Get text from the body

                          pagePreview = pagePreview
                              .replaceAll(RegExp(r'\n\s*'), ' ')
                              .trim();
                          if (pagePreview.length > 50) {
                            pagePreview = '${pagePreview.substring(0, 50)}...';
                          }
                        }
                        return ListTile(
                          leading:
                              Icon(Icons.bookmark, color: widget.themeColor),
                          title: Text(
                            l10n.pageNumber(pageIndex + 1),
                            style: TextStyle(
                              color: _isNightMode ? Colors.white : Colors.black,
                            ),
                          ),
                          subtitle: Text(
                            pagePreview,
                            style: TextStyle(
                              color: _isNightMode
                                  ? Colors.white70
                                  : Colors.black54,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.delete_outline,
                              color: _isNightMode ? Colors.white70 : Colors.black54,
                            ),
                            onPressed: () {
                              setState(() {
                                _savedPages.remove(pageIndex);
                                _savePage();
                              });
                            },
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            _pageController?.jumpToPage(pageIndex);
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildChapterTreeItem(Chapter chapter, {int level = 0}) {
    // Use ExpansionTile for chapters with children, ListTile otherwise
    if (chapter.children.isNotEmpty) {
      return ExpansionTile(
        key: PageStorageKey(
            chapter.title + chapter.src), // Unique key for state persistence
        leading: level > 0
            ? null
            : null, // Removed bookmark icon, no leading icon for top level either
        title: Padding(
          padding: EdgeInsetsDirectional.only(
              start: level * 16.0), // Indent based on level
          child: InkWell(
            onTap: () {
              if (chapter.pageIndex != null) {
                Navigator.pop(context);
                final targetPage = _coverImageBytes != null
                    ? chapter.pageIndex! + 1
                    : chapter.pageIndex!;
                _pageController?.jumpToPage(targetPage);
                setState(() {
                  _currentPage = targetPage;
                });
              }
            },
            child: Text(
              chapter.title,
              style: TextStyle(
                color: _isNightMode ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        children: chapter.children.map((child) {
          // Recursively build tree items for children
          return _buildChapterTreeItem(child, level: level + 1);
        }).toList(),
        onExpansionChanged: (bool expanded) {
          // Optional: handle expansion state changes
        },
        tilePadding:
            EdgeInsets.symmetric(horizontal: 16.0), // Added horizontal padding
        controlAffinity: ListTileControlAffinity
            .leading, // Place expansion arrow at the start
      );
    } else {
      // Regular ListTile for chapters without children
      return ListTile(
        leading: level > 0 ? null : null, // Removed bookmark icon
        title: Padding(
          padding: EdgeInsetsDirectional.only(
              start: level * 16.0), // Indent based on level
          child: Text(
            chapter.title,
            style: TextStyle(
              color: _isNightMode ? Colors.white : Colors.black,
            ),
          ),
        ),
        onTap: () {
          if (chapter.pageIndex != null) {
            Navigator.pop(context);
            // Adjust for cover page if present
            final targetPage = _coverImageBytes != null
                ? chapter.pageIndex! + 1
                : chapter.pageIndex!;
            _pageController?.jumpToPage(targetPage);
            setState(() {
              _currentPage = targetPage;
            });
          }
        },
        contentPadding:
            EdgeInsets.symmetric(horizontal: 16.0), // Added horizontal padding
      );
    }
  }

  Widget _buildCustomBottomBar() {
    // Calculate total pages, including cover if present
    final totalPages = _pages.length + (_coverImageBytes != null ? 1 : 0);
    // Calculate percentage read (handle division by zero if totalPages is 0 or 1)
    final percentage =
        totalPages > 1 ? ((_currentPage / (totalPages - 1)) * 100).toInt() : 0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      color: _isNightMode ? Colors.black : Colors.white,
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left circular button (Grid icon)
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _isNightMode ? Colors.grey[800] : Colors.grey[300],
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(Icons.grid_view, color: widget.themeColor, size: 18),
                onPressed: () {
                  setState(() {
                    _showGridView = !_showGridView;
                  });
                  if (_showGridView) {
                    Future.delayed(const Duration(milliseconds: 100), () {
                      if (_gridViewScrollController.hasClients) {
                        final RenderBox gridBox =
                            context.findRenderObject() as RenderBox;
                        final double gridWidth =
                            gridBox.size.width - (12.0 * 2);
                        const int crossAxisCount = 3;
                        const double crossAxisSpacing = 8.0;
                        const double mainAxisSpacing = 8.0;
                        const double childAspectRatio = 0.6;

                        final double itemWidth = (gridWidth -
                                (crossAxisCount - 1) * crossAxisSpacing) /
                            crossAxisCount;
                        final double itemHeight = itemWidth / childAspectRatio;

                        final int rowIndex = _currentPage ~/ crossAxisCount;
                        final double offset =
                            rowIndex * (itemHeight + mainAxisSpacing);

                        _gridViewScrollController.animateTo(
                          offset,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      }
                    });
                  } else {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (_pageController != null &&
                          _pageController!.hasClients) {
                        _pageController!.jumpToPage(_currentPage);
                      }
                    });
                  }
                },
                tooltip: l10n.gridView,
              ),
            ),
            // Central rounded container with page info and navigation
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: Colors.grey[850],
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.arrow_back_ios,
                        color: widget.themeColor, size: 16),
                    onPressed: _currentPage > 0 ? _goToPreviousPage : null,
                    tooltip: l10n.previousPage,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    l10n.pageProgress(_currentPage + 1, totalPages.toString(), percentage.toString()),
                    style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(width: 4),
                  IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.arrow_forward_ios,
                        color: widget.themeColor, size: 16),
                    onPressed:
                        _currentPage < totalPages - 1 ? _goToNextPage : null,
                    tooltip: l10n.nextPage,
                  ),
                ],
              ),
            ),
            // Right circular button (List icon - Now shows bottom sheet with tabs)
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: _isNightMode ? Colors.white54 : Colors.black54,
                    width: 1.0),
                color: Colors.transparent,
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(Icons.list,
                    color: _isNightMode ? Colors.white : Colors.black,
                    size: 18),
                onPressed: _showBottomSheet,
                tooltip: l10n.chaptersAndHighlights,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper to convert HTML to plain text for selection/highlight
  String _plainText(String html) {
    return html_parser.parseFragment(html).text ?? '';
  }

  void _handlePaginationComplete() {
    if (_pendingTargetPage != null) {
      final targetPage = _pendingTargetPage!;
      if (targetPage >= 0 && targetPage < _pages.length) {
        setState(() {
          _currentPage = targetPage;
        });

        // Wait for the next frame to ensure pages are loaded
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_pageController != null && _pageController!.hasClients) {
            _pageController!.jumpToPage(_currentPage);
          } else {
            // Try again after a short delay
            Future.delayed(const Duration(milliseconds: 100), () {
              if (_pageController != null && _pageController!.hasClients) {
                _pageController!.jumpToPage(_currentPage);
              }
            });
          }
        });
      }
      _pendingTargetPage = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            !_isInitialized) {
          return const Center(child: CircularProgressIndicator());
        }

        // Create PageController with initial page if not already created
        _pageController ??= PageController(initialPage: _currentPage);

        return WillPopScope(
          onWillPop: () async {
            await _saveProgress();
            return true;
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                widget.product?.name ?? l10n.book,
                overflow: TextOverflow.ellipsis,
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    _savedPages.contains(_currentPage)
                        ? Icons.bookmark
                        : Icons.bookmark_border,
                    color: _savedPages.contains(_currentPage)
                        ? widget.themeColor
                        : null,
                  ),
                  onPressed: _savePage,
                ),
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: _showSettings,
                ),
              ],
            ),
            body: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _showGridView
                  ? _buildPageGridView()
                  : FutureBuilder(
                      future: _initFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        if (snapshot.hasError) {
                          return Center(
                            child:
                                Text(l10n.errorLoadingBookWithMessage(snapshot.error.toString())),
                          );
                        }

                        if (_pages.isEmpty) {
                          return Center(
                            child: Text(l10n.noReadableContent),
                          );
                        }

                        return Container(
                          color: _isNightMode ? const Color(0xFF0F0F0F) : Colors.white,
                          child: Column(
                            children: [
                              Expanded(
                                child: PageView.builder(
                                  controller: _pageController,
                                  itemCount: _pages.length +
                                      (_coverImageBytes != null ? 1 : 0),
                                  scrollDirection: _scrollDirection,
                                  onPageChanged: (index) {
                                    setState(() {
                                      _currentPage = index;
                                    });
                                  },
                                  itemBuilder: (context, index) {
                                    if (index == 0 &&
                                        _coverImageBytes != null) {
                                      return Center(
                                        child: Image.memory(
                                          _coverImageBytes!,
                                          fit: BoxFit.contain,
                                        ),
                                      );
                                    } else {
                                      final contentPageIndex =
                                          _coverImageBytes != null
                                              ? index - 1
                                              : index;
                                      if (contentPageIndex < 0 ||
                                          contentPageIndex >= _pages.length) {
                                        return const SizedBox.shrink();
                                      }

                                      return SingleChildScrollView(
                                        controller: _pageScrollControllers[
                                            contentPageIndex],
                                        padding: const EdgeInsets.all(16),
                                        child: _buildPageContent(
                                          _pages[contentPageIndex],
                                          contentPageIndex,
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
            ),
            bottomNavigationBar: _buildCustomBottomBar(),
          ),
        );
      },
    );
  }

  void _showSettings() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: BoxDecoration(
            color: _isNightMode ? Colors.grey[900] : Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Drag handle
              Container(
                margin: const EdgeInsets.only(top: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Title
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  l10n.settings,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: _isNightMode ? Colors.white : Colors.black,
                  ),
                ),
              ),
              const Divider(height: 1),
              // Settings content
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    // Font Family Section
                    _buildSectionTitle(l10n.fontType),
                    Container(
                      height: 50,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: _availableFonts.entries.map((entry) {
                          final isSelected = _fontFamily == entry.key;
                          return Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: ChoiceChip(
                              label: Text(
                                entry.value,
                                style: TextStyle(
                                  fontFamily: entry.key,
                                  color: isSelected
                                      ? Colors.white
                                      : (_isNightMode
                                          ? Colors.white70
                                          : Colors.black87),
                                ),
                              ),
                              selected: isSelected,
                              onSelected: (selected) {
                                if (selected) {
                                  setModalState(() {
                                    _fontFamily = entry.key;
                                  });
                                  setState(() {
                                    _fontFamily = entry.key;
                                    _saveSettings();
                                  });
                                }
                              },
                              backgroundColor: _isNightMode
                                  ? Colors.grey[800]
                                  : Colors.grey[200],
                              selectedColor: widget.themeColor,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Font Size Section
                    _buildSectionTitle(l10n.fontSize),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: () {
                            setModalState(() {
                              _changeFontSize(-2);
                            });
                          },
                        ),
                        Text(
                          '${_fontSize.toInt()}',
                          style: TextStyle(
                            fontSize: 16,
                            color: _isNightMode ? Colors.white : Colors.black,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline),
                          onPressed: () {
                            setModalState(() {
                              _changeFontSize(2);
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Line Spacing Section
                    _buildSectionTitle(l10n.lineSpacing),
                    Slider(
                      value: _lineSpacing,
                      min: 1.0,
                      max: 3.0,
                      divisions: 4,
                      label: _lineSpacing.toStringAsFixed(1),
                      onChanged: (value) {
                        setModalState(() {
                          _lineSpacing = value;
                        });
                        setState(() {
                          _changeLineSpacing(value);
                        });
                      },
                      activeColor: widget.themeColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(l10n.low,
                              style: TextStyle(
                                  color: _isNightMode
                                      ? Colors.white70
                                      : Colors.black54)),
                          Text(l10n.high,
                              style: TextStyle(
                                  color: _isNightMode
                                      ? Colors.white70
                                      : Colors.black54)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Font Weight Section
                    _buildSectionTitle(l10n.fontWeight),
                    Container(
                      height: 50,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _buildFontWeightOption(
                              l10n.normal, FontWeight.w400, setModalState),
                          _buildFontWeightOption(
                              l10n.medium, FontWeight.w500, setModalState),
                          _buildFontWeightOption(
                              l10n.bold, FontWeight.w700, setModalState),
                          _buildFontWeightOption(
                              l10n.extraBold, FontWeight.w800, setModalState),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Theme Mode Section
                    _buildSectionTitle(l10n.displayMode),
                    SwitchListTile(
                      title: Text(
                        l10n.nightMode,
                        style: TextStyle(
                          color: _isNightMode ? Colors.white : Colors.black,
                        ),
                      ),
                      value: _isNightMode,
                      onChanged: (value) {
                        setModalState(() {
                          _isNightMode = value;
                        });
                        setState(() {
                          _isNightMode = value;
                          _saveSettings();
                        });
                      },
                      activeColor: widget.themeColor,
                    ),
                    const SizedBox(height: 24),

                    // Reading Direction Section
                    _buildSectionTitle(l10n.readingDirection),
                    SwitchListTile(
                      title: Text(
                        l10n.vertical,
                        style: TextStyle(
                          color: _isNightMode ? Colors.white : Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        l10n.switchToVerticalReading,
                        style: TextStyle(
                          color: _isNightMode ? Colors.white70 : Colors.black54,
                        ),
                      ),
                      value: _scrollDirection == Axis.vertical,
                      onChanged: (value) {
                        setModalState(() {
                          _scrollDirection =
                              value ? Axis.vertical : Axis.horizontal;
                        });
                        setState(() {
                          _scrollDirection =
                              value ? Axis.vertical : Axis.horizontal;
                          _pageController?.dispose();
                          _pageController =
                              PageController(initialPage: _currentPage);
                        });
                      },
                      activeColor: widget.themeColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: _isNightMode ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  Widget _buildFontWeightOption(
      String label, FontWeight weight, StateSetter setModalState) {
    final isSelected = _fontWeight == weight;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(
          label,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected
                ? Colors.white
                : (_isNightMode ? Colors.white70 : Colors.black87),
          ),
        ),
        selected: isSelected,
        onSelected: (selected) {
          if (selected) {
            setModalState(() {
              _fontWeight = weight;
            });
            setState(() {
              _fontWeight = weight;
              _saveSettings();
            });
          }
        },
        backgroundColor: _isNightMode ? Colors.grey[800] : Colors.grey[200],
        selectedColor: widget.themeColor,
      ),
    );
  }

  Widget _buildPageGridView() {
    // Calculate total pages, including cover if present
    final totalPages = _pages.length + (_coverImageBytes != null ? 1 : 0);

    return GridView.builder(
      controller: _gridViewScrollController,
      padding: const EdgeInsets.all(12.0), // Adjusted padding for better look
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Number of columns
        crossAxisSpacing: 8.0, // Spacing between columns
        mainAxisSpacing: 8.0, // Spacing between rows
        childAspectRatio: 0.6, // Aspect ratio of each grid item
      ),
      itemCount: totalPages,
      itemBuilder: (context, index) {
        // Calculate the actual index in the _pages list for content pages
        final contentPageIndex = _coverImageBytes != null && index == 0
            ? -1
            : (_coverImageBytes != null ? index - 1 : index);

        // Get content snippet for preview (handle cover page and valid content pages)
        String pageContentSnippet = '';
        if (contentPageIndex == -1) {
          pageContentSnippet = 'Cover Page'; // Placeholder for cover
        } else if (contentPageIndex >= 0 && contentPageIndex < _pages.length) {
          // Parse HTML to get plain text for preview
          final pageDoc = html_parser.parse(_pages[contentPageIndex]);
          String rawText = pageDoc.body?.text ?? ''; // Get text from the body

          // Take a snippet of the page text, clean up some newlines for display
          pageContentSnippet = rawText.replaceAll(RegExp(r'\n\s*'), ' ').trim();
          // Truncate snippet if too long for preview
          if (pageContentSnippet.length > 100) {
            // Limit snippet length
            pageContentSnippet = '${pageContentSnippet.substring(0, 100)}...';
          }
        }

        return GestureDetector(
          onTap: () {
            setState(() {
              _showGridView = false;
            });
            // Navigate to the tapped page and switch back to PageView
            // Use addPostFrameCallback to ensure PageView is built before jumping
            WidgetsBinding.instance.addPostFrameCallback((_) {
              // Wait until the controller has clients before jumping
              if (_pageController != null && _pageController!.hasClients) {
                _pageController!.jumpToPage(index);
              } else {
                // If no clients yet, add another post-frame callback
                // This can happen if the PageView hasn't fully rendered/attached yet
                WidgetsBinding.instance.addPostFrameCallback((__) {
                  if (_pageController != null && _pageController!.hasClients) {
                    _pageController!.jumpToPage(index);
                  }
                });
              }
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: _isNightMode ? Colors.grey[700] : Colors.grey[100],
              borderRadius: BorderRadius.circular(8.0),
              border: _currentPage == index
                  ? Border.all(color: widget.themeColor, width: 2.0)
                  : null, // Highlight current page
            ),
            child: Padding(
              padding:
                  const EdgeInsets.all(8.0), // Padding inside the grid item
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.stretch, // Stretch text to fill width
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // Space out content and page number
                children: [
                  // Page Content Preview (basic text for now)
                  Expanded(
                    child: Text(
                      pageContentSnippet,
                      style: TextStyle(
                        fontSize: 10, // Smaller font for snippet
                        color: _isNightMode ? Colors.white70 : Colors.black87,
                      ),
                      maxLines: 8, // Limit lines to prevent overflow
                      overflow: TextOverflow
                          .ellipsis, // Show ellipsis if content is truncated
                    ),
                  ),
                  // Page Number
                  Align(
                    alignment: Alignment
                        .bottomRight, // Align page number to bottom right
                    child: Text(
                      '${index + 1}', // Display 1-based page number
                      style: TextStyle(
                        fontSize: 11, // Slightly smaller font for page number
                        fontWeight: FontWeight.bold,
                        color: _isNightMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _changeLineSpacing(double value) {
    setState(() {
      _lineSpacing = value;
      _saveSettings();
    });
  }

  void _goToNextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController?.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
      _saveProgress(); // Save progress after page change
    }
  }

  void _goToPreviousPage() {
    if (_currentPage > 0) {
      _pageController?.previousPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
      _saveProgress(); // Save progress after page change
    }
  }

  void _mapChaptersToPages() {
    for (final chapter in _chapters) {
      // Extract the file path and element ID from the src
      final parts = chapter.src.split('#');
      final opfRelativeFilePath = parts[0];
      final targetElementId = parts.length > 1 ? parts[1] : null;

      // Use the contentUnitIndex determined during content unit mapping
      final contentUnitIndex =
          chapter.contentUnitIndex; // Use the pre-calculated index

      if (contentUnitIndex != null &&
          contentUnitIndex < _opfRelativeContentFilePaths.length) {
        // Get the OPF relative file path from the list using the content unit index
        final actualOpfRelativeFilePath =
            _opfRelativeContentFilePaths[contentUnitIndex];

        // Find the page that contains this content unit (using the actual file path)
        final pageIndex =
            _contentFilePathToPageIndex[actualOpfRelativeFilePath];

        if (pageIndex != null) {
          // If there's a target element ID, try to find the specific page containing it
          // For now, we map to the start of the content unit's first page.
          // TODO: Implement logic to find page with element ID if targetElementId is not null
          chapter.pageIndex =
              pageIndex; // Map to the start of the file's first page
        }
      }
    }
  }

  // New method to map chapters to content unit indices
  void _mapChaptersToContentUnits(List<String> contentFilePaths) {
    // Create a map of base filenames to their content unit indices
    final Map<String, int> baseFileNameToContentUnitIndex = {};
    int contentUnitIndex = 0;
    for (final contentFilePath in contentFilePaths) {
      final baseFileName = contentFilePath.split('/').last;
      baseFileNameToContentUnitIndex[baseFileName] = contentUnitIndex++;
    }

    // Map chapters using their src attribute to content unit indices
    for (final chapter in _chapters) {
      if (chapter.src.isNotEmpty) {
        String cleanSrc = chapter.src.split('#').first;
        while (cleanSrc.startsWith('/')) {
          cleanSrc = cleanSrc.substring(1);
        }

        // Extract the base filename from the src
        final baseFileName = cleanSrc.split('/').last;

        final unitIndex = baseFileNameToContentUnitIndex[baseFileName];
        if (unitIndex != null) {
          chapter.contentUnitIndex = unitIndex;
        }
      }
    }

    // Process child chapters recursively
    void processChildChapters(List<Chapter> chapters) {
      for (final chapter in chapters) {
        if (chapter.children.isNotEmpty) {
          processChildChapters(chapter.children);
        }
      }
    }

    processChildChapters(_chapters);
  }

  // New method to paginate content units into pages
  // This will now return a list of objects that include page content and original content unit index
  List<Map<String, dynamic>> _paginateContentUnits(List<String> contentUnits) {
    List<Map<String, dynamic>> paginatedPages = [];
    _pageTexts.clear();
    final media = MediaQuery.of(context).size;
    final padding = 16.0;
    final availableWidth = media.width - padding * 2;
    final availableHeight = media.height -
        kToolbarHeight -
        kBottomNavigationBarHeight -
        padding * 2;
    final baseStyle = TextStyle(
      fontSize: _fontSize,
      fontFamily: _fontFamily,
      fontWeight: _fontWeight,
      height: _lineSpacing,
      color: _isNightMode ? Colors.white : Colors.black,
    );
    int globalOffset = 0;
    for (int contentUnitIndex = 0;
        contentUnitIndex < contentUnits.length;
        contentUnitIndex++) {
      final htmlContent = contentUnits[contentUnitIndex];
      final doc = html_parser.parseFragment(htmlContent);
      final nodes = List<html_dom.Node>.from(doc.nodes);
      final blocks = _groupNodesByHeading(nodes);
      final tp = TextPainter(textDirection: TextDirection.rtl, maxLines: null);
      for (final block in blocks) {
        List<html_dom.Node> headingNodes = [];
        List<html_dom.Node> restNodes = [];
        if (block.isNotEmpty &&
            block[0] is html_dom.Element &&
            (block[0] as html_dom.Element).localName != null &&
            ((block[0] as html_dom.Element).localName!.startsWith('h'))) {
          headingNodes.add(block[0]);
          restNodes = block.sublist(1);
        } else {
          restNodes = block;
        }
        double blockHeight = 0.0;
        int blockPlainTextLength = 0;
        String blockText = '';
        for (final node in block) {
          final metrics =
              _estimateNodeMetrics(node, baseStyle, tp, availableWidth);
          blockHeight += metrics['height'];
          blockPlainTextLength += metrics['plainTextLength'] as int;
          blockText += metrics['plainText'] as String;
        }
        if (blockHeight <= availableHeight) {
          if (blockText.trim().isNotEmpty) {
            paginatedPages.add({
              'html': _serializeNodesToHtml(block),
              'unitIndex': contentUnitIndex,
              'globalPlainTextOffset': globalOffset,
            });
            _pageTexts.add(blockText);
            globalOffset += blockPlainTextLength;
          }
          continue;
        }
        // اگر بلاک بزرگ بود: عنوان + اولین پاراگراف را با هم در یک صفحه قرار بده
        if (headingNodes.isNotEmpty && restNodes.isNotEmpty) {
          // محاسبه ارتفاع عنوان
          double headingHeight = 0.0;
          int headingPlainTextLength = 0;
          String headingText = '';
          for (final node in headingNodes) {
            final metrics =
                _estimateNodeMetrics(node, baseStyle, tp, availableWidth);
            headingHeight += metrics['height'];
            headingPlainTextLength += metrics['plainTextLength'] as int;
            headingText += metrics['plainText'] as String;
          }
          // محاسبه ارتفاع اولین پاراگراف
          final firstParaNode = restNodes[0];
          final paraMetrics = _estimateNodeMetrics(
              firstParaNode, baseStyle, tp, availableWidth);
          double paraHeight = paraMetrics['height'];
          int paraPlainTextLength = paraMetrics['plainTextLength'] as int;
          String paraText = paraMetrics['plainText'] as String;
          if (headingHeight + paraHeight <= availableHeight) {
            // عنوان + پاراگراف کامل
            String firstPageText = headingText + paraText;
            if (firstPageText.trim().isNotEmpty) {
              paginatedPages.add({
                'html': _serializeNodesToHtml([...headingNodes, firstParaNode]),
                'unitIndex': contentUnitIndex,
                'globalPlainTextOffset': globalOffset,
              });
              _pageTexts.add(firstPageText);
              globalOffset += headingPlainTextLength + paraPlainTextLength;
            }
            // بقیه پاراگراف‌ها را عادی صفحه‌بندی کن
            List<html_dom.Node> currentPageNodes = [];
            double currentHeight = 0.0;
            int currentPagePlainTextLength = 0;
            String currentPageText = '';
            for (int i = 1; i < restNodes.length; i++) {
              final node = restNodes[i];
              final metrics =
                  _estimateNodeMetrics(node, baseStyle, tp, availableWidth);
              if (currentHeight + metrics['height'] > availableHeight &&
                  currentPageNodes.isNotEmpty) {
                if (currentPageText.trim().isNotEmpty) {
                  paginatedPages.add({
                    'html': _serializeNodesToHtml(currentPageNodes),
                    'unitIndex': contentUnitIndex,
                    'globalPlainTextOffset': globalOffset,
                  });
                  _pageTexts.add(currentPageText);
                  globalOffset += currentPagePlainTextLength;
                }
                currentPageNodes = [];
                currentHeight = 0.0;
                currentPagePlainTextLength = 0;
                currentPageText = '';
              }
              currentPageNodes.add(node);
              currentHeight += metrics['height'];
              currentPagePlainTextLength += metrics['plainTextLength'] as int;
              currentPageText += metrics['plainText'] as String;
            }
            if (currentPageNodes.isNotEmpty &&
                currentPageText.trim().isNotEmpty) {
              paginatedPages.add({
                'html': _serializeNodesToHtml(currentPageNodes),
                'unitIndex': contentUnitIndex,
                'globalPlainTextOffset': globalOffset,
              });
              _pageTexts.add(currentPageText);
              globalOffset += currentPagePlainTextLength;
            }
            continue;
          } else if (headingHeight < availableHeight) {
            // عنوان + بخشی از پاراگراف (تا جایی که جا می‌شود)
            // تخمین تعداد کاراکتر مجاز از پاراگراف
            int maxParaChars = paraText.length;
            int low = 0, high = maxParaChars, best = 0;
            while (low <= high) {
              int mid = (low + high) ~/ 2;
              String paraPart = paraText.substring(0, mid);
              tp.text = TextSpan(text: paraPart, style: baseStyle);
              tp.layout(maxWidth: availableWidth);
              double partHeight = tp.height;
              if (headingHeight + partHeight <= availableHeight) {
                best = mid;
                low = mid + 1;
              } else {
                high = mid - 1;
              }
            }
            String paraPart1 = paraText.substring(0, best);
            String paraPart2 = paraText.substring(best);
            // صفحه اول: عنوان + بخش اول پاراگراف
            String firstPageText = headingText + paraPart1;
            if (firstPageText.trim().isNotEmpty) {
              // ساخت نود جدید برای بخش اول پاراگراف
              final paraElement = (firstParaNode is html_dom.Element)
                  ? html_dom.Element.tag(firstParaNode.localName ?? 'p')
                  : html_dom.Element.tag('p');
              paraElement.text = paraPart1;
              paginatedPages.add({
                'html': _serializeNodesToHtml([...headingNodes, paraElement]),
                'unitIndex': contentUnitIndex,
                'globalPlainTextOffset': globalOffset,
              });
              _pageTexts.add(firstPageText);
              globalOffset += headingPlainTextLength + paraPart1.length;
            }
            // صفحه بعد: ادامه پاراگراف + بقیه پاراگراف‌ها
            if (paraPart2.trim().isNotEmpty) {
              final paraElement2 = (firstParaNode is html_dom.Element)
                  ? html_dom.Element.tag(firstParaNode.localName ?? 'p')
                  : html_dom.Element.tag('p');
              paraElement2.text = paraPart2;
              List<html_dom.Node> currentPageNodes = [paraElement2];
              double currentHeight = 0.0;
              int currentPagePlainTextLength = paraPart2.length;
              String currentPageText = paraPart2;
              for (int i = 1; i < restNodes.length; i++) {
                final node = restNodes[i];
                final metrics =
                    _estimateNodeMetrics(node, baseStyle, tp, availableWidth);
                if (currentHeight + metrics['height'] > availableHeight &&
                    currentPageNodes.isNotEmpty) {
                  if (currentPageText.trim().isNotEmpty) {
                    paginatedPages.add({
                      'html': _serializeNodesToHtml(currentPageNodes),
                      'unitIndex': contentUnitIndex,
                      'globalPlainTextOffset': globalOffset,
                    });
                    _pageTexts.add(currentPageText);
                    globalOffset += currentPagePlainTextLength;
                  }
                  currentPageNodes = [];
                  currentHeight = 0.0;
                  currentPagePlainTextLength = 0;
                  currentPageText = '';
                }
                currentPageNodes.add(node);
                currentHeight += metrics['height'];
                currentPagePlainTextLength += metrics['plainTextLength'] as int;
                currentPageText += metrics['plainText'] as String;
              }
              if (currentPageNodes.isNotEmpty &&
                  currentPageText.trim().isNotEmpty) {
                paginatedPages.add({
                  'html': _serializeNodesToHtml(currentPageNodes),
                  'unitIndex': contentUnitIndex,
                  'globalPlainTextOffset': globalOffset,
                });
                _pageTexts.add(currentPageText);
                globalOffset += currentPagePlainTextLength;
              }
            }
            continue;
          } else {
            // اگر حتی عنوان هم جا نشد (خیلی نادر)
            if (headingText.trim().isNotEmpty) {
              paginatedPages.add({
                'html': _serializeNodesToHtml(headingNodes),
                'unitIndex': contentUnitIndex,
                'globalPlainTextOffset': globalOffset,
              });
              _pageTexts.add(headingText);
              globalOffset += headingPlainTextLength;
            }
            // اولین پاراگراف را هم جدا صفحه‌بندی کن
            List<html_dom.Node> firstParaNodes = [firstParaNode];
            double paraHeight = 0.0;
            int paraPlainTextLength = 0;
            String paraText = '';
            for (final node in firstParaNodes) {
              final metrics =
                  _estimateNodeMetrics(node, baseStyle, tp, availableWidth);
              paraHeight += metrics['height'];
              paraPlainTextLength += metrics['plainTextLength'] as int;
              paraText += metrics['plainText'] as String;
            }
            if (paraText.trim().isNotEmpty) {
              paginatedPages.add({
                'html': _serializeNodesToHtml(firstParaNodes),
                'unitIndex': contentUnitIndex,
                'globalPlainTextOffset': globalOffset,
              });
              _pageTexts.add(paraText);
              globalOffset += paraPlainTextLength;
            }
            // بقیه پاراگراف‌ها را عادی صفحه‌بندی کن
            List<html_dom.Node> currentPageNodes = [];
            double currentHeight = 0.0;
            int currentPagePlainTextLength = 0;
            String currentPageText = '';
            for (int i = 1; i < restNodes.length; i++) {
              final node = restNodes[i];
              final metrics =
                  _estimateNodeMetrics(node, baseStyle, tp, availableWidth);
              if (currentHeight + metrics['height'] > availableHeight &&
                  currentPageNodes.isNotEmpty) {
                if (currentPageText.trim().isNotEmpty) {
                  paginatedPages.add({
                    'html': _serializeNodesToHtml(currentPageNodes),
                    'unitIndex': contentUnitIndex,
                    'globalPlainTextOffset': globalOffset,
                  });
                  _pageTexts.add(currentPageText);
                  globalOffset += currentPagePlainTextLength;
                }
                currentPageNodes = [];
                currentHeight = 0.0;
                currentPagePlainTextLength = 0;
                currentPageText = '';
              }
              currentPageNodes.add(node);
              currentHeight += metrics['height'];
              currentPagePlainTextLength += metrics['plainTextLength'] as int;
              currentPageText += metrics['plainText'] as String;
            }
            if (currentPageNodes.isNotEmpty &&
                currentPageText.trim().isNotEmpty) {
              paginatedPages.add({
                'html': _serializeNodesToHtml(currentPageNodes),
                'unitIndex': contentUnitIndex,
                'globalPlainTextOffset': globalOffset,
              });
              _pageTexts.add(currentPageText);
              globalOffset += currentPagePlainTextLength;
            }
            continue;
          }
        } else {
          // اگر بلاک heading نداشت یا فقط heading بود، هر نود را جدا صفحه‌بندی کن
          List<html_dom.Node> currentPageNodes = [];
          double currentHeight = 0.0;
          int currentPagePlainTextLength = 0;
          String currentPageText = '';
          for (final node in block) {
            final metrics =
                _estimateNodeMetrics(node, baseStyle, tp, availableWidth);
            if (currentHeight + metrics['height'] > availableHeight &&
                currentPageNodes.isNotEmpty) {
              if (currentPageText.trim().isNotEmpty) {
                paginatedPages.add({
                  'html': _serializeNodesToHtml(currentPageNodes),
                  'unitIndex': contentUnitIndex,
                  'globalPlainTextOffset': globalOffset,
                });
                _pageTexts.add(currentPageText);
                globalOffset += currentPagePlainTextLength;
              }
              currentPageNodes = [];
              currentHeight = 0.0;
              currentPagePlainTextLength = 0;
              currentPageText = '';
            }
            currentPageNodes.add(node);
            currentHeight += metrics['height'];
            currentPagePlainTextLength += metrics['plainTextLength'] as int;
            currentPageText += metrics['plainText'] as String;
          }
          if (currentPageNodes.isNotEmpty &&
              currentPageText.trim().isNotEmpty) {
            paginatedPages.add({
              'html': _serializeNodesToHtml(currentPageNodes),
              'unitIndex': contentUnitIndex,
              'globalPlainTextOffset': globalOffset,
            });
            _pageTexts.add(currentPageText);
            globalOffset += currentPagePlainTextLength;
          }
        }
      }
      globalOffset += 2;
    }
    if (paginatedPages.isEmpty && contentUnits.isNotEmpty) {
      paginatedPages.add({
        'html': l10n.noReadableContentHtml,
        'unitIndex': 0,
        'globalPlainTextOffset': 0
      });
      _pageTexts.add(l10n.noReadableContent);
    }
    if (paginatedPages.isEmpty && contentUnits.isEmpty) {
      paginatedPages.add({
        'html': l10n.emptyBookHtml,
        'unitIndex': 0,
        'globalPlainTextOffset': 0
      });
      _pageTexts.add(l10n.emptyBook);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _handlePaginationComplete();
    });
    return paginatedPages;
  }

  // Helper: Estimate node metrics
  Map<String, dynamic> _estimateNodeMetrics(html_dom.Node node,
      TextStyle baseStyle, TextPainter tp, double availableWidth) {
    double estimatedHeight = 0.0;
    int plainTextLength = 0;
    String plainText = '';
    if (node is html_dom.Text) {
      final text = node.text;
      plainTextLength = text.length;
      plainText = text;
      tp.text = TextSpan(text: text, style: baseStyle);
      tp.layout(maxWidth: availableWidth);
      estimatedHeight = tp.height;
    } else if (node is html_dom.Element) {
      if (node.localName == 'img') {
        estimatedHeight = 200.0;
      } else if (node.localName?.startsWith('h') ?? false) {
        estimatedHeight = 50.0;
        plainText = node.text;
        plainTextLength = plainText.length;
      } else if (node.localName == 'p' || node.localName == 'div') {
        estimatedHeight = (tp.preferredLineHeight * 2) + 8.0;
        plainText = node.text;
        plainTextLength = plainText.length;
      } else {
        estimatedHeight = 20.0;
        plainText = node.text;
        plainTextLength = plainText.length;
      }
    }
    return {
      'height': estimatedHeight,
      'plainTextLength': plainTextLength,
      'plainText': plainText
    };
  }

  // Helper to serialize a list of HTML nodes back to an HTML string
  String _serializeNodesToHtml(List<html_dom.Node> nodes) {
    if (nodes.isEmpty) return '';
    // Create a temporary DocumentFragment to hold the nodes
    final fragment = html_parser.parseFragment('');
    for (final node in nodes) {
      fragment.append(node); // Append the original node
    }
    // Return the outerHtml of the fragment
    return fragment.outerHtml;
  }

  String _getMimeType(String path) {
    final extension = path.split('.').last.toLowerCase();
    switch (extension) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      case 'webp':
        return 'image/webp';
      case 'svg':
        return 'image/svg+xml';
      default:
        return 'image/png';
    }
  }

  // Helper function to detect if text is likely LTR (improved)
  bool _isLikelyLTR(String text) {
    if (text.isEmpty) return false;

    // Count LTR and RTL characters
    int ltrCount = 0;
    int rtlCount = 0;

    for (final rune in text.runes) {
      if ((rune >= 0x0041 && rune <= 0x005A) ||
          (rune >= 0x0061 && rune <= 0x007A)) {
        // A-Z, a-z
        ltrCount++;
      } else if (rune >= 0x0600 && rune <= 0x06FF) {
        // Arabic script range (includes Persian)
        rtlCount++;
      }
    }

    // Consider it LTR if there are significantly more LTR characters
    if (ltrCount > rtlCount * 2) return true; // More than double LTR chars

    // Consider it RTL if there are significantly more RTL characters
    if (rtlCount > ltrCount * 2) return false; // More than double RTL chars

    // If counts are similar or no relevant characters found, default based on overall book direction (RTL)
    return false;
  }

  // Helper to build list widgets recursively
  Widget _buildList(html_dom.Element listElement) {
    List<Widget> listItems = [];
    final isOrdered = listElement.localName == 'ol';
    int order = 1;

    for (final node in listElement.nodes) {
      if (node is html_dom.Element && node.localName == 'li') {
        List<InlineSpan> itemSpans = [];
        TextAlign itemAlign = TextAlign.right; // Default for list items

        // Check for text-align style on list item
        final styleAttr = node.attributes['style'];
        if (styleAttr != null) {
          final alignMatch =
              RegExp(r'text-align:\s*(left|right|center|justify)')
                  .firstMatch(styleAttr);
          if (alignMatch != null) {
            final align = alignMatch.group(1);
            switch (align) {
              case 'left':
                itemAlign = TextAlign.left;
                break;
              case 'center':
                itemAlign = TextAlign.center;
                break;
              case 'justify':
                itemAlign = TextAlign.justify;
                break;
              default:
                itemAlign = TextAlign.right;
                break;
            }
          }
        }

        // Process children of list item
        void parseListItemNode(html_dom.Node itemNode) {
          if (itemNode is html_dom.Text) {
            itemSpans.add(TextSpan(text: itemNode.text, style: _baseStyle()));
          } else if (itemNode is html_dom.Element) {
            switch (itemNode.localName) {
              case 'a': // Handle links within list items
                final url = itemNode.attributes['href'];
                final linkText = itemNode.text;
                final style = _baseStyle().copyWith(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                );
                itemSpans.add(TextSpan(
                  text: linkText,
                  style: style,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      if (url != null && url.isNotEmpty) {
                        _navigateToLink(
                            url); // New method to navigate internally
                      } else {
                        debugPrint('[CustomEpubReader] Link with empty href');
                      }
                    },
                ));
                break;
              case 'span': // Handle inline styles within list items
                final spanStyleAttr = itemNode.attributes['style'];
                TextStyle inlineStyle = _baseStyle();
                if (spanStyleAttr != null) {
                  // Parse and merge styles (simplified)
                  final colorMatch = RegExp(
                          r'color:\s*(#[0-9A-Fa-f]{6}|#[0-9A-Fa-f]{3}|rgb\(\s*\d+\s*,\s*\d+\s*,\s*\d+\s*\))')
                      .firstMatch(spanStyleAttr);
                  if (colorMatch != null) {/* ... parse color ... */}
                  final weightMatch =
                      RegExp(r'font-weight:\s*(\d+|bold|normal)')
                          .firstMatch(spanStyleAttr);
                  if (weightMatch != null) {/* ... parse weight ... */}
                  // ... parse other styles ...
                }
                itemNode.nodes.forEach((child) {
                  if (child is html_dom.Text) {
                    itemSpans.add(TextSpan(
                        text: child.text,
                        style: _baseStyle().merge(inlineStyle)));
                  } else {
                    // Recursive call for nested inline elements, inheriting style
                    parseListItemNode(child);
                  }
                });
                break;
              case 'ul': // Handle nested lists
              case 'ol':
                // Render nested list as a separate widget below the current item content
                listItems.add(Padding(
                  padding:
                      const EdgeInsets.only(left: 24.0), // Indent nested list
                  child: _buildList(itemNode),
                ));
                break;
              default:
                // For other tags within list item, just parse children
                itemNode.nodes.forEach(parseListItemNode);
            }
          }
        }

        // Build the main content of the list item (excluding nested lists initially)
        List<html_dom.Node> currentItemContentNodes = [];
        for (final itemNode in node.nodes) {
          if (itemNode is html_dom.Element &&
              (itemNode.localName == 'ul' || itemNode.localName == 'ol')) {
            // Skip nested lists here, they are added as separate widgets later
          } else {
            currentItemContentNodes.add(itemNode);
          }
        }
        currentItemContentNodes.forEach(parseListItemNode);

        // Add bullet point or number
        final String marker = isOrdered ? '${order++}. ' : '• ';
        itemSpans.insert(
            0,
            TextSpan(
                text: marker,
                style: _baseStyle().copyWith(
                    fontWeight:
                        FontWeight.bold))); // Add marker with base style

        // Add the list item content as a RichText widget
        listItems.add(RichText(
          text: TextSpan(children: itemSpans), // Spans already have base style
          textDirection: TextDirection.rtl, // Base direction
          textAlign: itemAlign, // Item specific alignment
        ));

        // Recursively add nested lists that were skipped earlier
        for (final itemNode in node.nodes) {
          if (itemNode is html_dom.Element &&
              (itemNode.localName == 'ul' || itemNode.localName == 'ol')) {
            listItems.add(Padding(
              padding: const EdgeInsets.only(left: 24.0), // Indent nested list
              child: _buildList(itemNode),
            ));
          }
        }
      }
    }

    // Return a Column containing all the list item widgets
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: listItems);
  }

  // New method to navigate to an internal EPUB link
  void _navigateToLink(String href) {
    // Parse the href to get file path and element ID
    final parts = href.split('#');
    String targetFilePath = parts[0]; // This is relative to OPF
    final targetElementId = parts.length > 1 ? parts[1] : null;

    // Clean the target file path (remove leading slashes if any, though not expected for OPF relative)
    while (targetFilePath.startsWith('/')) {
      targetFilePath = targetFilePath.substring(1);
    }

    // Find the corresponding chapter using the full href
    Chapter? targetChapter;
    void findChapter(List<Chapter> chapters) {
      for (final chapter in chapters) {
        if (chapter.src == href) {
          targetChapter = chapter;
          return;
        }
        if (chapter.children.isNotEmpty) {
          findChapter(chapter.children);
          if (targetChapter != null) return; // Stop if found in children
        }
      }
    }

    findChapter(_chapters);

    if (targetChapter != null && targetChapter?.pageIndex != null) {
      final nonNullChapter =
          targetChapter as Chapter; // Explicitly cast to non-null
      final targetPageIndex = nonNullChapter.pageIndex!;

      // Navigate to the target page
      _pageController?.jumpToPage(targetPageIndex);
      setState(() {
        // Update current page state after jumping
        _currentPage = targetPageIndex;
      });

      // If there's an element ID, attempt to scroll to it after the page is built
      if (targetElementId != null && targetElementId.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          // Ensure we are on the correct page before trying to scroll
          if (_currentPage == targetPageIndex) {
            // Look up the key for the target element ID on the current page
            if (targetPageIndex < _pageElementKeys.length) {
              final elementKey =
                  _pageElementKeys[targetPageIndex][targetElementId];
              if (elementKey != null && elementKey.currentContext != null) {
                // Access the ScrollController for the current page
                if (targetPageIndex < _pageScrollControllers.length) {
                  final pageScrollController =
                      _pageScrollControllers[targetPageIndex];

                  if (pageScrollController.hasClients) {
                    // Calculate the position of the widget relative to the SingleChildScrollView
                    final RenderBox renderBox = elementKey.currentContext!
                        .findRenderObject() as RenderBox;
                    final double dy = renderBox.localToGlobal(Offset.zero).dy;

                    // Get the position of the SingleChildScrollView's viewport
                    final RenderBox? viewport = pageScrollController
                        .position.context.notificationContext
                        ?.findRenderObject() as RenderBox?;
                    if (viewport != null) {
                      final double viewportOffset =
                          viewport.localToGlobal(Offset.zero).dy;
                      final double scrollOffset = dy - viewportOffset;

                      // Add a small offset to scroll the element slightly below the top
                      final double finalScrollOffset = scrollOffset -
                          (MediaQuery.of(context).size.height * 0.15);

                      pageScrollController.animateTo(
                        max(0.0,
                            finalScrollOffset), // Ensure offset is not negative
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeOut,
                      );
                    }
                  }
                }
              }
            }
          }
        });
      }
    } else {
      // Fallback: if no chapter found, try the less reliable content search by file path
      if (_contentFilePathToPageIndex.containsKey(targetFilePath)) {
        final fallbackPageIndex = _contentFilePathToPageIndex[targetFilePath]!;
        _pageController?.jumpToPage(fallbackPageIndex);
        setState(() {
          // Update current page state after jumping
          _currentPage = fallbackPageIndex;
        });
      } else {
        // Final fallback: search raw page content (very unreliable for specific sections)
        for (int i = 0; i < _pages.length; i++) {
          if (_pages[i].contains(targetFilePath)) {
            // Search for OPF-relative path in HTML content
            final finalFallbackPageIndex =
                _coverImageBytes != null ? i + 1 : i; // Adjust for cover page
            _pageController?.jumpToPage(finalFallbackPageIndex);
            setState(() {
              // Update current page state after jumping
              _currentPage = finalFallbackPageIndex;
            });
            return; // Found and navigated, exit function
          }
        }
      }
    }
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('fontSize', _fontSize);
    await prefs.setString('fontFamily', _fontFamily);
    await prefs.setInt('fontWeight', _fontWeight.index);
    await prefs.setBool('nightMode', _isNightMode);
    await prefs.setDouble('lineSpacing', _lineSpacing);
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _fontSize = prefs.getDouble('fontSize') ?? 18.0;
      _fontFamily = prefs.getString('fontFamily') ?? 'yakanBakh';
      _fontWeight =
          FontWeight.values[prefs.getInt('fontWeight') ?? 3]; // Default to w400
      _isNightMode = prefs.getBool('nightMode') ?? false;
      _lineSpacing = prefs.getDouble('lineSpacing') ?? 1.8;
    });
  }

  Future<Uint8List?> _loadImageFromEpub(String imgSrc) async {
    try {
      final epubFile = File(widget.epubPath);
      final bytes = await epubFile.readAsBytes();
      final archive = ZipDecoder().decodeBytes(bytes);

      // Normalize the image path
      String normalizedImgSrc = imgSrc;
      if (normalizedImgSrc.startsWith('/')) {
        normalizedImgSrc = normalizedImgSrc.substring(1);
      }

      // Try to find the image file in the archive
      for (final file in archive) {
        if (file.name.endsWith(normalizedImgSrc)) {
          return file.content as Uint8List;
        }
      }

      // If not found by exact path, try to find by filename
      final imgFileName = normalizedImgSrc.split('/').last;
      for (final file in archive) {
        if (file.name.split('/').last == imgFileName) {
          return file.content as Uint8List;
        }
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  // New method: Group nodes by heading (h1/h2/h3)
  List<List<html_dom.Node>> _groupNodesByHeading(List<html_dom.Node> nodes) {
    List<List<html_dom.Node>> blocks = [];
    List<html_dom.Node> currentBlock = [];
    for (final node in nodes) {
      if (node is html_dom.Element &&
          (node.localName == 'h1' ||
              node.localName == 'h2' ||
              node.localName == 'h3')) {
        if (currentBlock.isNotEmpty) {
          blocks.add(currentBlock);
          currentBlock = [];
        }
      }
      currentBlock.add(node);
    }
    if (currentBlock.isNotEmpty) {
      blocks.add(currentBlock);
    }
    return blocks;
  }
}

class Highlight {
  final String text;
  final int start;
  final int end;
  final Color color;
  final int pageIndex;
  final DateTime timestamp;
  final String bookId; // Add book identifier

  Highlight({
    required this.text,
    required this.start,
    required this.end,
    required this.color,
    required this.pageIndex,
    required this.timestamp,
    required this.bookId, // Add to constructor
  });

  Map<String, dynamic> toJson() => {
        'text': text,
        'start': start,
        'end': end,
        'color': color.value,
        'pageIndex': pageIndex,
        'timestamp': timestamp.toIso8601String(),
        'bookId': bookId, // Add to JSON
      };

  factory Highlight.fromJson(Map<String, dynamic> json) => Highlight(
        text: json['text'] as String? ?? '',
        start: json['start'] as int? ?? 0,
        end: json['end'] as int? ?? 0,
        color: Color(json['color'] as int? ?? Colors.yellow.value),
        pageIndex: json['pageIndex'] as int? ?? 0,
        timestamp: DateTime.parse(
            json['timestamp'] as String? ?? DateTime.now().toIso8601String()),
        bookId: json['bookId'] as String? ?? '', // Add to fromJson
      );
}

class Chapter {
  final String title;
  final String src;
  int? pageIndex;
  List<Chapter> children = [];
  int? contentUnitIndex;

  Chapter({
    required this.title,
    required this.src,
    this.pageIndex,
    this.contentUnitIndex,
  });
}

/// Normalize whitespace and line breaks for consistent text matching
String _normalizeText(String text) {
  return text
      .replaceAll(RegExp(r'\s+'), ' ') // collapse multiple spaces
      .replaceAll(RegExp(r'[\n\r]+'), ' ') // replace line breaks with space
      .trim(); // trim leading/trailing spaces
}

/// Plain text extracted from each page for highlight calculations
List<String> _displayText = [];

/// Finds the position of [selected] in the plain display text for a given [contentPageIndex].
/// Returns a map with 'start' and 'end' or null if not found.
Map<String, int>? _findTextPositionFromPlain(
    int contentPageIndex, String selected) {
  if (contentPageIndex < 0 || contentPageIndex >= _displayText.length)
    return null;
  final plain = _displayText[contentPageIndex];
  final normPlain = _normalizeText(plain);
  final normSel = _normalizeText(selected);
  final start = normPlain.indexOf(normSel);
  if (start == -1) return null;
  return {'start': start, 'end': start + normSel.length};
}
