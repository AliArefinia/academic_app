import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:academic/core/helper/error_helper.dart';
import 'package:academic/core/theme/const.dart';
import 'package:academic/pages/profile_management/userInfo_section.dart';
import 'package:academic/widgets/custom_app_bar.dart';
import 'logic/profile_management_cubit.dart';

class ProfilemanagementPage extends StatelessWidget {
  const ProfilemanagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfilemanagementCubit, ProfilemanagementState>(
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(
            title: 'مدیریت پروفایل',
            icon: Icons.edit_rounded,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.pop(),
            ),
          ),
          body: state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (user, updateError) => SingleChildScrollView(
              child: UserInfoSection(user: user),
            ),
            error: (message) => Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.s16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red,
                    ),
                    const SizedBox(height: AppSpacing.s16),
                    Text(
                      'خطا در بارگذاری پروفایل',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: AppSpacing.s16),
                    Text(ErrorHelper.mapError(message)),
                    const SizedBox(height: AppSpacing.s16),
                    ElevatedButton(
                      onPressed: () => context.read<ProfilemanagementCubit>().loadProfile(),
                      child: const Text('تلاش مجدد'),
                    ),
                  ],
                ),
              ),
            ),
            success: (message) => const Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
