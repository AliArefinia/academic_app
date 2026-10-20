import 'package:academic/l10n/l10n.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:academic/data/api/product/model/product_model.dart';
import 'package:share_plus/share_plus.dart';

class CustomPdfViewer extends StatefulWidget {
  final String pdfUrl;
  final ProductModel? product;
  final bool isSample;
  final Color themeColor;

  const CustomPdfViewer({
    Key? key,
    required this.pdfUrl,
    this.product,
    this.isSample = false,
    this.themeColor = Colors.blue,
  }) : super(key: key);

  @override
  State<CustomPdfViewer> createState() => _CustomPdfViewerState();
}

class _CustomPdfViewerState extends State<CustomPdfViewer> {
  PdfViewerController? _pdfController;
  bool _isLoading = true;
  String? _error;
  String? _localFilePath;
  int _currentPage = 0;
  int _totalPages = 0;
  bool _isControlsVisible = true;
  bool _isDownloading = false;
  GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      // Check if URL is local file or remote
      if (widget.pdfUrl.startsWith('http://') || widget.pdfUrl.startsWith('https://')) {
        // Download PDF from URL
        await _downloadPdf(widget.pdfUrl);
      } else {
        // Use local file
        _localFilePath = widget.pdfUrl;
      }

      if (_localFilePath != null && File(_localFilePath!).existsSync()) {
        _pdfController = PdfViewerController();
        
        // Get total pages - we'll get it after PDF loads
        setState(() {
          _isLoading = false;
        });
      } else {
        throw Exception(l10n.pdfFileNotFound);
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = l10n.errorLoadingPdfWithMessage(e.toString());
      });
    }
  }

  Future<void> _downloadPdf(String url) async {
    try {
      setState(() {
        _isDownloading = true;
      });

      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final directory = await getApplicationDocumentsDirectory();
        final fileName = url.split('/').last.split('?').first;
        final filePath = '${directory.path}/$fileName';

        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        setState(() {
          _localFilePath = filePath;
          _isDownloading = false;
        });
      } else {
        throw Exception(l10n.errorDownloadingFileWithMessage(response.statusCode.toString()));
      }
    } catch (e) {
      setState(() {
        _isDownloading = false;
      });
      throw e;
    }
  }

  void _onPageChanged(PdfPageChangedDetails details) {
    if (mounted) {
      setState(() {
        _currentPage = details.newPageNumber - 1; // Syncfusion uses 1-based indexing
      });
    }
  }

  void _onDocumentLoaded(PdfDocumentLoadedDetails details) {
    if (mounted) {
      setState(() {
        _totalPages = details.document.pages.count;
      });
    }
  }

  Future<void> _goToPage(int page) async {
    if (_pdfController != null && page >= 0 && page < _totalPages) {
      _pdfController!.jumpToPage(page + 1); // Syncfusion uses 1-based indexing
    }
  }

  void _nextPage() {
    if (_pdfController != null && _currentPage < _totalPages - 1) {
      _pdfController!.nextPage();
    }
  }

  void _previousPage() {
    if (_pdfController != null && _currentPage > 0) {
      _pdfController!.previousPage();
    }
  }

  Future<void> _sharePdf() async {
    if (_localFilePath != null && File(_localFilePath!).existsSync()) {
      try {
        await Share.shareXFiles(
          [XFile(_localFilePath!)],
          text: widget.product?.name ?? 'PDF',
        );
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.errorSharingWithMessage(e.toString())),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      }
    }
  }

  void _toggleControls() {
    setState(() {
      _isControlsVisible = !_isControlsVisible;
    });
  }

  @override
  void dispose() {
    _pdfController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.grey[200],
      body: SafeArea(
        child: Stack(
          children: [
            // PDF Viewer
            if (_isLoading)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_isDownloading)
                      Column(
                        children: [
                          CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(widget.themeColor),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            l10n.downloading,
                            style: context.textTheme.bodyLarge,
                          ),
                        ],
                      )
                    else
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(widget.themeColor),
                      ),
                  ],
                ),
              )
            else if (_error != null)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Theme.of(context).colorScheme.error,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _error!,
                        textAlign: TextAlign.center,
                        style: context.textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          _loadPdf();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: widget.themeColor,
                        ),
                        child: Text(l10n.retry),
                      ),
                    ],
                  ),
                ),
              )
            else if (_pdfController != null && _localFilePath != null)
              GestureDetector(
                onTap: _toggleControls,
                child: SfPdfViewer.file(
                  File(_localFilePath!),
                  key: _pdfViewerKey,
                  controller: _pdfController,
                  onDocumentLoaded: _onDocumentLoaded,
                  onPageChanged: _onPageChanged,
                  enableDoubleTapZooming: true,
                  enableTextSelection: true,
                  canShowScrollHead: true,
                  canShowScrollStatus: false,
                  canShowPasswordDialog: true,
                  pageLayoutMode: PdfPageLayoutMode.continuous,
                  scrollDirection: PdfScrollDirection.vertical,
                ),
              ),

            // Top App Bar
            if (_isControlsVisible && !_isLoading && _error == null)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.white),
                            onPressed: () => Navigator.pop(context),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (widget.product?.name != null)
                                  Text(
                                    widget.product!.name!,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                if (_totalPages > 0)
                                  Text(
                                    l10n.pageOfTotal(_currentPage + 1, _totalPages.toString()),
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.share, color: Colors.white),
                            onPressed: _sharePdf,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

            // Bottom Controls
            if (_isControlsVisible && !_isLoading && _error == null && _totalPages > 0)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Page Slider
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.first_page, color: Colors.white),
                                onPressed: _currentPage > 0
                                    ? () => _goToPage(0)
                                    : null,
                              ),
                              IconButton(
                                icon: const Icon(Icons.chevron_left, color: Colors.white),
                                onPressed: _currentPage > 0 ? _previousPage : null,
                              ),
                              Expanded(
                                child: Slider(
                                  value: _currentPage.toDouble(),
                                  min: 0,
                                  max: (_totalPages - 1).toDouble(),
                                  divisions: _totalPages > 1 ? _totalPages - 1 : null,
                                  activeColor: widget.themeColor,
                                  onChanged: (value) {
                                    _goToPage(value.toInt());
                                  },
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.chevron_right, color: Colors.white),
                                onPressed: _currentPage < _totalPages - 1
                                    ? _nextPage
                                    : null,
                              ),
                              IconButton(
                                icon: const Icon(Icons.last_page, color: Colors.white),
                                onPressed: _currentPage < _totalPages - 1
                                    ? () => _goToPage(_totalPages - 1)
                                    : null,
                              ),
                            ],
                          ),
                          // Zoom Controls
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.zoom_out, color: Colors.white),
                                onPressed: () {
                                  _pdfController?.zoomLevel = 
                                      (_pdfController!.zoomLevel - 0.25).clamp(0.5, 3.0);
                                },
                              ),
                              Text(
                                '${((_pdfController?.zoomLevel ?? 1.0) * 100).toInt()}%',
                                style: const TextStyle(color: Colors.white),
                              ),
                              IconButton(
                                icon: const Icon(Icons.zoom_in, color: Colors.white),
                                onPressed: () {
                                  _pdfController?.zoomLevel = 
                                      (_pdfController!.zoomLevel + 0.25).clamp(0.5, 3.0);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

