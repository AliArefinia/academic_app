import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:universal_image_flutter/universal_image_flutter.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/core/router/router.dart';
import 'package:academic/core/theme/const.dart';
import 'package:academic/data/api/cart/model/cart_model.dart';
import 'package:academic/data/api/home/model/book_model.dart';
import 'package:academic/pages/cart/logic/cart_cubit.dart' hide DiscountState;
import 'package:academic/pages/cart/logic/discount_cubit.dart' as discount;
import 'package:academic/pages/payment/logic/payment_cubit.dart';
import 'package:academic/widgets/main_button.dart';
import 'package:academic/widgets/custom_app_bar.dart';
import 'package:academic/data/api/payment/model/payment_model.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GetIt.I<CartCubit>()..getCart()),
        BlocProvider(create: (_) => GetIt.I<PaymentCubit>()),
        BlocProvider(create: (_) => GetIt.I<discount.DiscountCubit>()),
      ],
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: CustomAppBar(
          title: 'سبد خرید',
          icon: Icons.shopping_cart_rounded,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
          actions: [
            BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                return state.maybeWhen(
                  success: (items, meta) => Padding(
                    padding: const EdgeInsetsDirectional.only(end: 16),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: context.colorScheme.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        items.length.toString(),
                        style: context.textTheme.bodySmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  orElse: () => const SizedBox(),
                );
              },
            ),
          ],
          centerTitle: false,
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<PaymentCubit, PaymentState>(
              listener: (context, state) {
                state.whenOrNull(
                  success: (response) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('درگاه پرداخت با موفقیت باز شد'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  error: (message) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  },
                );
              },
            ),
          ],
          child: BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              return state.when(
                initial: () => const Center(child: CircularProgressIndicator()),
                loading: () => const Center(child: CircularProgressIndicator()),
                success: (items, meta) =>
                    _buildCartContent(context, items, meta),
                error: (message) => Center(child: Text(message)),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCartContent(
      BuildContext context, List<CartItemModel> items, CartMeta meta) {
    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 80,
              color: context.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              'سبد خرید شما خالی است',
              style: context.textTheme.titleLarge?.copyWith(
                color: context.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'برای خرید کتاب به صفحه اصلی بروید',
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: MainButton(
                text: 'برو به صفحه اصلی',
                onPressed: () => context.go('/home'),
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: items.length,
                  padding: const EdgeInsets.all(AppSpacing.s16),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return _CartItemCard(
                      item: item,
                      onRemove: () {
                        context.read<CartCubit>().removeFromCart(item.id);
                      },
                    );
                  },
                ),
                _DiscountSection(),
                // Payment Method Section
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardTheme.color ?? context.colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'شیوه پرداخت',
                        style: context.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: context.colorScheme.surfaceContainer,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: context.colorScheme.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(Icons.payment,
                                  color: context.colorScheme.primary, size: 24),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'درگاه پرداخت آنلاین',
                                  style: context.textTheme.titleSmall,
                                ),
                                Text(
                                  'پرداخت با همه کارت های عضو شتاب',
                                  style: context.textTheme.bodySmall?.copyWith(
                                    color: context.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Icon(Icons.check_circle,
                                color: context.colorScheme.primary),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Invoice Section
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardTheme.color ?? context.colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'فاکتور خرید',
                        style: context.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'جمع کل',
                            style: context.textTheme.titleMedium?.copyWith(
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          Text(
                            '${meta.formattedTotalAmount} تومان',
                            style: context.textTheme.titleMedium?.copyWith(
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'سود شما در این خرید',
                            style: context.textTheme.titleMedium?.copyWith(
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          Text(
                            '${meta.formattedTotalDiscount} تومان',
                            style: context.textTheme.titleMedium?.copyWith(
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Divider(color: context.colorScheme.outline),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'مبلغ قابل پرداخت',
                            style: context.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${meta.total} تومان',
                            style: context.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Payment Button
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).cardTheme.color ?? context.colorScheme.surface,
            boxShadow: [
              BoxShadow(
                color: context.colorScheme.shadow.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SafeArea(
            child: BlocListener<PaymentCubit, PaymentState>(
              listener: (context, state) {
                state.whenOrNull(
                  error: (message) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  },
                );
              },
              child: BlocBuilder<PaymentCubit, PaymentState>(
                builder: (context, paymentState) {
                  return MainButton(
                    text: paymentState.maybeWhen(
                      loading: () => 'در حال پردازش...',
                      orElse: () => 'پرداخت - ${meta.total} تومان',
                    ),
                    backgroundColor: context.colorScheme.primary,
                    textColor: context.colorScheme.onPrimary,
                    height: 56,
                    isLoading: paymentState.maybeWhen(
                      loading: () => true,
                      orElse: () => false,
                    ),
                    onPressed: paymentState.maybeWhen(
                      loading: () => null,
                      orElse: () => () => _handlePayment(context, meta),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _handlePayment(BuildContext context, CartMeta meta) async {
    try {
      // Extract book IDs from cart meta
      final bookIds = meta.bookIds
          .map((id) => id is int ? id : int.tryParse(id.toString()))
          .where((id) => id != null)
          .cast<int>()
          .toList();

      // Get discount code from discount cubit state
      String? discountCode;
      final discountCubit = context.read<discount.DiscountCubit>();
      discountCubit.state.maybeWhen(
        valid: (message, code) => discountCode = code,
        orElse: () => discountCode = null,
      );

      // Use PaymentCubit directly to trigger loading state
      final paymentCubit = context.read<PaymentCubit>();
      await paymentCubit.createPayment(
        amount: meta.total,
        discountCode: discountCode,
        gatewayName: 'zarinpal',
        bookIds: bookIds.isNotEmpty ? bookIds : null,
        type: PaymentType.book,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('خطا در پردازش پرداخت: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

class _CartItemCard extends StatelessWidget {
  final CartItemModel item;
  final VoidCallback onRemove;

  const _CartItemCard({
    required this.item,
    required this.onRemove,
  });

  String _getBookTypeText(String? type) {
    switch (type?.toLowerCase()) {
      case 'audio':
        return 'کتاب صوتی';
      case 'epub':
        return 'کتاب متنی';
      default:
        return 'کتاب متنی';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final bookModel = BookModel(
          id: item.id.toString(),
          name: item.name,
          image: item.image,
          price: item.price.toDouble(),
          discountPrice: item.discountPrice.toDouble(),
          type: item.type,
        );
        ProductRoute(bookModel).push(context);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.s12),
        padding: const EdgeInsets.all(AppSpacing.s16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color ?? context.colorScheme.surface,
          borderRadius: BorderRadius.circular(AppRadius.corner20),
          boxShadow: [
            BoxShadow(
              color: context.colorScheme.shadow.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: UniversalImageLoader(
                path: item.image,
                option: UniversalImageLoaderOption(
                  width: 90,
                  height: 130,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.s12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  if (item.publisher?.isNotEmpty ?? false) ...[
                    Text(
                      item.publisher!,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                  if (item.categories.isNotEmpty) ...[
                    Text(
                      'موضوع: ${item.categories.first.join(' - ')}',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 4),
                  ],
                  Row(
                    children: [
                      if (item.type != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: context.colorScheme.surfaceContainer,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            _getBookTypeText(item.type),
                            style: context.textTheme.bodySmall?.copyWith(
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: onRemove,
                        color: context.colorScheme.error,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DiscountSection extends StatefulWidget {
  const _DiscountSection();

  @override
  State<_DiscountSection> createState() => _DiscountSectionState();
}

class _DiscountSectionState extends State<_DiscountSection> {
  bool _isExpanded = false;
  final _discountController = TextEditingController();

  @override
  void dispose() {
    _discountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color ?? context.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => setState(() => _isExpanded = !_isExpanded),
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Text(
                      'استفاده از کد تخفیف',
                      style: context.textTheme.titleMedium,
                    ),
                    const Spacer(),
                    AnimatedRotation(
                      turns: _isExpanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: Icon(Icons.keyboard_arrow_down,
                          color: context.colorScheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox(height: 0),
            secondChild: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: BlocConsumer<discount.DiscountCubit,
                  discount.DiscountState>(
                listener: (context, state) {
                  state.maybeWhen(
                    valid: (message, code) {
                      _discountController.clear();
                    },
                    orElse: () {},
                  );
                },
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _discountController,
                              enabled: !state.maybeWhen(
                                validating: () => true,
                                orElse: () => false,
                              ),
                              decoration: InputDecoration(
                                hintText: 'کد تخفیف خود را وارد کنید',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12),
                                errorMaxLines: 2,
                                errorStyle: const TextStyle(height: 1),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          SizedBox(
                            height: 48,
                            child: ElevatedButton(
                              onPressed: state.maybeWhen(
                                validating: () => null,
                                orElse: () => () {
                                  if (_discountController.text.isNotEmpty) {
                                    context
                                        .read<discount.DiscountCubit>()
                                        .validateDiscount(
                                            _discountController.text);
                                  }
                                },
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: context.colorScheme.primary,
                                foregroundColor: context.colorScheme.onPrimary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                minimumSize: const Size(80, 48),
                              ),
                              child: state.maybeWhen(
                                validating: () => SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: FittedBox(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        context.colorScheme.onPrimary,
                                      ),
                                    ),
                                  ),
                                ),
                                orElse: () => const Text('اعمال'),
                              ),
                            ),
                          ),
                        ],
                      ),
                      state.maybeWhen(
                        valid: (message, code) => Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Row(
                            children: [
                              Icon(Icons.check_circle,
                                  color: context.colorScheme.primary, size: 16),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  message,
                                  style:
                                      context.textTheme.bodySmall?.copyWith(
                                    color: context.colorScheme.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        invalid: (message) => Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Row(
                            children: [
                              Icon(Icons.error_outline,
                                  color: context.colorScheme.error, size: 16),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  message,
                                  style:
                                      context.textTheme.bodySmall?.copyWith(
                                    color: context.colorScheme.error,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        orElse: () => const SizedBox(),
                      ),
                    ],
                  );
                },
              ),
            ),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
          ),
        ],
      ),
    );
  }
}
