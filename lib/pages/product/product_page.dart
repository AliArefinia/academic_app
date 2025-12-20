import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:go_router/go_router.dart';
import 'package:academic/core/helper/error_helper.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/core/utils/price_parser.dart';
import 'package:academic/core/extensions/product_extensions.dart';
import 'package:academic/core/helper/premium_helper.dart';
import 'package:academic/core/router/router.dart';
import 'package:academic/data/api/product/model/product_model.dart';
import 'package:academic/data/model/menu_of_contents_model.dart';
import 'package:academic/data/model/user_opinions.dart';
import 'package:academic/widgets/main_button.dart';
import 'package:academic/widgets/error_state_widget.dart';
import 'package:academic/widgets/add_note_dialog.dart';
import 'package:path_provider/path_provider.dart';
import '../../core/theme/const.dart';
import '../../data/api/home/model/book_model.dart';
import '../../gen/assets.gen.dart';
import '../../widgets/other_booksBy_author_widget.dart';
import 'logic/product_cubit.dart';
import '../../data/api/people/model/person_model.dart';
import 'package:academic/core/storage/local_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:academic/pages/my_comments/logic/my_comments_cubit.dart';
import 'package:academic/widgets/player_sheet.dart';
import 'package:academic/pages/cart/logic/cart_cubit.dart';
import 'package:academic/widgets/custom_epub_reader.dart';
import 'package:http/http.dart' as http;
import 'package:academic/core/services/reading_progress_service.dart';
import 'widgets/add_to_shelf_bottom_sheet.dart';
import 'package:share_plus/share_plus.dart';
import 'package:universal_image_flutter/universal_image_flutter.dart';
import 'package:academic/widgets/custom_pdf_viewer.dart';

class EpubHandler {
  final ProductCubit _productCubit;
  final ReadingProgressService _progressService;

  EpubHandler(this._productCubit, this._progressService);

  Future<void> openEpub(String epubUrl, BuildContext context, ProductModel product, {bool isSample = false, int lastPosition = 0}) async {
    debugPrint('[EpubHandler] openEpub called with url: $epubUrl, isSample: $isSample, lastPosition: $lastPosition');
    
    try {
      // Check if we have cached progress
      final progress = await _progressService.getProgress(product.id ?? '');
      if (progress != null && progress.cachedEpubPath != null) {
        debugPrint('[EpubHandler] Progress found: true');
        debugPrint('[EpubHandler] Cached epub path: ${progress.cachedEpubPath}');
        debugPrint('[EpubHandler] Cached file exists: ${File(progress.cachedEpubPath!).existsSync()}');
        debugPrint('[EpubHandler] Saved lastPosition: ${progress.lastPosition}');
        
        // Use the cached file if it exists
        if (File(progress.cachedEpubPath!).existsSync()) {
          debugPrint('[EpubHandler] Using cached epub file: ${progress.cachedEpubPath}');
          _openEpubDirectly(progress.cachedEpubPath!, context, product, isSample: isSample, lastPosition: progress.lastPosition);
          return;
        }
      }

      // If no cached file or progress, download the epub
      await _downloadAndOpenEpub(epubUrl, context, product, isSample: isSample, lastPosition: lastPosition);
    } catch (e) {
      debugPrint('[EpubHandler] Error: $e');
      if (context.mounted) {
        ErrorHelper.showErrorSnackBar(context, 'خطا در باز کردن کتاب');
      }
    }
  }

  void _openEpubDirectly(String filePath, BuildContext context, ProductModel product, {bool isSample = false, int lastPosition = 0}) {
    debugPrint('[EpubHandler] _openEpubDirectly called with filePath: $filePath, lastPosition: $lastPosition');
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CustomEpubReader(
          epubPath: filePath,
          product: product,
          themeColor: context.colorScheme.primary,
          isSample: isSample,
          initialPage: lastPosition,
          allowSharing: true,
          onAddNote: (text) {
            if (context.mounted && product != null) {
              showAddNoteDialog(
                context: context,
                excerpt: text,
                bookId: product.idAsInt ?? 0,
                bookName: product.name ?? '',
                bookImage: product.image ?? '',
                authorName: product.author?.name,
                onSave: (chapterIds, userNote) async {
                  await _productCubit.addNote(
                    excerpt: text,
                    chapterIds: chapterIds,
                    userNote: userNote,
                    bookId: product.idAsInt ?? 0,
                    bookName: product.name ?? '',
                    bookImage: product.image ?? '',
                    authorName: product.author?.name,
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> _downloadAndOpenEpub(
    String url, 
    BuildContext context, 
    ProductModel product, {
    bool isSample = false,
    int lastPosition = 0,
  }) async {
    debugPrint('[EpubHandler] _downloadAndOpenEpub called with url: $url, isSample: $isSample, lastPosition: $lastPosition');
    final docsDir = await getApplicationDocumentsDirectory();
    final fileName = url.split('/').last;
    final filePath = '${docsDir.path}/$fileName';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        debugPrint('[EpubHandler] Downloaded epub file to: $filePath');
        
      if (context.mounted) {
          _openEpubDirectly(filePath, context, product, isSample: isSample, lastPosition: lastPosition);
        }
      } else {
        throw Exception('Failed to download epub file: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('[EpubHandler] Error downloading epub: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('خطا در دانلود کتاب: ${e.toString()}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }
}

class ProductPage extends StatefulWidget {
  final BookModel bookModel;

  const ProductPage(this.bookModel);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  String _createShareText(ProductModel product) {
    final buffer = StringBuffer();
    
    // Add book title and author
    buffer.writeln('📚 ${product.name}');
    if (product.authors?.isNotEmpty ?? false) {
      final authorNames = product.authors!.map((author) {
        return author.name;
      }).where((name) => name.isNotEmpty).join('، ');
      
      if (authorNames.isNotEmpty) {
        buffer.writeln('✍️ نویسنده: $authorNames');
      }
    }
    
    // Add a short description if available
    if (product.content?.isNotEmpty ?? false) {
      // Remove HTML tags and decode HTML entities
      String cleanContent = product.content!
          .replaceAll(RegExp(r'<[^>]*>'), '') // Remove HTML tags
          .replaceAll('&laquo;', '"') // Replace HTML quotes
          .replaceAll('&raquo;', '"')
          .replaceAll('&quot;', '"')
          .replaceAll('&amp;', '&')
          .replaceAll('&lt;', '<')
          .replaceAll('&gt;', '>')
          .replaceAll('&nbsp;', ' ')
          .trim();
      
      // Limit content length and add ellipsis if needed
      final shortDesc = cleanContent.length > 100 
          ? '${cleanContent.substring(0, 100)}...'
          : cleanContent;
      
      buffer.writeln('\n📝 $shortDesc');
    }
    
    // Add marketing message
    buffer.writeln('\n📱 برای مطالعه این کتاب و هزاران کتاب دیگر، اپلیکیشن حلال بوکس را نصب کنید:');
    buffer.writeln('academic://book?id=${product.id}');
    
    return buffer.toString();
  }

  void _shareBook(BuildContext context, ProductModel product, String shareText) async {
    try {
      await Share.share(
        shareText,
        subject: 'کتاب ${product.name}',
      );
    } catch (e) {
      if (context.mounted) {
        ErrorHelper.showErrorSnackBar(context, 'خطا در اشتراک‌گذاری');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<CartCubit>()..getCart(),
      child: BlocConsumer<ProductCubit, ProductState>(
        listener: (context, state) {
          if (state.error != null) {
            ErrorHelper.showErrorSnackBar(context, state.error!);
          } else if (state.successMessage != null) {
            ErrorHelper.showSuccessSnackBar(context, state.successMessage!);
          }
        },
        builder: (context, state) {
          final cubit = context.read<ProductCubit>();
          if (state.isLoading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (state.error != null && state.product == null) {
            return Scaffold(
              body: ErrorStateWidget(
                error: state.error,
                onRetry: () {
                  // We don't have a simple reload method, so just show the error
                },
                showRetryButton: false,
              ),
            );
          }

          final product = state.product;
          if (product == null) {
            return Scaffold(
              body: ErrorStateWidget(
                error: 'محصول یافت نشد',
                title: 'محصول یافت نشد',
                message: 'محصول مورد نظر در دسترس نیست',
                showRetryButton: false,
              ),
            );
          }

          // Debug logging for price parsing
          print('DEBUG: Product price: ${product.price}');
          print('DEBUG: Product price type: ${product.price.runtimeType}');
          print('DEBUG: Product discount price: ${product.discountPrice}');
          print('DEBUG: Product type: ${product.type}');
          print('DEBUG: Has valid price: ${product.hasValidPrice}');
          print('DEBUG: Formatted price: ${product.formattedPrice}');
          print('DEBUG: Is on discount: ${product.isOnDiscount}');

          final user = GetIt.I<LocalStorage>().getUser();
          final phoneOrName = (user?.name != null && (user?.name ?? '').isNotEmpty) 
              ? user!.name 
              : (user?.phone ?? '');

          return Stack(
            children: [
              Scaffold(
                body: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      leading: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back_outlined)),
                    ),

                    // book's image, author, publisher, radio studio, translator
                    SliverToBoxAdapter(
                        child: BookInformationSection(
                      image: product.image ?? '',
                      bookName: product.name ?? '',
                      authors: product.authors,
                      publisher: (product.publisher != null && product.publisher!.isNotEmpty) 
                          ? product.publisher 
                          : null,
                      translator: (product.translator != null && product.translator!.isNotEmpty) 
                          ? product.translator 
                          : null,
                    )),

                    // time of audio, share icon, bookmark icon, gift icon
                    SliverToBoxAdapter(
                        child: ActionRows(
                      audioTime: (product.time != null && product.time!.isNotEmpty) 
                          ? product.time! 
                          : ((product.audioTime != null && product.audioTime!.isNotEmpty) 
                              ? product.audioTime! 
                              : null),
                      isBookmarked: product.isBookmarked ?? false,
                      productType: product.type,
                      onShareIconPressed: () {
                        final cubit = context.read<ProductCubit>();
                        final product = cubit.state.product;
                        if (product == null) return;

                        final shareText = _createShareText(product);
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            child: Container(
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width * 0.9,
                                maxHeight: MediaQuery.of(context).size.height * 0.8,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.share, color: context.colorScheme.primary),
                                        const SizedBox(width: 8),
                                        Text('اشتراک‌گذاری کتاب', style: context.textTheme.titleLarge),
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                    child: SingleChildScrollView(
                                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          if (product.image != null)
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(8),
                                              child: UniversalImageLoader(
                                                path: product.image!,
                                                option: UniversalImageLoaderOption(
                                                  height: 150,
                                                  width: double.infinity,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          const SizedBox(height: 16),
                                          Text(
                                            product.name ?? '',
                                            style: context.textTheme.titleMedium?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          if (product.authors?.isNotEmpty ?? false) ...[
                                            const SizedBox(height: 8),
                                            Text(
                                              'نویسنده: ${product.authors!.join('، ')}',
                                              style: context.textTheme.bodyMedium,
                                            ),
                                          ],
                                          const SizedBox(height: 16),
                                          Text(
                                            shareText,
                                            style: context.textTheme.bodyMedium,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                          child: TextButton(
                                            onPressed: () => Navigator.pop(context),
                                            child: Text('انصراف'),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                          child: ElevatedButton.icon(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              _shareBook(context, product, shareText);
                                            },
                                            style: ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 8))),
                                            icon: Icon(Icons.share),
                                            label: Text('اشتراک‌گذاری'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      onBookMarkIconPressed: () {
                        context.read<ProductCubit>().toggleBookmark();
                      },
                      onGiftIconPressed: () {
                        context.go('/giftToOthersRoute', extra: product);
                      },
                    )),

                    // price container
                      if (product.price != null)
                    SliverToBoxAdapter(
                      child: BuyPriceSampleBox(
                        product: product,
                        discount: product.discountPrice,
                        price: product.price,
                          peopleRates: product.avgRate ?? product.peopleRates ?? 0,
                          numOfPeopleRates: product.numOfPeopleRates ?? 0,
                        sampleEpub: product.sampleEpub,
                        sampleAudio: product.sampleAudio,
                        type: product.type,
                      ),
                    ),

                    // Section Divider
                    if (product.content?.isNotEmpty ?? false)
                      SliverToBoxAdapter(
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: AppSpacing.s24),
                          child: Divider(
                            height: 1,
                            thickness: 1,
                            color: Theme.of(context).brightness == Brightness.dark
                                ? context.colorScheme.outline.withOpacity(0.2)
                                : context.colorScheme.outline.withOpacity(0.1),
                          ),
                      ),
                    ),

                    // قبل از IntroductionBox
                      if (product.content?.isNotEmpty ?? false)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s24),
                        child: Text(
                          'درباره کتاب',
                          style: context.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.3,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),

                    // introduction text
                      if (product.content?.isNotEmpty ?? false)
                    SliverToBoxAdapter(
                      child: IntroductionBox(
                          introductionText: product.content ?? '',
                        onTap: () {},
                      ),
                    ),

                    // Tags section
                      if (product.tags?.isNotEmpty ?? false) ...[
                      SliverToBoxAdapter(
                        child: Container(
                          margin: const EdgeInsets.only(top: AppSpacing.s24, bottom: AppSpacing.s12),
                          child: Divider(
                            height: 1,
                            thickness: 1,
                            color: Theme.of(context).brightness == Brightness.dark
                                ? context.colorScheme.outline.withOpacity(0.2)
                                : context.colorScheme.outline.withOpacity(0.1),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'برچسب‌ها',
                                style: context.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.right,
                              ),
                              const SizedBox(height: AppSpacing.s12),
                              Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children: product.tags!.map((tag) {
                                  return Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                onTap: () {
                                  final tagName = tag.name ?? 'تگ';
                                  TagBooksRoute(tagId: tag.id.toString(), tagName: tagName).push(context);
                                },
                                      borderRadius: BorderRadius.circular(20),
                                child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: AppSpacing.s12,
                                          vertical: AppSpacing.s8,
                                        ),
                                  decoration: BoxDecoration(
                                          color: context.colorScheme.primary.withOpacity(0.08),
                                          borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                            color: context.colorScheme.primary.withOpacity(0.2),
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    tag.name ?? '',
                                          style: context.textTheme.bodyMedium?.copyWith(
                                      color: context.colorScheme.primary,
                                      fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                          ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],

                    // Menu and personal development
                      if ((product.categories?.isNotEmpty ?? false) || (product.menuOfContents?.isNotEmpty ?? false))
                      SliverToBoxAdapter(
                        child: MenuAndPersonalDevelopment(
                          onMenuTap: () => menuOfContents(context),
                          onPersonalDevelopmentTap: () {
                              try {
                            final category = product.categories!.first;
                                print('DEBUG: category.id = ${category.id}, type: ${category.id.runtimeType}');
                                final parsedId = int.tryParse(category.id.toString()) ?? 0;
                                print('DEBUG: parsedId = $parsedId');
                                PersonaldevelopmentbooksRoute(
                                  id: parsedId,
                                  title: category.name ?? '...'
                                ).push(context);
                              } catch (e, stackTrace) {
                                print('Error in PersonaldevelopmentbooksRoute: $e');
                                print('Stack trace: $stackTrace');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('خطا: $e'))
                                );
                              }
                          },
                          categoryName: product.categories?.isNotEmpty == true ? product.categories!.first.name ?? '...' : '...',
                          hasMenu: product.menuOfContents?.isNotEmpty ?? false,
                          hasPersonalDevelopment: product.categories?.isNotEmpty ?? false,
                        ),
                      ),

                    // book id section
                    SliverToBoxAdapter(
                      child: BookIDSection(
                        onViewPressed: () {
                            try {
                              print('DEBUG: product.id = ${product.id}, type: ${product.id.runtimeType}');
                              final parsedPrice = _toDouble(product.price);
                              final parsedDiscountPrice = _toDouble(product.discountPrice);
                              print('DEBUG: price = $parsedPrice, discountPrice = $parsedDiscountPrice');
                              BookidRoute(
                                id: product.id?.toString() ?? '',
                                name: product.name,
                                image: product.image,
                                type: product.type,
                                publisher: product.publisher,
                                translator: product.translator,
                                price: parsedPrice,
                                discountPrice: parsedDiscountPrice,
                              ).push(context);
                            } catch (e, stackTrace) {
                              print('Error in BookidRoute: $e');
                              print('Stack trace: $stackTrace');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('خطا: $e'))
                              );
                            }
                        },
                      ),
                    ),

                      if (product.comments?.isNotEmpty ?? false) ...[
                      SliverToBoxAdapter(
                        child: Container(
                          margin: const EdgeInsets.only(top: AppSpacing.s32, bottom: AppSpacing.s16),
                          child: Divider(
                            height: 1,
                            thickness: 1,
                            color: Theme.of(context).brightness == Brightness.dark
                                ? context.colorScheme.outline.withOpacity(0.2)
                                : context.colorScheme.outline.withOpacity(0.1),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s24),
                          child: Text(
                            'نظرات کاربران',
                            style: context.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.3,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: context.fullHeight * 0.33,
                          child: ListView.builder(
                            clipBehavior: Clip.none,
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                              itemCount: product.comments?.length ?? 0,
                            itemBuilder: (context, index) {
                                final comment = product.comments![index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s12),
                                child: SizedBox(
                                  width: context.fullWidth * 0.8,
                                  child: UserOpinionsWidget(
                                    userOpinionsModel: UserOpinionsModel(
                                        name: comment.userName ?? '',
                                        family: '',
                                        rate: comment.rate ?? 0,
                                        date: comment.createdAt ?? DateTime.now(),
                                        opinionText: comment.comment ?? '',
                                        numOfUseful: comment.recommendation == true ? 1 : 0,
                                        numOfNotUseful: comment.recommendation == false ? 1 : 0,
                                        userAvatar: comment.userAvatar ?? '',
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],

                    SliverToBoxAdapter(
                      child: RecordReviewsAndScores(
                        phoneNumber: phoneOrName,
                        onSubmitButton: () {
                          print('RATE before push: ${state.personRate}');
                          MycommentsRoute(
                            bookName: product.name ?? '',
                            bookImage: product.image ?? '',
                            rate: state.personRate,
                              productId: int.tryParse(product.id?.toString() ?? '0') ?? 0,
                          ).push(context);
                        },
                        personRate: state.personRate.toDouble(),
                        onRateChanged: (rating) {
                          cubit.rateAction(rating);
                          context.read<MycommentsCubit>().rateAction(rating);
                        },
                      ),
                    ),

                      if (product.authorBooks?.isNotEmpty ?? false) ...[
                      SliverToBoxAdapter(
                        child: Container(
                          margin: const EdgeInsets.only(top: AppSpacing.s32, bottom: AppSpacing.s16),
                          child: Divider(
                            height: 1,
                            thickness: 1,
                            color: Theme.of(context).brightness == Brightness.dark
                                ? context.colorScheme.outline.withOpacity(0.2)
                                : context.colorScheme.outline.withOpacity(0.1),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: TextAboveList(
                          text: 'کتاب‌های دیگر این نویسنده',
                          onPressed: () {
                            // Get the first author's ID and name
                            final firstAuthor = product.authors?.isNotEmpty == true 
                                ? product.authors!.first 
                                : product.author;
                            if (firstAuthor?.idAsInt != null) {
                              AuthorBooksRoute(
                                authorId: firstAuthor!.idAsInt.toString(),
                                authorName: firstAuthor.name,
                              ).push(context);
                            }
                          },
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: context.fullHeight * 0.33,
                          child: ListView.builder(
                            clipBehavior: Clip.none,
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                              itemCount: product.authorBooks?.length ?? 0,
                            itemBuilder: (context, index) {
                                final authorBook = product.authorBooks![index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s12),
                                child: OtherBooksByAuthorWidget(
                                    bookModel: authorBook,
                                    onTap: () => ProductRoute(authorBook).push(context),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],

                      if (product.publisherBooks?.isNotEmpty ?? false) ...[
                      SliverToBoxAdapter(
                        child: Container(
                          margin: const EdgeInsets.only(top: AppSpacing.s32, bottom: AppSpacing.s16),
                          child: Divider(
                            height: 1,
                            thickness: 1,
                            color: Theme.of(context).brightness == Brightness.dark
                                ? context.colorScheme.outline.withOpacity(0.2)
                                : context.colorScheme.outline.withOpacity(0.1),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: TextAboveList(
                          text: 'کتاب‌های دیگر این ناشر',
                          onPressed: () {
                            if (product.publisher != null) {
                              // Use publisher name for search since we don't have publisher_id
                              PublisherBooksRoute(
                                publisherId: '0', // Placeholder ID
                                publisherName: product.publisher!,
                              ).push(context);
                            }
                          },
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: context.fullHeight * 0.33,
                          child: ListView.builder(
                            clipBehavior: Clip.none,
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                              itemCount: product.publisherBooks?.length ?? 0,
                            itemBuilder: (context, index) {
                                final publisherBook = product.publisherBooks![index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s12),
                                child: OtherBooksByAuthorWidget(
                                    bookModel: publisherBook,
                                    onTap: () => ProductRoute(publisherBook).push(context),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                      if (product.relatedBooks?.isNotEmpty ?? false) ...[
                      SliverToBoxAdapter(
                        child: Container(
                          margin: const EdgeInsets.only(top: AppSpacing.s32, bottom: AppSpacing.s16),
                          child: Divider(
                            height: 1,
                            thickness: 1,
                            color: Theme.of(context).brightness == Brightness.dark
                                ? context.colorScheme.outline.withOpacity(0.2)
                                : context.colorScheme.outline.withOpacity(0.1),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: TextAboveList(
                          text: 'کتاب‌های مرتبط',
                          onPressed: () {}, // No action needed for related books
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: context.fullHeight * 0.33,
                          child: ListView.builder(
                            clipBehavior: Clip.none,
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                              itemCount: product.relatedBooks?.length ?? 0,
                            itemBuilder: (context, index) {
                                final relatedBook = product.relatedBooks![index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s12),
                                child: OtherBooksByAuthorWidget(
                                    bookModel: relatedBook,
                                    onTap: () => ProductRoute(relatedBook).push(context),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ],
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

double? _toDouble(dynamic value) {
  if (value == null) return null;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String) return double.tryParse(value);
  return null;
}

class BookInformationSection extends StatelessWidget {
  final String image;
  final String? bookName;
  final List<PersonModel>? authors;
  final String? publisher;
  final String? translator;

  const BookInformationSection(
      {super.key,
      required this.image,
       this.bookName,
       this.authors,
       this.publisher,
       this.translator,
       });

  Widget _buildBookImage(String? imageUrl, BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    if (imageUrl == null || imageUrl.isEmpty) {
      return Container(
        width: 160,
        height: 240,
        decoration: BoxDecoration(
          color: isDark 
              ? context.colorScheme.surfaceContainer
              : context.colorScheme.surfaceContainer.withOpacity(0.3),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(
          Icons.menu_book_rounded,
          size: 64,
          color: context.colorScheme.onSurface.withOpacity(0.3),
        ),
      );
    }
    
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: isDark 
                ? Colors.black.withOpacity(0.4)
                : context.colorScheme.shadow.withOpacity(0.15),
            blurRadius: 24,
            offset: const Offset(0, 8),
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: UniversalImageLoader(
          path: imageUrl,
          option: UniversalImageLoaderOption(
            width: 160,
            height: 240,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s24, vertical: AppSpacing.s32),
      child: Column(
        children: [
          // Book Image with elegant shadow
          _buildBookImage(image, context),
          
          const SizedBox(height: AppSpacing.s24),
          
          // Book Title - Clean and minimal
        if (bookName != null && bookName!.isNotEmpty)
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
            child: Text(
                bookName!,
              textAlign: TextAlign.center,
                style: context.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                  height: 1.4,
                ),
              ),
          ),
          
          // Author and metadata - Clean typography
          if ((authors != null && authors!.isNotEmpty) || 
              translator != null || 
              publisher != null) ...[
            const SizedBox(height: AppSpacing.s16),
        Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
              child: Column(
            children: [
              if (authors != null && authors!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.s8),
                      child: Text(
                        'نویسنده: ${authors!.map((a) => a.name).join('، ')}',
                        textAlign: TextAlign.center,
                        style: context.textTheme.bodyLarge?.copyWith(
                          color: isDark 
                              ? context.colorScheme.onSurfaceVariant
                              : context.colorScheme.onSurface.withOpacity(0.8),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  
                  if (translator != null && translator!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.s8),
                      child: Text(
                        'مترجم: $translator',
                        textAlign: TextAlign.center,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: isDark 
                              ? context.colorScheme.onSurfaceVariant
                              : context.colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                    ),
                  
                  if (publisher != null && publisher!.isNotEmpty)
                    Text(
                      'ناشر: $publisher',
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: isDark 
                            ? context.colorScheme.onSurfaceVariant
                            : context.colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
            ],
          ),
            ),
          ],
      ],
      ),
    );
  }
}

class ActionRows extends StatelessWidget {
  final String? audioTime;
  final VoidCallback onShareIconPressed;
  final VoidCallback onBookMarkIconPressed;
  final VoidCallback onGiftIconPressed;
  final bool isBookmarked;
  final String? productType;

  ActionRows({
    super.key,
    this.audioTime,
    required this.onShareIconPressed,
    required this.onBookMarkIconPressed,
    required this.onGiftIconPressed,
    this.isBookmarked = false,
    this.productType,
  });

  @override
  Widget build(BuildContext context) {
    final bool isAudioBook = productType == 'audio';
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s24, vertical: AppSpacing.s8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Audio time indicator for audio books
          if (isAudioBook && audioTime != null && audioTime!.isNotEmpty) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s12, vertical: AppSpacing.s6),
              decoration: BoxDecoration(
                color: context.colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.headphones_rounded,
                    size: 18,
                    color: context.colorScheme.primary,
                  ),
                  const SizedBox(width: AppSpacing.s6),
                  Text(
                    audioTime!,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.s20),
          ],
          
          // Action buttons - minimal design
          _buildActionButton(
            context,
            icon: Icons.bookmark_outline,
            isActive: isBookmarked,
            onPressed: onBookMarkIconPressed,
          ),
          const SizedBox(width: AppSpacing.s20),
          _buildActionButton(
            context,
            icon: Icons.share_outlined,
            onPressed: onShareIconPressed,
          ),
          const SizedBox(width: AppSpacing.s20),
          _buildActionButton(
            context,
            icon: Icons.card_giftcard_outlined,
            onPressed: onGiftIconPressed,
          ),
        ],
      ),
    );
  }
  
  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required VoidCallback onPressed,
    bool isActive = false,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.s10),
          decoration: BoxDecoration(
            color: isActive 
                ? context.colorScheme.primary.withOpacity(0.1)
                : (isDark 
                    ? context.colorScheme.surfaceContainer.withOpacity(0.5)
                    : context.colorScheme.surfaceContainer.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isActive 
                  ? context.colorScheme.primary.withOpacity(0.3)
                  : Colors.transparent,
              width: 1,
            ),
          ),
          child: Icon(
            icon,
            color: isActive 
                ? context.colorScheme.primary
                : (isDark 
                    ? context.colorScheme.onSurfaceVariant
                    : context.colorScheme.onSurface.withOpacity(0.7)),
            size: 22,
          ),
        ),
      ),
    );
  }
}

class BuyPriceSampleBox extends StatefulWidget {
  final ProductModel product;
  final dynamic peopleRates;
  final dynamic discount;
  final dynamic price;
  final dynamic numOfPeopleRates;
  final String? sampleEpub;
  final String? sampleAudio;
  final String? type;

  const BuyPriceSampleBox({
    super.key,
    required this.product,
    this.peopleRates,
    this.discount,
    this.price,
    this.numOfPeopleRates,
    this.sampleEpub,
    this.sampleAudio,
    this.type,
  });

  @override
  State<BuyPriceSampleBox> createState() => _BuyPriceSampleBoxState();
}

class _BuyPriceSampleBoxState extends State<BuyPriceSampleBox> {
  bool _isDownloadingEpub = false;

  int _toInt(dynamic value) {
    return PriceParser.parseToInt(value);
  }

  String _getContentTypeText(String? type) {
    return type == 'audio' ? 'پخش' : 'مطالعه';
  }

  bool _isAudioContent(String? type) {
    return type == 'audio';
  }

  bool _isEpubContent(String? type) {
    return type == 'epub' || type == 'text' || type == '6';
  }
  
  bool _isEpubContentByFile(ProductModel product) {
    // Check if type indicates epub
    if (_isEpubContent(product.type)) {
      return true;
    }
    // Check if file extension is .epub
    final fileUrl = product.file ?? product.epub;
    if (fileUrl != null && fileUrl.toLowerCase().endsWith('.epub')) {
      return true;
    }
    return false;
  }

  bool _isPdfContent(ProductModel product) {
    // Check if type is "1" (PDF type from API)
    if (product.type == '1') {
      return true;
    }
    // Check if file extension is .pdf
    final fileUrl = product.file ?? product.epub;
    if (fileUrl != null && fileUrl.toLowerCase().endsWith('.pdf')) {
      return true;
    }
    return false;
  }

  bool _canPlayAudio(ProductModel product) {
    if (product.type != 'audio') return false;
    final isPurchased = product.isPurchased ?? false;
    final isPremiumUser = PremiumHelper.isPremiumUser();
    final hasSubscription = product.hasSubscription ?? false;
    
    // قدم اول: اگر کتاب را خریده، دسترسی کامل
    if (isPurchased) {
      return product.headlines != null && product.headlines!.isNotEmpty;
    }
    
    // قدم دوم: اگر کتاب را نخریده ولی subscription دارد و کاربر پریمیوم است
    if (hasSubscription && isPremiumUser) {
      return product.headlines != null && product.headlines!.isNotEmpty;
    }
    
    // در غیر این صورت فقط نمونه
    return product.sampleAudio != null && product.sampleAudio!.isNotEmpty;
  }

  bool _canReadEpub(ProductModel product) {
    if (!_isEpubContentByFile(product)) return false;
    final isPurchased = product.isPurchased ?? false;
    final isPremiumUser = PremiumHelper.isPremiumUser();
    final hasSubscription = product.hasSubscription ?? false;
    
    // قدم اول: اگر کتاب را خریده، دسترسی کامل
    if (isPurchased) {
      return product.epub != null && product.epub!.isNotEmpty;
    }
    
    // قدم دوم: اگر کتاب را نخریده ولی subscription دارد و کاربر پریمیوم است
    if (hasSubscription && isPremiumUser) {
      return product.epub != null && product.epub!.isNotEmpty;
    }
    
    // در غیر این صورت فقط نمونه
    return product.sampleEpub != null && product.sampleEpub!.isNotEmpty;
  }

  bool _canReadPdf(ProductModel product) {
    if (!_isPdfContent(product)) return false;
    final isPurchased = product.isPurchased ?? false;
    final isPremiumUser = PremiumHelper.isPremiumUser();
    final hasSubscription = product.hasSubscription ?? false;
    
    // قدم اول: اگر کتاب را خریده، دسترسی کامل
    if (isPurchased) {
      return product.file != null && product.file!.isNotEmpty;
    }
    
    // قدم دوم: اگر کتاب را نخریده ولی subscription دارد و کاربر پریمیوم است
    if (hasSubscription && isPremiumUser) {
      return product.file != null && product.file!.isNotEmpty;
    }
    
    // در غیر این صورت فقط نمونه
    return product.sample != null && product.sample!.isNotEmpty;
  }

  Future<void> _openPdf(String url, BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CustomPdfViewer(
          pdfUrl: url,
          product: widget.product,
          isSample: !(widget.product.isPurchased ?? false) && 
                    !(PremiumHelper.isPremiumUser() && (widget.product.hasSubscription ?? false)),
          themeColor: context.colorScheme.primary,
        ),
      ),
    );
  }

  Future<void> _handleContentOpen(BuildContext context) async {
    final type = widget.product.type;
    if (type == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('نوع محتوا نامشخص است'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      return;
    }
    
    // Show loading state for all content types
    setState(() {
      _isDownloadingEpub = true;
    });
    
    try {
      if (_isAudioContent(type)) {
        print('[ProductPage] Opening audio player');
        if (_canPlayAudio(widget.product)) {
          await showPlayerSheet(context, widget.product);
        } else {
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('فایل صوتی در دسترس نیست'),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      } else if (_isPdfContent(widget.product)) {
        print('[ProductPage] Opening PDF');
        if (_canReadPdf(widget.product)) {
          final isPurchased = widget.product.isPurchased ?? false;
          final isPremiumUser = PremiumHelper.isPremiumUser();
          final hasSubscription = widget.product.hasSubscription ?? false;
          
          // Determine which PDF URL to use
          String? pdfUrl;
          
          if (isPurchased) {
            // قدم اول: اگر کتاب را خریده، محتوای کامل
            pdfUrl = widget.product.file;
          } else if (hasSubscription && isPremiumUser) {
            // قدم دوم: اگر کتاب را نخریده ولی subscription دارد و کاربر پریمیوم است
            pdfUrl = widget.product.file;
          } else {
            // در غیر این صورت فقط نمونه
            pdfUrl = widget.product.sample;
          }
          
          if (pdfUrl != null && pdfUrl.isNotEmpty) {
            if (!context.mounted) return;
            _openPdf(pdfUrl, context);
          } else {
            if (!context.mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('فایل PDF در دسترس نیست'),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }
        } else {
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('فایل PDF در دسترس نیست'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else if (_isEpubContentByFile(widget.product)) {
        print('[ProductPage] Opening epub reader');
        if (_canReadEpub(widget.product)) {
          final isPurchased = widget.product.isPurchased ?? false;
          final isPremiumUser = PremiumHelper.isPremiumUser();
          final hasSubscription = widget.product.hasSubscription ?? false;
          
          // Determine which epub URL to use
          String? epubUrl;
          bool isSample = false;
          
          if (isPurchased) {
            // قدم اول: اگر کتاب را خریده، محتوای کامل
            epubUrl = widget.product.epub;
            isSample = false;
          } else if (hasSubscription && isPremiumUser) {
            // قدم دوم: اگر کتاب را نخریده ولی subscription دارد و کاربر پریمیوم است
            epubUrl = widget.product.epub;
            isSample = false;
          } else {
            // در غیر این صورت فقط نمونه
            epubUrl = widget.product.sampleEpub;
            isSample = true;
          }
          
          if (epubUrl != null) {
            final cubit = context.read<ProductCubit>();
            await EpubHandler(cubit, GetIt.I<ReadingProgressService>()).openEpub(epubUrl, context, widget.product, isSample: isSample);
          } else {
            if (!context.mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('فایل کتاب در دسترس نیست'),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }
        } else {
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('فایل کتاب در دسترس نیست'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } finally {
      if (mounted) {
        setState(() {
          _isDownloadingEpub = false;
        });
      }
    }
  }

  void _handleAddToCart(BuildContext context) async {
    try {
      final cartCubit = context.read<CartCubit>();
      final productId = _toInt(widget.product.id);
      print('DEBUG: Adding product to cart, ID: $productId');
      
      // First check if product is already in cart
      final currentState = cartCubit.state;
      final isInCart = currentState.maybeWhen(
        success: (items, meta) => meta.containsBookId(productId),
        orElse: () => false,
      );
      
      if (isInCart) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('این محصول قبلاً در سبد خرید شما وجود دارد'),
            backgroundColor: Theme.of(context).colorScheme.tertiary,
          ),
        );
        return;
      }

      await cartCubit.addToCart(productId);
      print('DEBUG: Successfully added to cart, refreshing cart state');
      await cartCubit.getCart(); // Refresh cart state after adding
      
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          duration: const Duration(seconds: 2),
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Theme.of(context).colorScheme.onPrimary, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  '${widget.product.name} به سبد خرید اضافه شد',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            ],
          ),
          action: SnackBarAction(
            label: 'مشاهده',
            textColor: Theme.of(context).colorScheme.onPrimary,
            onPressed: () => context.push('/cart'),
          ),
        ),
      );
    } catch (e) {
      if (!context.mounted) return;
      ErrorHelper.showErrorSnackBar(context, 'خطا در افزودن به سبد خرید');
    }
  }

  @override
  Widget build(BuildContext context) {
    final int peopleRatesVal = _toInt(widget.peopleRates);
    final int numOfPeopleRatesVal = _toInt(widget.numOfPeopleRates);
    final int priceVal = _toInt(widget.price);
    
    if (priceVal == 0) return const SizedBox.shrink();

    final int discountVal = _toInt(widget.discount);
    int? discountPercent;
    double finalPrice = priceVal.toDouble();
    
    if (discountVal > 0 && priceVal > 0 && discountVal < priceVal) {
      discountPercent = ((1 - (discountVal / priceVal)) * 100).round();
      finalPrice = discountVal.toDouble();
    }
    
    final bool hasDiscount = discountVal > 0 && priceVal > 0;
    final bool isPurchased = widget.product.isPurchased ?? false;
    final bool isPremiumUser = PremiumHelper.isPremiumUser();
    final bool hasSubscription = widget.product.hasSubscription ?? false;
    
    // Debug logging for subscription and premium status
    print('[ProductPage] Book: ${widget.product.name}');
    print('[ProductPage] isPurchased: $isPurchased');
    print('[ProductPage] isPremiumUser: $isPremiumUser');
    print('[ProductPage] hasSubscription: $hasSubscription');
    print('[ProductPage] Should show Add to Shelf: ${isPurchased || (hasSubscription && isPremiumUser)}');

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.s24, vertical: AppSpacing.s12),
      padding: const EdgeInsets.all(AppSpacing.s20),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isDark 
            ? context.colorScheme.surfaceContainer
            : context.colorScheme.surface,
        border: Border.all(
          color: isDark 
              ? context.colorScheme.outline.withOpacity(0.2)
              : context.colorScheme.outline.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Rating and Price Section - Clean Layout
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.s16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Rating Section
                if (peopleRatesVal > 0 || numOfPeopleRatesVal > 0)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                          mainAxisSize: MainAxisSize.min,
                      children: [
                            ...List.generate(5, (index) {
                              final starIndex = index + 1;
                              return Padding(
                                padding: const EdgeInsets.only(left: AppSpacing.s2),
                                child: Icon(
                                  peopleRatesVal >= starIndex
                                      ? Icons.star_rounded
                                      : Icons.star_outline_rounded,
                                  size: 20,
                                  color: peopleRatesVal >= starIndex
                                      ? Colors.amber[600]
                                      : context.colorScheme.onSurface.withOpacity(0.3),
                                  ),
                              );
                            }),
                      ],
                    ),
                        if (numOfPeopleRatesVal > 0) ...[
                          const SizedBox(height: AppSpacing.s4),
                    Text(
                      "از ${numOfPeopleRatesVal} نظر",
                      style: context.textTheme.bodySmall?.copyWith(
                              color: context.colorScheme.onSurfaceVariant,
                              fontSize: 12,
                      ),
                          ),
                        ],
                  ],
                ),
                  ),
                // Price Section
                if (!isPurchased && priceVal > 0 && !(hasSubscription && isPremiumUser))
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (hasDiscount) ...[
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${PriceParser.formatPrice(priceVal.toDouble())}',
                              style: context.textTheme.bodySmall?.copyWith(
                                decoration: TextDecoration.lineThrough,
                                color: context.colorScheme.onSurface.withOpacity(0.5),
                                fontSize: 13,
                              ),
                            ),
                            if (discountPercent != null && discountPercent > 0) ...[
                              const SizedBox(width: AppSpacing.s8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.s8,
                                  vertical: AppSpacing.s2,
                                ),
                                decoration: BoxDecoration(
                                  color: context.colorScheme.primary,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  '%$discountPercent',
                                  style: context.textTheme.labelSmall?.copyWith(
                                    color: context.colorScheme.onPrimary,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: AppSpacing.s6),
                      ],
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '${PriceParser.formatPrice(finalPrice)}',
                              style: context.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: context.colorScheme.primary,
                                letterSpacing: -0.5,
                              ),
                            ),
                            TextSpan(
                              text: ' تومان',
                              style: context.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: context.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                ),
              ],
            ),
          ),
          // Action Buttons Section
          Column(
              children: [
                if (isPurchased || (hasSubscription && isPremiumUser))
                Column(
                  children: [
                    if (hasSubscription && isPremiumUser && !isPurchased)
                    Container(
                        margin: const EdgeInsets.only(bottom: AppSpacing.s12),
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.s12,
                          vertical: AppSpacing.s10,
                        ),
                      decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Colors.amber.withOpacity(0.4),
                            width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                              Icons.star_rounded,
                              color: Colors.amber[700],
                            size: 18,
                          ),
                            const SizedBox(width: AppSpacing.s6),
                          Text(
                            'دسترسی پریمیوم',
                            style: context.textTheme.bodyMedium?.copyWith(
                                color: Colors.amber[900],
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MainButton(
                      textColor: context.colorScheme.secondary,
                      text: _getContentTypeText(widget.product.type),
                      backgroundColor: context.colorScheme.primary,
                      isLoading: _isDownloadingEpub,
                      onPressed: _isDownloadingEpub ? null : () => _handleContentOpen(context),
                    ),
                    // Add to Shelf button
                    const SizedBox(height: AppSpacing.s12),
                    OutlinedButton.icon(
                      onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) => AddToShelfBottomSheet(
                                bookId: _toInt(widget.product.id),
                              ),
                            );
                          },
                      icon: Icon(
                        Icons.library_add_rounded,
                                color: context.colorScheme.primary,
                                size: 20,
                              ),
                      label: Text(
                                'افزودن به قفسه',
                        style: context.textTheme.bodyLarge?.copyWith(
                                  color: context.colorScheme.primary,
                                  fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: AppSpacing.s12,
                          horizontal: AppSpacing.s16,
                        ),
                        side: BorderSide(
                          color: context.colorScheme.primary,
                          width: 1.5,
                              ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ],
                )
                else if (priceVal > 0 && !isPurchased && !(hasSubscription && isPremiumUser)) ...[
                  BlocBuilder<CartCubit, CartState>(
                    builder: (context, state) {
                      print('DEBUG: Cart state: $state');
                      final bool isInCart = state.maybeWhen(
                        success: (items, meta) {
                          final productId = _toInt(widget.product.id);
                          print('DEBUG: Checking if product $productId is in cart');
                          print('DEBUG: Cart book_ids: ${meta.bookIds}');
                          final isInCart = meta.containsBookId(productId);
                          print('DEBUG: Is in cart: $isInCart');
                          return isInCart;
                        },
                        orElse: () {
                          print('DEBUG: Cart state is not success');
                          return false;
                        },
                      );
                      
                      final bool isLoading = state.maybeWhen(
                        loading: () => true,
                        orElse: () => false,
                      );

                      print('DEBUG: Final isInCart value: $isInCart');
                      return MainButton(
                        textColor: context.colorScheme.secondary,
                        text: isInCart ? 'مشاهده سبد خرید' : 'افزودن به سبد خرید',
                        backgroundColor: context.colorScheme.primary,
                        isLoading: isLoading,
                        onPressed: isLoading ? null : () {
                          if (isInCart) {
                            Future.microtask(() => context.push('/cart'));
                          } else {
                            _handleAddToCart(context);
                          }
                        },
                      );
                    },
                  ),
                if ((_canReadEpub(widget.product) || _canPlayAudio(widget.product)) && 
                    !isPurchased && 
                    !(hasSubscription && isPremiumUser)) ...[
                  const SizedBox(height: AppSpacing.s12),
                  OutlinedButton.icon(
                    onPressed: _isDownloadingEpub ? null : () => _handleContentOpen(context),
                    icon: _isDownloadingEpub
                        ? SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      context.colorScheme.primary,
                                    ),
                                  ),
                          )
                        : Icon(
                            _isAudioContent(widget.product.type) 
                                ? Icons.play_circle_outline
                                : Icons.menu_book_outlined,
                            color: context.colorScheme.primary,
                            size: 20,
                          ),
                    label: Text(
                      _isDownloadingEpub ? 'در حال بارگذاری...' : 'مطالعه نمونه',
                      style: context.textTheme.bodyLarge?.copyWith(
                                    color: context.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                                  ),
                                ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: AppSpacing.s12),
                      side: BorderSide(
                                color: context.colorScheme.primary,
                        width: 1.5,
                              ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ],
                ],
              ],
          ),
        ],
      ),
    );
  }
}


// تابع پاک‌سازی HTML entities
String cleanHtmlEntities(String text) {
  return text
      .replaceAll('&zwnj;', '')
      .replaceAll('&nbsp;', ' ')
      .replaceAll('&amp;', '&')
      .replaceAll('&laquo;', '"')
      .replaceAll('&raquo;', '"')
      .replaceAll('&quot;', '"')
      .replaceAll('&lt;', '<')
      .replaceAll('&gt;', '>')
      .trim();
}

class IntroductionBox extends StatelessWidget {
  final String introductionText;
  final VoidCallback onTap;

  const IntroductionBox({super.key, required this.introductionText, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final safeText = introductionText.isEmpty ? '...' : introductionText;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s24),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _showFullDescription(context, safeText),
          borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.s20),
        decoration: BoxDecoration(
              color: isDark 
                  ? context.colorScheme.surfaceContainer.withOpacity(0.5)
                  : context.colorScheme.surface.withOpacity(0.6),
              borderRadius: BorderRadius.circular(16),
            border: Border.all(
                color: isDark 
                    ? context.colorScheme.outline.withOpacity(0.15)
                    : context.colorScheme.outline.withOpacity(0.1),
              width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cleanHtmlEntities(_getShortText(safeText, 5)),
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.bodyLarge?.copyWith(
                    height: 1.6,
                    color: isDark 
                        ? context.colorScheme.onSurfaceVariant
                        : context.colorScheme.onSurface.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: AppSpacing.s12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'ادامه مطلب',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                  ),
                    const SizedBox(width: AppSpacing.s4),
                    Icon(
                      Icons.arrow_back_ios,
                      size: 14,
                      color: context.colorScheme.primary,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getShortText(String text, int maxLines) {
    if (text.isEmpty) return '...';
    // Remove HTML tags for preview
    final plainText = RegExp(r'<[^>]*>').allMatches(text).isNotEmpty
        ? text.replaceAll(RegExp(r'<[^>]*>'), '')
        : text;
    final lines = plainText.split('\n');
    if (lines.length <= maxLines) return plainText;
    return lines.take(maxLines).join('\n');
  }

  void _showFullDescription(BuildContext context, String htmlText) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.4,
          maxChildSize: 0.95,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: context.colorScheme.background,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.shadow.withOpacity(0.08),
                    blurRadius: 16,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('توضیحات کامل', style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Builder(
                      builder: (context) {
                        try {
                          return Html(data: cleanHtmlEntities(htmlText.isEmpty ? '...' : htmlText));
                        } catch (e, st) {
                          debugPrint('Error rendering HTML: $e\n$st');
                          return Text(cleanHtmlEntities(htmlText.isEmpty ? '...' : htmlText));
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class MenuAndPersonalDevelopment extends StatelessWidget {
  final VoidCallback onMenuTap;
  final VoidCallback onPersonalDevelopmentTap;
  final String categoryName;
  final bool hasMenu;
  final bool hasPersonalDevelopment;

  const MenuAndPersonalDevelopment({
    super.key,
    required this.onMenuTap,
    required this.onPersonalDevelopmentTap,
    required this.categoryName,
    required this.hasMenu,
    required this.hasPersonalDevelopment,
  });

  @override
  Widget build(BuildContext context) {
    // If neither section has data, don't show the widget at all
    if (!hasMenu && !hasPersonalDevelopment) {
      return const SizedBox.shrink();
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s24, vertical: AppSpacing.s8),
        child: Row(
          children: [
          // Menu section
          if (hasMenu)
            Expanded(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onMenuTap,
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.s16,
                      vertical: AppSpacing.s12,
                    ),
                    decoration: BoxDecoration(
                      color: isDark 
                          ? context.colorScheme.surfaceContainer
                          : context.colorScheme.surface,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isDark 
                            ? context.colorScheme.outline.withOpacity(0.2)
                            : context.colorScheme.outline.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Icon(
                          Icons.list_rounded,
                          color: context.colorScheme.primary,
                          size: 20,
                        ),
                        const SizedBox(width: AppSpacing.s8),
                      Text(
                          'فهرست مطالب',
                          style: context.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                      ),
                    ],
                  ),
                ),
              ),
              ),
            ),
          
          if (hasMenu && hasPersonalDevelopment)
            const SizedBox(width: AppSpacing.s12),
            
          // Personal development section
          if (hasPersonalDevelopment)
            Expanded(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onPersonalDevelopmentTap,
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.s16,
                      vertical: AppSpacing.s12,
                    ),
                    decoration: BoxDecoration(
                      color: isDark 
                          ? context.colorScheme.surfaceContainer
                          : context.colorScheme.surface,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isDark 
                            ? context.colorScheme.outline.withOpacity(0.2)
                            : context.colorScheme.outline.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Icon(
                          Icons.folder_outlined,
                          color: context.colorScheme.primary,
                          size: 20,
                        ),
                        const SizedBox(width: AppSpacing.s8),
                        Flexible(
                          child: Text(
                        categoryName,
                            style: context.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                      ),
                    ],
                  ),
                ),
              ),
              ),
            ),
          ],
      ),
    );
  }
}

void menuOfContents(BuildContext context) {
  final product = context.read<ProductCubit>().state.product;
  if (product?.menuOfContents == null) return;

  showModalBottomSheet(
    isDismissible: true,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius:
          BorderRadius.vertical(top: Radius.circular(AppRadius.corner32)),
    ),
    backgroundColor: context.colorScheme.onPrimary,
    isScrollControlled: false,
    builder: (context) {
      return Padding(
          padding: const EdgeInsets.only(top: AppSpacing.s24),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.s20, vertical: AppSpacing.s8),
                  child: Text(
                    'فهرست مطالب',
                    style: context.textTheme.headlineMedium,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.s8),
                  child: Divider(
                    thickness: 2,
                    color: context.colorScheme.primary,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.s20, vertical: AppSpacing.s8),
                  child: Text(
                    product?.menuOfContents ?? '...',
                    style: context.textTheme.bodyLarge,
                  ),
                ),
              ),
            ],
          ));
    },
  );
}

class MenuOfContentsWidget extends StatelessWidget {
  final MenuOfContentsModel menuOfContentsModel;

  const MenuOfContentsWidget({super.key, required this.menuOfContentsModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.s20,
            vertical: AppSpacing.s16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                menuOfContentsModel.name,
                style: context.textTheme.titleSmall
                    ?.copyWith(fontWeight: FontWeight.w400),
              ),
              Text(
                menuOfContentsModel.duration,
                style: context.textTheme.titleSmall
                    ?.copyWith(fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}

class BookIDSection extends StatelessWidget {
  final VoidCallback onViewPressed;

  const BookIDSection({super.key, required this.onViewPressed});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.s12,
        horizontal: AppSpacing.s24,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
        onTap: onViewPressed,
          borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.s20,
              vertical: AppSpacing.s16,
            ),
          decoration: BoxDecoration(
              color: isDark 
                  ? context.colorScheme.surfaceContainer
                  : context.colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
            border: Border.all(
                color: context.colorScheme.primary.withOpacity(0.3),
                width: 1.5,
            ),
          ),
          child: Row(
            children: [
                Container(
                  padding: const EdgeInsets.all(AppSpacing.s10),
                  decoration: BoxDecoration(
                    color: context.colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                ),
                  child: Icon(
                    Icons.info_outline_rounded,
                    color: context.colorScheme.primary,
                    size: 22,
                  ),
              ),
                const SizedBox(width: AppSpacing.s16),
                Expanded(
                  child: Text(
                    'مشاهده اطلاعات کتاب',
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  ),
                  Icon(
                  Icons.arrow_back_ios,
                    color: context.colorScheme.primary,
                    size: 16,
                  ),
            ],
            ),
          ),
        ),
      ),
    );
  }
}

String formatDate(DateTime? dateTime, bool isPersian) {
  if (dateTime == null) return '';
  
  if (isPersian) {
    // Convert to Persian (Jalali) calendar
    final jalali = Jalali.fromDateTime(dateTime);
    return '${jalali.year}/${jalali.month.toString().padLeft(2, '0')}/${jalali.day.toString().padLeft(2, '0')}';
  } else {
    // English format (Gregorian)
    return '${dateTime.month.toString().padLeft(2, '0')}/${dateTime.day.toString().padLeft(2, '0')}/${dateTime.year}';
  }
}

class UserOpinionsWidget extends StatelessWidget {
  final UserOpinionsModel userOpinionsModel;

  const UserOpinionsWidget({super.key, required this.userOpinionsModel});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductCubit>();
    final state = context.watch<ProductCubit>().state;
    final isPersian = Localizations.localeOf(context).languageCode == 'fa';
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.s24),
      child: Container(
        decoration: BoxDecoration(
            color: context.colorScheme.background,
            borderRadius: BorderRadius.circular(AppRadius.corner20),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 40,
                offset: const Offset(0, 4),
              ),
            ]),
        width: context.fullWidth * 0.5,
        height: context.fullHeight * 0.33,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.s10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppSpacing.s8,
            children: [
              Row(
                spacing: AppSpacing.s10,
                children: [
                  if (userOpinionsModel.userAvatar?.isNotEmpty ?? false)
                    CircleAvatar(
                      radius: AppRadius.corner30,
                      backgroundImage: NetworkImage(userOpinionsModel.userAvatar!),
                      onBackgroundImageError: (exception, stackTrace) {
                        print('Error loading avatar: $exception');
                      },
                    )
                  else
                  CircleAvatar(
                    radius: AppRadius.corner30,
                    child: Image.asset(
                      Assets.pcPerson.path,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "${userOpinionsModel.name} ${userOpinionsModel.family}",
                          style: context.textTheme.titleSmall),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          userOpinionsModel.rate >= 1
                              ? Stack(alignment: Alignment.center, children: [
                                  Icon(
                                    Icons.star,
                                    color: context.colorScheme.secondary,
                                    size: 20,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: context.colorScheme.primary,
                                    size: 15,
                                  ),
                                ])
                              : const Icon(
                                  Icons.star_border,
                                  size: 20,
                                ),
                          userOpinionsModel.rate >= 2
                              ? Stack(alignment: Alignment.center, children: [
                                  Icon(
                                    Icons.star,
                                    color: context.colorScheme.secondary,
                                    size: 20,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: context.colorScheme.primary,
                                    size: 15,
                                  ),
                                ])
                              : const Icon(
                                  Icons.star_border,
                                  size: 20,
                                ),
                          userOpinionsModel.rate >= 3
                              ? Stack(alignment: Alignment.center, children: [
                                  Icon(
                                    Icons.star,
                                    color: context.colorScheme.secondary,
                                    size: 20,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: context.colorScheme.primary,
                                    size: 15,
                                  ),
                                ])
                              : const Icon(
                                  Icons.star_border,
                                  size: 20,
                                ),
                          userOpinionsModel.rate >= 4
                              ? Stack(alignment: Alignment.center, children: [
                                  Icon(
                                    Icons.star,
                                    color: context.colorScheme.secondary,
                                    size: 20,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: context.colorScheme.primary,
                                    size: 15,
                                  ),
                                ])
                              : const Icon(
                                  Icons.star_border,
                                  size: 20,
                                ),
                          userOpinionsModel.rate >= 5
                              ? Stack(alignment: Alignment.center, children: [
                                  Icon(
                                    Icons.star,
                                    color: context.colorScheme.secondary,
                                    size: 20,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: context.colorScheme.primary,
                                    size: 15,
                                  ),
                                ])
                              : const Icon(
                                  Icons.star_border,
                                  size: 20,
                                ),
                        ],
                      ),
                      Text(formatDate(userOpinionsModel.date, isPersian),
                          style: context.textTheme.labelSmall?.copyWith(
                              fontSize: 11,
                              color: context.colorScheme.onSurface.withOpacity(0.7))),
                    ],
                  )
                ],
              ),
              Text(
                userOpinionsModel.opinionText,
                style: context.textTheme.labelSmall,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
              ),
              const Spacer(),
              Row(
                spacing: AppSpacing.s10,
                children: [
                  UsefulOrNotUsefulContainer(
                    text: 'مفید بود',
                    numOfRate: (userOpinionsModel.numOfUseful ?? 0),
                    isSelected: state.selectedUsefulOption == 'مفید بود',
                    onTap: () {
                      cubit.selectUsefulOption('مفید بود');
                    },
                  ),
                  const SizedBox(width: AppSpacing.s10),
                  UsefulOrNotUsefulContainer(
                    text: 'مفید نبود',
                    numOfRate: (userOpinionsModel.numOfNotUseful ?? 0),
                    isSelected: state.selectedUsefulOption == 'مفید نبود',
                    onTap: () {
                      cubit.selectUsefulOption('مفید نبود');
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UsefulOrNotUsefulContainer extends StatelessWidget {
  final String text;
  final int numOfRate;
  final bool isSelected;
  final VoidCallback onTap;

  const UsefulOrNotUsefulContainer({
    super.key,
    required this.text,
    required this.numOfRate,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).colorScheme.primary.withOpacity(0.1) : Colors.transparent,
          border: Border.all(
            color: isSelected ? Theme.of(context).colorScheme.primary : context.colorScheme.primary,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(AppRadius.corner8),
        ),
        width: context.fullWidth * 0.2,
        height: context.fullHeight * 0.03,
        child: Center(
          child: Text(
            "$text ($numOfRate)", 
            style: context.textTheme.labelSmall?.copyWith(
              color: isSelected ? Theme.of(context).colorScheme.primary : null,
              fontWeight: isSelected ? FontWeight.w600 : null,
            ),
          ),
        ),
      ),
    );
  }
}

class RecordReviewsAndScores extends StatelessWidget {
  final String phoneNumber;
  final VoidCallback onSubmitButton;
  final double personRate;
  final ValueChanged<int> onRateChanged;

  const RecordReviewsAndScores({
    super.key,
    required this.phoneNumber,
    required this.onSubmitButton,
    required this.personRate,
    required this.onRateChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final stars = List.generate(5, (index) {
      final starIndex = index + 1;
      return GestureDetector(
        onTap: () => onRateChanged(starIndex),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s4),
          child: Icon(
            personRate >= starIndex ? Icons.star_rounded : Icons.star_outline_rounded,
            size: 36,
            color: personRate >= starIndex
                ? Colors.amber[600]
                : context.colorScheme.onSurface.withOpacity(0.3),
          ),
        ),
      );
    });

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.s16,
        horizontal: AppSpacing.s24,
      ),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.s24),
        decoration: BoxDecoration(
          color: isDark 
              ? context.colorScheme.surfaceContainer
              : context.colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isDark 
                ? context.colorScheme.outline.withOpacity(0.2)
                : context.colorScheme.outline.withOpacity(0.1),
            width: 1,
          ),
        ),
        width: double.infinity,
        child: Column(
          children: [
            Text(
              'نظر شما چیست؟',
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: AppSpacing.s8),
            Text(
              phoneNumber,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
            ),
            ),
            const SizedBox(height: AppSpacing.s20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: stars,
            ),
            const SizedBox(height: AppSpacing.s20),
            SubmitButton(
              onTap: onSubmitButton,
            ),
          ],
        ),
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  final VoidCallback onTap;

  const SubmitButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(
        Icons.edit_outlined,
        color: context.colorScheme.primary,
        size: 20,
      ),
      label: Text(
        'ثبت نظر',
        style: context.textTheme.bodyLarge?.copyWith(
          color: context.colorScheme.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.s24,
          vertical: AppSpacing.s12,
        ),
        side: BorderSide(
          color: context.colorScheme.primary,
          width: 1.5,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
}

class TextAboveList extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const TextAboveList({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s24,
        vertical: AppSpacing.s8,
      ),
      child: Row(
        children: [
          Text(
            text,
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: -0.3,
            ),
          ),
          const Spacer(),
          TextButton.icon(
              onPressed: onPressed,
            icon: Icon(
              Icons.arrow_back_ios,
              size: 16,
                      color: context.colorScheme.primary,
                    ),
            label: Text(
              'مشاهده همه',
              style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// Uncomment this block and set the correct root widget if you want to debug error source in this file directly.
/*
void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    // Print the error and stack trace to the console
    print('FLUTTER ERROR:');
    print(details.exceptionAsString());
    print(details.stack);
  };
  // runApp(MyApp()); // Replace MyApp with your actual root widget if needed
}
*/

