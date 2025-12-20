import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/core/router/router.dart';
import 'package:academic/pages/gift_card/gift_card_page.dart';
import 'package:academic/pages/gift_card/logic/gift_card_cubit.dart';
import '../../core/helper/app_helper.dart';
import '../../core/theme/const.dart';
import '../../gen/assets.gen.dart';
import '../../widgets/main_button.dart';
import '../../widgets/custom_app_bar.dart';
import '../bottom_navigation/bottom_navigation.dart';
import 'logic/wallet_cubit.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WalletCubit, WalletState>(
      listener: (context, state) {
        if (state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('خطا در پردازش پرداخت: ${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
        if (state.isPaymentSuccessful) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('کیف پول با موفقیت شارژ شد!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<WalletCubit>();
        return GestureDetector(
          onTap: () => MyAppHelper().hideKeyboard(context),
          child: Scaffold(
            bottomNavigationBar: BottomNavigationWidget(
              currentIndex: state.index,
              onTap: (value) => cubit.selectIndex(value),
            ),
            appBar: CustomAppBar(
              title: 'کیف پول',
              icon: Icons.account_balance_wallet_rounded,
              leading: IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back),
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s24),
              child: Column(
                spacing: AppSpacing.s16,
                children: <Widget>[
                  KeyboardVisibilityBuilder(builder: (context, visible) {
                    return visible
                        ? const SizedBox()
                        : TopIconAndText(
                            currentMoney: state.currentMoney,
                          );
                  }),
                  CustomTextField(
                    controller: cubit.amountOfMoneyController,
                    hint: 'مبلغ دلخواه (تومان)',
                  ),
                  BlocBuilder<WalletCubit, WalletState>(
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children:
                        [10000, 20000,].map((amount) {
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
                  BlocBuilder<WalletCubit, WalletState>(
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children:
                        [50000, 100000,].map((amount) {
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
                  BlocBuilder<WalletCubit, WalletState>(
                    builder: (context, state) {
                      return MainButton(
                        text: state.isProcessingPayment ? 'در حال پردازش...' : 'شارژ کیف پول',
                        backgroundColor: state.isProcessingPayment
                            ? context.colorScheme.outline
                            : cubit.amountOfMoneyController.text.isNotEmpty
                                ? context.colorScheme.secondary
                                : context.colorScheme.outline,
                        onPressed: state.isProcessingPayment 
                            ? null 
                            : () => cubit.chargeWalletAction(),
                      );
                    },
                  ),
                  KeyboardVisibilityBuilder(builder: (context, visible) {
                    return visible
                        ? const SizedBox()
                        : Text('فعالسازی کارت هدیه',style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600
                    ),);
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

class TopIconAndText extends StatelessWidget {
  final int currentMoney;

  const TopIconAndText({super.key, required this.currentMoney});

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
            Assets.icWallet,
            fit: BoxFit.fill,
            height: context.fullHeight * 0.07,
          ),
        ),
        Text(
          "موجودی فعلی\n $currentMoney تومان",
          textAlign: TextAlign.center,
          style: context.textTheme.titleMedium,
        )
      ],
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    required this.hint,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSpacing.s12,
      children: [
        Align(
            alignment: Alignment.centerRight,
            child: Text(' تعیین مبلغ',style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),)),
        TextFormField(
          keyboardType: TextInputType.number,
          controller: controller,
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
            hintStyle: TextStyle(
                color: context.colorScheme.outline,
                fontSize: 16,
                fontWeight: FontWeight.w400),
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
            hintText: hint,
          ),
        ),
      ],
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
          color: isSelected ? context.colorScheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.corner10),
          border: Border.all(
            color: isSelected ? context.colorScheme.primary : context.colorScheme.outline,
            width: 1,
          ),
        ),
        height: context.fullHeight * 0.07,
        width: context.fullWidth * 0.4,
        child: Center(
            child: Row(
              spacing: AppSpacing.s4,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  amount.toString(),
                  style: context.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                      color: isSelected
                          ? context.colorScheme.onPrimary
                          : context.colorScheme.secondary),
                ),
                Text(
                  'تومان',
                  style: context.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: isSelected
                          ? context.colorScheme.onPrimary
                          : context.colorScheme.secondary),
                ),
              ],
            )),
      ),
    );
  }
}