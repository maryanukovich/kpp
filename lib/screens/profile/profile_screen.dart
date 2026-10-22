import 'package:flutter/material.dart';

import '../../core/layout/app_shell.dart';
import '../../core/navigation/app_routes.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/demo_message.dart';
import '../../data/demo_data.dart';

/// Профіль користувача (демонстраційні дані).
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const user = DemoData.user;
    final textTheme = Theme.of(context).textTheme;

    return AppShell(
      selected: NavItem.profile,
      title: 'Профіль',
      subtitle: 'Керування обліковим записом',
      children: [
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: AppCard(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 44,
                      backgroundColor: AppColors.surfaceAlt,
                      child: Text(
                        user.name.substring(0, 1),
                        style: textTheme.headlineMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: TextButton.icon(
                      onPressed: () => showDemoMessage(
                        context,
                        'Демонстраційна дія: завантаження фото профілю буде реалізовано пізніше.',
                      ),
                      icon: const Icon(Icons.photo_camera_outlined, size: 18),
                      label: const Text('Змінити фото'),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    user.name,
                    textAlign: TextAlign.center,
                    style: textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  Text(
                    user.email,
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium
                        ?.copyWith(color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  AppButton(
                    label: 'Редагувати профіль',
                    icon: Icons.edit_outlined,
                    variant: AppButtonVariant.outlined,
                    onPressed: () => showDialog<void>(
                      context: context,
                      builder: (_) => const _EditProfileDialog(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  AppButton(
                    label: 'Змінити пароль',
                    icon: Icons.lock_outline,
                    variant: AppButtonVariant.outlined,
                    onPressed: () =>
                        AppNavigator.push(context, AppRoutes.changePassword),
                  ),
                  const SizedBox(height: 12),
                  AppButton(
                    label: 'Вийти з облікового запису',
                    icon: Icons.logout,
                    variant: AppButtonVariant.danger,
                    onPressed: () => AppNavigator.logout(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _EditProfileDialog extends StatefulWidget {
  const _EditProfileDialog();

  @override
  State<_EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<_EditProfileDialog> {
  final _nameController = TextEditingController(text: DemoData.user.name);
  final _emailController = TextEditingController(text: DemoData.user.email);

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.surface,
      scrollable: true,
      title: const Text('Редагування профілю'),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppTextField(label: 'Ім’я', controller: _nameController),
            const SizedBox(height: 16),
            AppTextField(
              label: 'Електронна пошта',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Скасувати'),
        ),
        FilledButton(
          onPressed: () {
            final messenger = ScaffoldMessenger.of(context);
            Navigator.of(context).pop();
            messenger.hideCurrentSnackBar();
            messenger.showSnackBar(
              const SnackBar(
                content:
                    Text('Демонстраційна дія: зміни профілю не збережено.'),
              ),
            );
          },
          child: const Text('Зберегти'),
        ),
      ],
    );
  }
}
