import 'package:flutter/material.dart';

import 'core/navigation/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'screens/auth/forgot_password_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/profile/change_password_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/projects/budget_screen.dart';
import 'screens/projects/expenses_screen.dart';
import 'screens/projects/materials_screen.dart';
import 'screens/projects/projects_screen.dart';
import 'screens/projects/rooms_screen.dart';
import 'screens/projects/tasks_screen.dart';

/// Кореневий віджет застосунку RenoManager.
class RenoManagerApp extends StatelessWidget {
  const RenoManagerApp({super.key, this.initialRoute = AppRoutes.login});

  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RenoManager',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      themeMode: ThemeMode.dark,
      initialRoute: initialRoute,
      routes: {
        AppRoutes.login: (_) => const LoginScreen(),
        AppRoutes.register: (_) => const RegisterScreen(),
        AppRoutes.forgotPassword: (_) => const ForgotPasswordScreen(),
        AppRoutes.home: (_) => const HomeScreen(),
        AppRoutes.profile: (_) => const ProfileScreen(),
        AppRoutes.changePassword: (_) => const ChangePasswordScreen(),
        AppRoutes.projects: (_) => const ProjectsScreen(),
        AppRoutes.rooms: (_) => const RoomsScreen(),
        AppRoutes.tasks: (_) => const TasksScreen(),
        AppRoutes.expenses: (_) => const ExpensesScreen(),
        AppRoutes.budget: (_) => const BudgetScreen(),
        AppRoutes.materials: (_) => const MaterialsScreen(),
      },
    );
  }
}
