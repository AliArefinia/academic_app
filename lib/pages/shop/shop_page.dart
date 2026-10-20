import 'package:academic/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:academic/core/helper/app_helper.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/core/router/router.dart';
import 'package:academic/core/theme/const.dart';
import 'package:academic/data/api/product/model/product_model.dart';
import 'package:academic/widgets/animated_section.dart';
import 'package:academic/widgets/shop_product_card.dart';
import 'package:academic/widgets/shimmer_loading.dart';
import 'package:academic/widgets/error_state_widget.dart';
import 'package:academic/widgets/empty_state_widget.dart';
import 'package:academic/gen/assets.gen.dart';
import 'logic/shop_cubit.dart';
import 'logic/shop_state.dart';
import 'dart:async';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  bool _showContent = false;
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    // Delay to trigger animation
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _showContent = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (value.isEmpty) {
        context.read<ShopCubit>().setSearchQuery(null);
      } else if (value.length > 1) {
        context.read<ShopCubit>().setSearchQuery(value);
      }
    });
  }


  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.s8),
            decoration: BoxDecoration(
              color: context.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(AppRadius.corner12),
            ),
            child: Icon(
              Icons.shopping_bag_rounded,
              color: context.colorScheme.onPrimaryContainer,
              size: 24,
            ),
          ),
          const SizedBox(width: AppSpacing.s12),
          Text(l10n.marketplace, style: context.textTheme.headlineMedium),
        ],
      ),
      elevation: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit, ShopState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () => MyAppHelper().hideKeyboard(context),
          child: Scaffold(
            appBar: _buildAppBar(context),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                const UploadproductRoute().push(context);
              },
              icon: Icon(
                Icons.upload_file_rounded,
                color: context.colorScheme.onPrimary,
              ),
              label: Text(
                l10n.uploadProduct,
                style: TextStyle(
                  color: context.colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              backgroundColor: context.colorScheme.primary,
              elevation: 4,
            ),
            body: SafeArea(
              child: Column(
                children: [
                  // Search and Filter Bar
                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.s20),
                    child: Column(
                      children: [
                        // Search Bar
                        Container(
                          height: context.fullHeight * 0.0625,
                          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppRadius.corner12),
                            color: context.colorScheme.surface,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _searchController,
                                  onChanged: (value) {
                                    setState(() {});
                                    _onSearchChanged(value);
                                  },
                                  onSubmitted: (value) {
                                    if (value.isEmpty) {
                                      context.read<ShopCubit>().setSearchQuery(null);
                                    } else if (value.length > 1) {
                                      context.read<ShopCubit>().setSearchQuery(value);
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hintText: l10n.searchMarketplace,
                                    hintStyle: context.textTheme.bodyMedium,
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    focusedErrorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                  style: context.textTheme.labelLarge,
                                  textDirection: TextDirection.rtl,
                                ),
                              ),
                              if (_searchController.text.isNotEmpty)
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _searchController.clear();
                                    });
                                    context.read<ShopCubit>().setSearchQuery(null);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                    child: Icon(
                                      Icons.close,
                                      size: AppSpacing.s20,
                                      color: context.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                )
                              else
                                SvgPicture.asset(
                                  Assets.icSearch,
                                  width: AppSpacing.s20,
                                  height: AppSpacing.s20,
                                  colorFilter: ColorFilter.mode(
                                    context.colorScheme.onSurfaceVariant,
                                    BlendMode.srcIn,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Content
                  Expanded(
                    child: state.when(
                      initial: () => const SizedBox.shrink(),
                      loading: () => _buildLoadingState(context),
                      empty: () => EmptyStateWidget(
                        title: l10n.noContent,
                        message: l10n.noProductsInMarketplace,
                        iconAsset: Assets.icShop,
                      ),
                      error: (message) => ErrorStateWidget(
                        error: message,
                        onRetry: () => context.read<ShopCubit>().fetchShopData(),
                      ),
                      success: (data) {
                        final pamphlets = data.pamphlets?.data ?? [];
                        final educational = data.educational?.data ?? [];
                        final questionBank = data.questionBank?.data ?? [];
                        final periodical = data.periodical?.data ?? [];
                        final quarterly = data.quarterly?.data ?? [];
                        final monthly = data.monthly?.data ?? [];
                        final yearbook = data.yearbook?.data ?? [];

                        return ListView(
                          padding: const EdgeInsets.symmetric(vertical: AppSpacing.s16),
                          children: [
                    if (pamphlets.isNotEmpty)
                      AnimatedSection(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeOutCubic,
                        offset: 40,
                        isVisible: _showContent,
                        child: _buildSection(context, l10n.handouts, pamphlets),
                      ),
                    if (educational.isNotEmpty)
                      AnimatedSection(
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeOutCubic,
                        offset: 35,
                        isVisible: _showContent,
                        child: _buildSection(context, l10n.educationalContent, educational),
                      ),
                    if (questionBank.isNotEmpty)
                      AnimatedSection(
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.easeOutCubic,
                        offset: 30,
                        isVisible: _showContent,
                        child: _buildSection(context, l10n.questionBank, questionBank),
                      ),
                    if (periodical.isNotEmpty)
                      AnimatedSection(
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.easeOutCubic,
                        offset: 25,
                        isVisible: _showContent,
                        child: _buildSection(context, l10n.periodical, periodical),
                      ),
                    if (quarterly.isNotEmpty)
                      AnimatedSection(
                        duration: const Duration(milliseconds: 1200),
                        curve: Curves.easeOutCubic,
                        offset: 20,
                        isVisible: _showContent,
                        child: _buildSection(context, l10n.quarterly, quarterly),
                      ),
                    if (monthly.isNotEmpty)
                      AnimatedSection(
                        duration: const Duration(milliseconds: 1400),
                        curve: Curves.easeOutCubic,
                        offset: 15,
                        isVisible: _showContent,
                        child: _buildSection(context, l10n.monthlyMagazine, monthly),
                      ),
                    if (yearbook.isNotEmpty)
                      AnimatedSection(
                        duration: const Duration(milliseconds: 1600),
                        curve: Curves.easeOutCubic,
                        offset: 10,
                        isVisible: _showContent,
                        child: _buildSection(context, l10n.yearbook, yearbook),
                      ),
                          ],
                        );
                      },
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

  Widget _buildLoadingState(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.s20),
      children: [
        // Section Header Shimmer
        ShimmerLoading(
          width: double.infinity,
          height: 24,
          borderRadius: 8,
        ),
        const SizedBox(height: AppSpacing.s20),
        // Grid Shimmer
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.72,
            crossAxisSpacing: AppSpacing.s16,
            mainAxisSpacing: AppSpacing.s16,
          ),
          itemCount: 4,
          itemBuilder: (context, index) {
            return ShimmerLoading(
              width: double.infinity,
              height: double.infinity,
              borderRadius: AppRadius.corner20,
            );
          },
        ),
        const SizedBox(height: AppSpacing.s32),
        // Another Section
        ShimmerLoading(
          width: double.infinity,
          height: 24,
          borderRadius: 8,
        ),
        const SizedBox(height: AppSpacing.s20),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.72,
            crossAxisSpacing: AppSpacing.s16,
            mainAxisSpacing: AppSpacing.s16,
          ),
          itemCount: 4,
          itemBuilder: (context, index) {
            return ShimmerLoading(
              width: double.infinity,
              height: double.infinity,
              borderRadius: AppRadius.corner20,
            );
          },
        ),
      ],
    );
  }

  Widget _buildSection(BuildContext context, String title, List<ProductModel> products) {
    // اگر لیست خالی است یا null است، چیزی نمایش نده
    if (products.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.s32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header with decorative line
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s20),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 24,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        context.colorScheme.primary,
                        context.colorScheme.primary.withOpacity(0.3),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: AppSpacing.s12),
                Text(
                  title,
                  style: context.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                const Spacer(),
                Text(
                  l10n.productsCount(products.length),
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.s20),
          // Grid Layout for Products
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s20),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.68,
                crossAxisSpacing: AppSpacing.s16,
                mainAxisSpacing: AppSpacing.s16,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ShopProductCard(
                  product: product,
                  onTap: () => ProductRoute(product).push(context),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

