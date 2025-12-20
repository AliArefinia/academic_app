import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/gen/assets.gen.dart';
import 'package:academic/pages/cart/logic/cart_cubit.dart';

/// A beautiful cart icon with an animated badge showing the number of items
class CartBadgeIcon extends StatelessWidget {
  const CartBadgeIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final itemCount = state.maybeWhen(
          success: (items, meta) => items.length,
          orElse: () => 0,
        );

        return InkWell(
          onTap: () => context.push('/cart'),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(4),
            child: SizedBox(
              width: 28,
              height: 28,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  // Cart Icon
                  SvgPicture.asset(
                    Assets.icShBag,
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      context.colorScheme.onSurface,
                      BlendMode.srcIn,
                    ),
                  ),
                  
                  // Badge - only show if cart has items
                  if (itemCount > 0)
                    Positioned(
                      right: -4,
                      top: -4,
                      child: AnimatedScale(
                        scale: itemCount > 0 ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.elasticOut,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          constraints: const BoxConstraints(
                            minWidth: 18,
                            minHeight: 18,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.red.shade600.withOpacity(0.3),
                                blurRadius: 4,
                                offset: const Offset(0, 1),
                              ),
                            ],
                            border: Border.all(
                              color: Colors.red.shade600,
                              width: 1.5,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              itemCount > 99 ? '99+' : itemCount.toString(),
                              style: TextStyle(
                                color: Colors.red.shade600,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                height: 1.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
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
}

