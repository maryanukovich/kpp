import 'package:flutter/material.dart';

import '../../core/navigation/app_routes.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/auth_layout.dart';

/// Екран авторизації. Демонстраційний: перевірки даних і запиту до бекенду
/// немає — кнопка «Увійти» відкриває головну сторінку.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController(text: 'mariana@example.com');
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    Navigator.of(context).pushReplacementNamed(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    final muted = Theme.of(context)
        .textTheme
        .bodySmall
        ?.copyWith(color: AppColors.textSecondary);

    return AuthLayout(
      title: 'Вхід до системи',
      subtitle: 'Введіть електронну пошту та пароль',
      children: [
        AppTextField(
          label: 'Електронна пошта',
          controller: _emailController,
          hint: 'name@example.com',
          keyboardType: TextInputType.emailAddress,
          prefixIcon: Icons.mail_outline,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 16),
        AppTextField(
          label: 'Пароль',
          controller: _passwordController,
          hint: 'Введіть пароль',
          isPassword: true,
          prefixIcon: Icons.lock_outline,
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => _login(),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(AppRoutes.forgotPassword),
            child: const Text('Забули пароль?'),
          ),
        ),
        const SizedBox(height: 8),
        AppButton(label: 'Увійти', onPressed: _login),
        const SizedBox(height: 16),
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text('Немає облікового запису?', style: muted),
            TextButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(AppRoutes.register),
              child: const Text('Зареєструватися'),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'Демонстраційний вхід: дані не перевіряються, запит до сервера не надсилається.',
          textAlign: TextAlign.center,
          style: muted,
        ),
      ],
    );
  }
}
