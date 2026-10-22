import 'package:flutter/material.dart';

import '../../core/layout/app_shell.dart';
import '../../core/navigation/app_routes.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/demo_message.dart';

/// Зміна пароля. Демонстраційна: пароль фактично не змінюється.
class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _currentController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    showDemoMessage(
      context,
      'Демонстраційна дія: пароль не змінено, оскільки серверної частини ще немає.',
    );
    _currentController.clear();
    _newController.clear();
    _confirmController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      selected: NavItem.profile,
      title: 'Зміна пароля',
      subtitle: 'Введіть поточний і новий пароль',
      children: [
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: AppCard(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppTextField(
                      label: 'Поточний пароль',
                      controller: _currentController,
                      isPassword: true,
                      textInputAction: TextInputAction.next,
                      validator: (v) => (v == null || v.isEmpty)
                          ? 'Введіть поточний пароль'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      label: 'Новий пароль',
                      controller: _newController,
                      hint: 'Щонайменше 8 символів',
                      isPassword: true,
                      textInputAction: TextInputAction.next,
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Введіть новий пароль';
                        if (v.length < 8) {
                          return 'Пароль має містити щонайменше 8 символів';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      label: 'Підтвердіть новий пароль',
                      controller: _confirmController,
                      isPassword: true,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => _submit(),
                      validator: (v) => v != _newController.text
                          ? 'Паролі не збігаються'
                          : null,
                    ),
                    const SizedBox(height: 24),
                    AppButton(label: 'Підтвердити зміну', onPressed: _submit),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
