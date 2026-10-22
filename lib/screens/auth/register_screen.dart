import 'package:flutter/material.dart';

import '../../core/navigation/app_routes.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/auth_layout.dart';
import '../../core/widgets/demo_message.dart';

/// Екран реєстрації. Демонстраційний: обліковий запис нікуди не зберігається.
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  String? _required(String? value, String message) =>
      (value == null || value.trim().isEmpty) ? message : null;

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    showDemoMessage(
      context,
      'Демонстраційна реєстрація: обліковий запис не створено, дані не збережено.',
    );
    Navigator.of(context).pushReplacementNamed(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    final muted = Theme.of(context)
        .textTheme
        .bodySmall
        ?.copyWith(color: AppColors.textSecondary);

    return AuthLayout(
      title: 'Реєстрація',
      subtitle: 'Створіть обліковий запис RenoManager',
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppTextField(
                label: 'Ім’я',
                controller: _nameController,
                hint: 'Ваше ім’я',
                prefixIcon: Icons.person_outline,
                textInputAction: TextInputAction.next,
                validator: (v) => _required(v, 'Введіть ім’я'),
              ),
              const SizedBox(height: 16),
              AppTextField(
                label: 'Електронна пошта',
                controller: _emailController,
                hint: 'name@example.com',
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icons.mail_outline,
                textInputAction: TextInputAction.next,
                validator: (v) {
                  final text = v?.trim() ?? '';
                  if (text.isEmpty) return 'Введіть електронну пошту';
                  if (!text.contains('@')) return 'Некоректна електронна пошта';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              AppTextField(
                label: 'Пароль',
                controller: _passwordController,
                hint: 'Щонайменше 8 символів',
                isPassword: true,
                prefixIcon: Icons.lock_outline,
                textInputAction: TextInputAction.next,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Введіть пароль';
                  if (v.length < 8) return 'Пароль має містити щонайменше 8 символів';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              AppTextField(
                label: 'Повторіть пароль',
                controller: _confirmController,
                hint: 'Введіть пароль ще раз',
                isPassword: true,
                prefixIcon: Icons.lock_outline,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _submit(),
                validator: (v) =>
                    v != _passwordController.text ? 'Паролі не збігаються' : null,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        AppButton(label: 'Зареєструватися', onPressed: _submit),
        const SizedBox(height: 16),
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text('Вже є обліковий запис?', style: muted),
            TextButton(
              onPressed: () =>
                  Navigator.of(context).pushReplacementNamed(AppRoutes.login),
              child: const Text('Увійти'),
            ),
          ],
        ),
      ],
    );
  }
}
