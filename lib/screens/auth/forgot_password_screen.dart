import 'package:flutter/material.dart';

import '../../core/navigation/app_routes.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/auth_layout.dart';

/// Відновлення пароля. Демонстраційне: лист фактично не надсилається.
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _requested = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _requested = true);
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      title: 'Відновлення пароля',
      subtitle: 'Вкажіть електронну пошту облікового запису',
      children: [
        Form(
          key: _formKey,
          child: AppTextField(
            label: 'Електронна пошта',
            controller: _emailController,
            hint: 'name@example.com',
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icons.mail_outline,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _submit(),
            validator: (v) {
              final text = v?.trim() ?? '';
              if (text.isEmpty) return 'Введіть електронну пошту';
              if (!text.contains('@')) return 'Некоректна електронна пошта';
              return null;
            },
          ),
        ),
        const SizedBox(height: 24),
        AppButton(label: 'Надіслати інструкцію', onPressed: _submit),
        if (_requested) ...[
          const SizedBox(height: 16),
          AppCard(
            color: AppColors.surfaceAlt,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.info_outline, size: 20, color: AppColors.info),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Демонстраційний режим: інструкцію умовно надіслано на '
                    '${_emailController.text.trim()}. Фактично лист не надсилається.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ),
        ],
        const SizedBox(height: 8),
        TextButton.icon(
          onPressed: () =>
              Navigator.of(context).pushReplacementNamed(AppRoutes.login),
          icon: const Icon(Icons.arrow_back, size: 18),
          label: const Text('Повернутися до входу'),
        ),
      ],
    );
  }
}
