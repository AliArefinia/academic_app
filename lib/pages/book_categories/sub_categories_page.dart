import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/core/theme/const.dart';
import 'logic/sub_categories_cubit.dart';
import '../../../core/router/router.dart';

class SubCategoriesPage extends StatefulWidget {
  final int categoryId;
  final String categoryTitle;
  const SubCategoriesPage({super.key, required this.categoryId, required this.categoryTitle});

  @override
  State<SubCategoriesPage> createState() => _SubCategoriesPageState();
}

class _SubCategoriesPageState extends State<SubCategoriesPage> {
  @override
  void initState() {
    super.initState();
    context.read<SubCategoriesCubit>().fetchSubCategories(widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubCategoriesCubit, SubCategoriesState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.categoryTitle),
            leading: BackButton(),
          ),
          body: state.when(
            initial: () => const SizedBox(),
            loading: () => const Center(child: CircularProgressIndicator()),
            success: (subCategories) => ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.s16),
              itemCount: subCategories.length,
              separatorBuilder: (context, index) => Divider(
                thickness: 2,
                indent: AppSpacing.s16,
                endIndent: AppSpacing.s16,
                color: context.colorScheme.shadow,
              ),
              itemBuilder: (context, index) {
                final cat = subCategories[index];
                return ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: AppSpacing.s16),
                  minLeadingWidth: 0,
                  leading: cat.image != null && cat.image!.isNotEmpty
                      ? Image.network(cat.image!, width: 24, height: 24, errorBuilder: (context, error, stackTrace) => Icon(Icons.category, color: context.colorScheme.onSurface))
                      : Icon(Icons.category, color: context.colorScheme.onSurface),
                  title: Text(
                    cat.name,
                    style: context.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                  onTap: () {
                    CategoryProductsRoute(id: cat.id, title: cat.name).push(context);
                  },
                );
              },
            ),
            error: (message) => Center(
              child: Text(
                message,
                style: TextStyle(color: context.colorScheme.onSurface),
              ),
            ),
          ),
        );
      },
    );
  }
} 