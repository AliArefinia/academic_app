import 'package:academic/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:academic/core/helper/app_helper.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/core/router/router.dart';
import 'package:academic/pages/bottom_navigation/bottom_navigation.dart';
import '../../core/theme/const.dart';
import '../../gen/assets.gen.dart';
import '../../widgets/main_button.dart';
import '../../widgets/custom_app_bar.dart';
import 'logic/gift_card_cubit.dart';

class GiftcardPage extends StatelessWidget {
  const GiftcardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return BlocConsumer<GiftcardCubit, GiftcardState>(
      listener: (context, state) {
        if (state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.errorProcessingPaymentWithMessage(state.error.toString())),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<GiftcardCubit>();
        return GestureDetector(
          onTap: () => MyAppHelper().hideKeyboard(context),
          child: Scaffold(
            appBar: CustomAppBar(
              title: l10n.giftCard,
              centerTitle: true,
            ),
            body: state.isPaymentSuccessful
                ? Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppSpacing.s24),
                    child: Column(
                      spacing: AppSpacing.s16,
                      children: [
                        KeyboardVisibilityBuilder(builder: (context, visible) {
                          return visible
                              ? const SizedBox()
                              : const TopIconAndText();
                        }),
                        const SizedBox(
                          height: AppSpacing.s4,
                        ),
                        SuccessfulCardMessage(
                          phoneNumber: cubit.phoneNumberController.text,
                        ),
                      ],
                    ),
                  )
                : state.isContinued
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.s24),
                        child: Column(
                          spacing: AppSpacing.s16,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            KeyboardVisibilityBuilder(
                                builder: (context, visible) {
                              return visible
                                  ? const SizedBox()
                                  : const TopIconAndText();
                            }),
                            Builder(builder: (context) {
                              return PhoneNumberAndPriceSection(
                                phoneNumber: cubit.phoneNumberController.text,
                                price: cubit.priceController.text,
                              );
                            }),
                            BlocBuilder<GiftcardCubit, GiftcardState>(
                              builder: (context, state) {
                                return MainButton(
                                  text: state.isProcessingPayment ? l10n.processing : l10n.confirmAndPay,
                                  backgroundColor: state.isProcessingPayment 
                                    ? context.colorScheme.outline 
                                    : context.colorScheme.primary,
                                  onPressed: state.isProcessingPayment 
                                    ? null 
                                    : () => cubit.processGiftCardPayment(),
                                );
                              },
                            )
                          ],
                        ))
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.s24),
                        child: Column(
                          spacing: AppSpacing.s16,
                          children: [
                            KeyboardVisibilityBuilder(
                                builder: (context, visible) {
                              return visible
                                  ? const SizedBox()
                                  : const TopIconAndText();
                            }),
                            const SizedBox(
                              height: AppSpacing.s4,
                            ),
                            Form(
                              key: _formKey,
                              child: CustomTextField(
                                  controller:
                                      BlocProvider.of<GiftcardCubit>(context)
                                          .phoneNumberController,
                                  hint: l10n.recipientPhoneRequired,
                                  suffixIcon: Icons.phone_outlined),
                            ),
                            BlocBuilder<GiftcardCubit, GiftcardState>(
                              builder: (context, state) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children:
                                      [200000, 500000, 1000000].map((amount) {
                                    return AmountOfMoney(
                                      onTap: () => cubit.selectCharge(amount),
                                      amount: amount,
                                      isSelected:
                                          state.amountOfCharge == amount,
                                    );
                                  }).toList(),
                                );
                              },
                            ),
                            CustomTextField(
                                controller: cubit.priceController,
                                hint: l10n.amountInRial,
                                suffixIcon: Icons.credit_card),
                            MainButton(
                              text: l10n.continueLabel,
                              backgroundColor: context.colorScheme.secondary,
                              textColor: context.colorScheme.onSecondary,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  cubit.showConfirmationAndPaymentSection();
                                }
                              },
                            )
                          ],
                        ),
                      ),
          ),
        );
      },
    );
  }
}

class TopIconAndText extends StatelessWidget {
  const TopIconAndText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSpacing.s12,
      children: [
        const SizedBox(
          height: AppSpacing.s8,
        ),
        Center(
          child: SvgPicture.asset(
            Assets.icGiftBox,
            fit: BoxFit.fill,
            height: context.fullHeight * 0.07,
          ),
        ),
        Text(
          l10n.sendGiftCardToOthers,
          style: context.textTheme.titleMedium,
        )
      ],
    );
  }
}

class CustomTextField extends StatelessWidget {
  final IconData suffixIcon;
  final String hint;
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    required this.hint,
    required this.suffixIcon,
    this.controller,
  });

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
      style: context.textTheme.labelLarge,
      decoration: InputDecoration(
        hintStyle: TextStyle(
            color: context.colorScheme.outline,
            fontSize: 16,
            fontWeight: FontWeight.w400),
        hintTextDirection: TextDirection.rtl,
        suffixIcon: Icon(
          suffixIcon,
          color: context.colorScheme.outline,
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadius.corner10),
            borderSide: BorderSide(color: context.colorScheme.outline)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),
        hintText: hint,
      ),
    );
  }
}

class AmountOfMoney extends StatelessWidget {
  final VoidCallback onTap;
  final int amount;
  final bool isSelected;

  const AmountOfMoney({
    super.key,
    required this.onTap,
    required this.amount,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? context.colorScheme.primary.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.corner10),
          border: Border.all(
            color: isSelected ? Colors.orange : context.colorScheme.outline,
            width: 1,
          ),
        ),
        height: context.fullHeight * 0.07,
        width: context.fullWidth * 0.25,
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              amount.toString(),
              style: context.textTheme.labelLarge?.copyWith(
                  color: isSelected
                      ? context.colorScheme.secondary
                      : context.colorScheme.outline),
            ),
            Text(
              l10n.rialArabic,
              style: context.textTheme.labelLarge?.copyWith(
                  color: isSelected
                      ? context.colorScheme.secondary
                      : context.colorScheme.outline),
            ),
          ],
        )),
      ),
    );
  }
}

class PhoneNumberAndPriceSection extends StatelessWidget {
  final String phoneNumber;
  final String price;

  const PhoneNumberAndPriceSection(
      {super.key, required this.phoneNumber, required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.corner10),
          border: Border.all(
            color: context.colorScheme.outline,
            width: 1,
          )),
      width: double.infinity,
      height: context.fullHeight * 0.15,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s8),
            child: Row(
              children: [
                Text(
                  l10n.mobileNumber,
                  style: context.textTheme.titleMedium?.copyWith(
                      color: context.colorScheme.outline),
                ),
                const Spacer(),
                Text(
                  phoneNumber,
                  style: context.textTheme.titleMedium
                      ?.copyWith(color: context.colorScheme.outline),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s8),
            child: Row(
              children: [
                Text(
                  l10n.paymentAmount,
                  style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: context.colorScheme.outline),
                ),
                const Spacer(),
                Text(
                  l10n.amountRial(price.toString()),
                  style: context.textTheme.titleMedium
                      ?.copyWith(color: context.colorScheme.outline),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SuccessfulCardMessage extends StatelessWidget {
  final String phoneNumber;

  const SuccessfulCardMessage({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.primary,
        borderRadius: BorderRadius.circular(AppRadius.corner10),
        shape: BoxShape.rectangle,
      ),
      width: double.infinity,
      height: context.fullHeight * 0.2,
      child: Center(
        child: Text(
          l10n.giftCardSentToNumber(phoneNumber.toString()),
          style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: context.colorScheme.onPrimary),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
