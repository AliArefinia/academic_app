import 'package:academic/l10n/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/core/utils/price_parser.dart';
import 'package:academic/core/theme/const.dart';
import 'package:academic/data/api/product/model/product_model.dart';
import 'package:academic/widgets/main_button.dart';
import '../../core/helper/app_helper.dart';
import '../../gen/assets.gen.dart';
import 'logic/gift_to_others_cubit.dart';

class GifttoothersPage extends StatelessWidget {
  final ProductModel? product;
  
  const GifttoothersPage({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GifttoothersCubit, GifttoothersState>(
      listener: (context, state) {
        state.when(
          initial: () {},
          processing: () {},
          success: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(l10n.giftSentSuccessfully),
                backgroundColor: Colors.green,
              ),
            );
            // Don't pop immediately - let deep link handle navigation
            // Navigator.of(context).pop();
          },
          error: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(l10n.errorProcessingPaymentWithMessage(message.toString())),
                backgroundColor: Colors.red,
              ),
            );
          },
        );
      },
      builder: (context, state) {
        final cubit = context.read<GifttoothersCubit>();
        return GestureDetector(
          onTap: () => MyAppHelper().hideKeyboard(context),
          child: Scaffold(
            appBar: AppBar(
              title: Text(l10n.giftToOthers),
            ),
            body: Padding(
              padding: const EdgeInsets.all(AppSpacing.s20),
              child: Column(
                spacing: AppSpacing.s20,
                children: [
                  if (product != null)
                    MainTopContainer(
                      bookName: product!.name ?? l10n.bookName,
                      author: product!.authors?.isNotEmpty == true ? product!.authors!.first.name ?? l10n.author : l10n.author,
                      publisher: product!.publisher ?? l10n.publisher,
                      bookImage: product!.image ?? Assets.pcAsarmorakab.path,
                      subject: l10n.subject,
                      bookClassification: l10n.classification,
                      price: (product!.price ?? 0).toInt(),
                      discount: product!.discountPrice != null && product!.price != null 
                        ? ((product!.price! - product!.discountPrice!) / product!.price! * 100).round()
                        : 0,
                    ),
                  PhoneNumberTextField(controller: cubit.textEditingController),
                  KeyboardVisibilityBuilder(builder: (context, visible) {
                    return visible
                        ? const SizedBox()
                        : state.when(
                            initial: () => MainButton(
                              text: l10n.pay,
                              backgroundColor: context.colorScheme.primary,
                              onPressed: () {
                                if (product != null) {
                                  cubit.processGiftBookPayment(product!);
                                }
                              },
                            ),
                            processing: () => MainButton(
                              text: l10n.processing,
                              backgroundColor: context.colorScheme.outline,
                              onPressed: null,
                            ),
                            success: () => MainButton(
                              text: l10n.successful,
                              backgroundColor: Colors.green,
                              onPressed: null,
                            ),
                            error: (_) => MainButton(
                              text: l10n.retry,
                              backgroundColor: context.colorScheme.primary,
                              onPressed: () {
                                if (product != null) {
                                  cubit.processGiftBookPayment(product!);
                                }
                              },
                            ),
                          );
                  }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class MainTopContainer extends StatelessWidget {
  final String bookName;
  final String author;
  final String publisher;
  final String bookImage;
  final String subject;
  final String bookClassification;
  final int price;
  final int discount;

  const MainTopContainer(
      {super.key,
      required this.bookName,
      required this.author,
      required this.publisher,
      required this.bookImage,
      required this.subject,
      required this.bookClassification,
      required this.price,
      required this.discount});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color ?? context.colorScheme.surface,
          borderRadius: BorderRadius.circular(AppRadius.corner20),
          boxShadow: [
            BoxShadow(
              color: context.colorScheme.shadow.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 40,
              offset: const Offset(0, 4),
            )
          ],
          shape: BoxShape.rectangle),
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: context.fullHeight * 0.3,
        maxHeight: context.fullHeight * 0.4,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.s12),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            Row(
              spacing: AppSpacing.s10,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    bookImage, 
                    height: context.fullHeight * 0.2,
                    width: 120,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: context.fullHeight * 0.2,
                        width: 120,
                        decoration: BoxDecoration(
                          color: context.mutedFill,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.book, size: 50),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Column(
                    spacing: AppSpacing.s12,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.bookByAuthorPublisher(bookName.toString(), author.toString(), publisher.toString()),
                        style: context.textTheme.headlineSmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        l10n.subjectWithValue(subject.toString()),
                        style: context.textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      Text(
                        l10n.bookClassificationWithValue(bookClassification.toString()),
                        style: context.textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: context.colorScheme.surface,
                            borderRadius:
                                BorderRadius.circular(AppRadius.corner8),
                            shape: BoxShape.rectangle),
                        height: context.fullHeight * 0.04,
                        width: context.fullWidth * 0.25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(
                              Icons.headphones_outlined,
                              size: 15,
                            ),
                            Text(
                              l10n.audioBook,
                              style: context.textTheme.bodySmall,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(AppRadius.corner8),
                    color: Colors.transparent,
                    border: Border.all(
                      color: context.colorScheme.surfaceContainer,
                      width: 1,
                    ),
                  ),
                  width: context.fullWidth * 0.15,
                  height: context.fullHeight * 0.04,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(
                        CupertinoIcons.trash,
                        size: 20,
                      ),
                      Text(
                        l10n.delete,
                        style: context.textTheme.bodySmall,
                      )
                    ],
                  ),
                ),
                Column(
                  children: [
                    Row(
                      spacing: AppSpacing.s10,
                      children: [
                        Text(
                          PriceParser.formatPrice(price.toDouble()),
                          style: context.textTheme.bodyMedium
                              ?.copyWith(
                            decoration:
                            TextDecoration.lineThrough,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: context.colorScheme.primary,
                            borderRadius:
                                BorderRadius.circular(AppRadius.corner5),
                            shape: BoxShape.rectangle,
                          ),
                          height: context.fullHeight * 0.03,
                          width: context.fullWidth * 0.10,
                          child: Center(
                            child: Text("$discount%",
                                style: context.textTheme.headlineSmall),
                          ),
                        ),
                      ],
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: (price * (100 - discount) / 100)
                                .toStringAsFixed(0),
                            style: context.textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          TextSpan(
                            text: l10n.tomanWithSpace,
                            style: context.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: context.colorScheme.secondary),
                          ),
                        ],
                      ),
                    )
                  ],
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

class PhoneNumberTextField extends StatelessWidget {
  final TextEditingController controller;

  const PhoneNumberTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return l10n.pleaseEnterPhoneNumber;
        }
        if (!value.startsWith('09')) {
          return l10n.phoneMustStartWith09;
        }
        if (value.length < 11 && value.length > 11) {
          return l10n.phoneNumberInvalid;
        }
        return null;
      },
      keyboardType: TextInputType.number,
      controller: controller,
      textDirection: TextDirection.rtl,
      decoration: InputDecoration(
        hintStyle: context.textTheme.bodyLarge,
        hintTextDirection: TextDirection.rtl,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadius.corner10),
            borderSide: BorderSide(color: context.colorScheme.outline)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),
        hintText: l10n.friendMobileNumber,
      ),
    );
  }
}
