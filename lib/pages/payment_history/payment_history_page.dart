import 'package:academic/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/core/theme/const.dart';
import 'package:academic/widgets/main_button.dart';
import 'package:academic/widgets/custom_app_bar.dart';
import 'package:academic/gen/assets.gen.dart';
import '../../../data/api/payment_history/model/payment_history_model.dart';
import 'logic/payment_history_cubit.dart';

class PaymenthistoryPage extends StatefulWidget {
  const PaymenthistoryPage({super.key});

  @override
  State<PaymenthistoryPage> createState() => _PaymenthistoryPageState();
}

class _PaymenthistoryPageState extends State<PaymenthistoryPage> {
  @override
  void initState() {
    super.initState();
    context.read<PaymenthistoryCubit>().getPaymentHistory();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymenthistoryCubit, PaymenthistoryState>(
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(
            title: l10n.paymentHistory,
            icon: Icons.history_rounded,
          ),
          body: state.when(
            initial: () => const SizedBox(),
            loading: () => const Center(child: CircularProgressIndicator()),
            success: (payments) => payments.isEmpty
                ? const PaymentHistoryIsEmpty()
                : CustomScrollView(
                    scrollDirection: Axis.vertical,
                    slivers: [
                      const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: AppSpacing.s32),
                          child: TopIcon(),
                        ),
                      ),
                      SliverList.builder(
                        itemCount: payments.length,
                        itemBuilder: (context, index) => PaymentHistoryWidget(
                          paymentHistoryModel: payments[index],
                        ),
                      )
                    ],
                  ),
            error: (message) => Center(child: Text(message)),
          ),
        );
      },
    );
  }
}

class PaymentHistoryWidget extends StatelessWidget {
  final PaymentHistoryModel paymentHistoryModel;

  const PaymentHistoryWidget({super.key, required this.paymentHistoryModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.s10, horizontal: AppSpacing.s20),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.corner20),
            color: Theme.of(context).cardTheme.color ?? context.colorScheme.surface,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.black.withOpacity(0.3)
                    : Colors.black.withOpacity(0.1),
                spreadRadius: 0,
                offset: const Offset(0, 4),
                blurRadius: 40,
              ),
            ]),
        width: double.infinity,
        height: context.fullHeight * 0.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            WidgetsInCards(
                rightText: l10n.dateLabel, leftText: paymentHistoryModel.date ?? ''),
            WidgetsInCards(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.purchaseLabel,
                    style: context.textTheme.titleSmall,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: paymentHistoryModel.books?.map((book) => Padding(
                          padding: const EdgeInsets.only(top: AppSpacing.s4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  book.name ?? '',
                                  style: context.textTheme.titleSmall
                                      ?.copyWith(color: context.colorScheme.primary),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: AppSpacing.s4),
                              Container(
                                decoration: BoxDecoration(
                                  color: context.colorScheme.surfaceContainer,
                                  borderRadius: BorderRadius.circular(AppRadius.corner8),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s8, vertical: AppSpacing.s4),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      book.type == 'صوتی' || book.type == 'audio'
                                          ? Icons.headphones_outlined
                                          : Icons.menu_book_outlined,
                                      size: 16,
                                      color: context.colorScheme.onSurface,
                                    ),
                                    const SizedBox(width: AppSpacing.s4),
                                    Flexible(
                                      child: Text(
                                        book.type ?? '',
                                        style: context.textTheme.bodySmall,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )).toList() ?? [],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
                    child: Divider(
                      thickness: 1,
                      color: context.colorScheme.outline,
                    ),
                  )
                ],
              ),
            ),
            WidgetsInCards(
                rightText: l10n.amountLabel,
                leftText: l10n.amountTomanTrailing(paymentHistoryModel.paidAmount ?? '')),
            WidgetsInCards(
                rightText: l10n.viaLabel,
                leftText: paymentHistoryModel.gatewayName ?? ''),
            WidgetsInCards(
                child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.statusLabel,
                      style: context.textTheme.titleSmall,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          paymentHistoryModel.status == 'موفق'
                              ? Icons.check_circle
                              : Icons.cancel,
                          color: paymentHistoryModel.status == 'موفق'
                              ? Colors.green
                              : Colors.red,
                          size: 20,
                        ),
                        const SizedBox(width: AppSpacing.s4),
                        Text(
                          paymentHistoryModel.status ?? l10n.unknown,
                          style: context.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w400,
                            color: paymentHistoryModel.status == 'موفق'
                                ? Colors.green
                                : paymentHistoryModel.status == 'ناموفق'
                                    ? Colors.red
                                    : null,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
                  child: Divider(
                    thickness: 1,
                    color: context.colorScheme.outline,
                  ),
                )
              ],
            )),
            WidgetsInCards(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.trackingCodeLabel,
                        style: context.textTheme.titleSmall,
                      ),
                      Expanded(
                        child: SelectableText(
                          paymentHistoryModel.trackingCode ?? '',
                          style: context.textTheme.titleSmall
                              ?.copyWith(fontWeight: FontWeight.w400),
                          textAlign: TextAlign.end,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
                    child: Divider(
                      thickness: 1,
                      color: context.colorScheme.outline,
                    ),
                  )
                ],
              ),
            ),
            WidgetsInCards(
                isDividerVisible: false,
                rightText: l10n.discountLabel,
                leftText: "${paymentHistoryModel.discountPercent ?? ''}%"),
          ],
        ),
      ),
    );
  }
}

class WidgetsInCards extends StatelessWidget {
  final String? rightText;
  final String? leftText;
  final bool? isDividerVisible;
  final Widget? child;

  const WidgetsInCards(
      {super.key,
      this.rightText,
      this.leftText,
      this.isDividerVisible,
      this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s12),
      child: rightText != null
          ? Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      rightText!,
                      style: context.textTheme.titleSmall,
                    ),
                    Flexible(
                      child: Text(
                        leftText ?? '',
                        style: context.textTheme.titleSmall
                            ?.copyWith(fontWeight: FontWeight.w400),
                        textAlign: TextAlign.end,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
                  child: isDividerVisible == null
                      ? Divider(
                          thickness: 1,
                          color: context.colorScheme.outline,
                        )
                      : const SizedBox(),
                )
              ],
            )
          : child,
    );
  }
}

class PaymentHistoryIsEmpty extends StatelessWidget {
  const PaymentHistoryIsEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s24),
          child: Column(
            spacing: AppSpacing.s48,
            children: [
              const TopIcon(),
              const MidPicture(),
              const MidTexts(),
              MainButton(
                radius: AppSpacing.s20,
                text: l10n.store,
                backgroundColor: context.colorScheme.primary,
                onPressed: () {},
              )
            ],
          ),
        )
      ],
    );
  }
}

class TopIcon extends StatelessWidget {
  const TopIcon({super.key});

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
            Assets.icBankcard,
            fit: BoxFit.fill,
            height: context.fullHeight * 0.07,
          ),
        ),
      ],
    );
  }
}

class MidPicture extends StatelessWidget {
  const MidPicture({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      Assets.pcBankcard,
      fit: BoxFit.fill,
    );
  }
}

class MidTexts extends StatelessWidget {
  const MidTexts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSpacing.s20,
      children: [
        Text(
          l10n.noPurchasesYet,
          style: context.textTheme.bodyLarge,
        ),
        Text(
          l10n.paymentHistoryHint,
          style: context.textTheme.bodyMedium,
        )
      ],
    );
  }
}
