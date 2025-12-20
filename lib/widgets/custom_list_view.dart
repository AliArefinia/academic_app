import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/core/theme/const.dart';
import 'package:academic/widgets/fade_in_image.dart';

class CustomListView extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final bool showIcon;
  final bool ixExpanded;
  final Widget? leadingWidget;

  const CustomListView({
    super.key,
    required this.items,
    this.showIcon = true,
    required this.ixExpanded ,
    this.leadingWidget,
  });

  @override
  Widget build(BuildContext context) {
    return ixExpanded
        ? Expanded(
            child: ListView.separated(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (context, index) => Divider(
              thickness: 2,
              indent: AppSpacing.s16,
              endIndent: AppSpacing.s16,
              color: context.colorScheme.shadow,
            ),
            itemBuilder: (context, index) {
              final item = items[index];

              return ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: AppSpacing.s16),
                minLeadingWidth: 0,
                leading: item['icon'] != null ? FadeInNetworkImage(imageUrl: item['icon']) : leadingWidget,
                title: Text(
                  item['title'] ?? '',
                  style: context.textTheme.labelLarge
                      ?.copyWith(fontWeight: FontWeight.w400),
                ),
                trailing:
                    showIcon ? const Icon(Icons.keyboard_arrow_left) : null,
                visualDensity: const VisualDensity(vertical: -3),
                onTap: () {
                  if (item['action'] != null) {
                    item['action']!(context);
                  }
                },
              );
            },
          ))
        : ListView.separated(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (context, index) => Divider(
              thickness: 2,
              indent: AppSpacing.s16,
              endIndent: AppSpacing.s16,
              color: context.colorScheme.shadow,
            ),
            itemBuilder: (context, index) {
              final item = items[index];

              return ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: AppSpacing.s16),
                minLeadingWidth: 20,
                
                leading: item['icon'] != null ? FadeInNetworkImage(imageUrl: item['icon'],width: 20,height: 20,) : leadingWidget,
                title: Text(
                  item['title'] ?? '',
                  style: context.textTheme.labelLarge
                      ?.copyWith(fontWeight: FontWeight.w400),
                ),
                trailing:
                    showIcon ? const Icon(Icons.keyboard_arrow_left) : null,
                visualDensity: const VisualDensity(vertical: -3),
                onTap: () {
                  if (item['action'] != null) {
                    item['action']!(context);
                  }
                },
              );
            },
          );
  }
}
