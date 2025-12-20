import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/core/utils/price_parser.dart';
import 'package:academic/data/api/product/model/product_model.dart';
import 'package:academic/widgets/custom_app_bar.dart';
import '../../core/theme/const.dart';
import 'logic/book_i_d_cubit.dart';

class BookidPage extends StatelessWidget {
  final ProductModel product;

  const BookidPage({
    super.key,
    required this.product,
  });

  String _formatFileSize(dynamic size) {
    if (size == null) return '...';
    double sizeInBytes = 0.0;
    if (size is int) {
      sizeInBytes = size.toDouble();
    } else if (size is double) {
      sizeInBytes = size;
    } else {
      return '...';
    }
    final sizeInMB = sizeInBytes / (1024 * 1024);
    return '${sizeInMB.toStringAsFixed(1)} مگابایت';
  }

  String _formatTime(String? time) {
    if (time == null || time.isEmpty) return '...';
    return time;
  }

  bool _isEpubContent(String? type) {
    return type == 'epub' || type == 'text' || type == '6';
  }

  bool _isAudioContent(String? type) {
    return type == 'audio';
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

  String _getFormatText(ProductModel product) {
    if (_isAudioContent(product.type)) {
      return 'mp3';
    } else if (_isPdfContent(product)) {
      return 'pdf';
    } else if (_isEpubContent(product.type)) {
      return 'epub';
    } else {
      return product.type ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isAudio = _isAudioContent(product.type);
    
    return BlocBuilder<BookidCubit, BookidState>(
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(
            title: 'شناسه',
            icon: Icons.info_outline_rounded,
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                // format
                if (product.type != null)
                  RowInfo(
                    rightText: 'فرمت',
                    leftText: _getFormatText(product),
                  ),
                
                // volume
                if (product.fileSize != null)
                  RowInfo(
                    rightText: 'حجم',
                    leftText: _formatFileSize(product.fileSize),
                  ),

                // duration - only for audio books
                if (isAudio && product.time != null)
                  RowInfo(
                    rightText: 'مدت زمان',
                    leftText: _formatTime(product.time),
                  ),

                // author
                if (product.authors != null && product.authors!.isNotEmpty)
                  RowInfo(
                    rightText: 'نویسنده',
                    leftText: product.authors!.map((a) => a.name).join('، '),
                  ),

                // translator
                if (product.translator != null && product.translator!.isNotEmpty)
                  RowInfo(
                    rightText: 'مترجم',
                    leftText: product.translator!,
                  ),

                // speaker - only for audio books
                if (isAudio && product.speaker != null && product.speaker!.isNotEmpty)
                  RowInfo(
                    rightText: 'راوی',
                    leftText: product.speaker!,
                  ),

                // publisher
                if (product.publisher != null && product.publisher!.isNotEmpty)
                  RowInfo(
                    rightText: 'ناشر',
                    leftText: product.publisher!,
                  ),

                // language
                const RowInfo(
                  rightText: 'زبان',
                  leftText: 'فارسی',
                ),

                // publication date
                if (product.publishYear != null)
                  RowInfo(
                    rightText: 'تاریخ انتشار',
                    leftText: product.publishYear.toString(),
                  ),

                // price
                if (product.price != null && product.price! > 0)
                  RowInfo(
                    rightText: 'قیمت',
                    leftText: '${PriceParser.formatPrice(product.price)} تومان',
                  ),

                // Read and download the file
                const RowInfo(
                  isDividerHide: true,
                  rightText: 'مطالعه و دانلود فایل',
                  leftText: 'در برنامه دانشگاه امام صادق (ع)',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class RowInfo extends StatelessWidget {
  final String rightText;
  final String leftText;
  final bool? isDividerHide;

  const RowInfo(
      {super.key,
      required this.rightText,
      required this.leftText,
      this.isDividerHide});

  @override
  Widget build(BuildContext context) {
    return isDividerHide == null
        ? Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.s24, vertical: AppSpacing.s12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(rightText,style: context.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400)),
                    Text(leftText,style: context.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400)),
                  ],
                ),
              ),
              const Divider(),
            ],
          )
        : Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.s24, vertical: AppSpacing.s12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(rightText,style: context.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400)),
                Text(leftText,style: context.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400)),
              ],
            ),
          );
  }
}
