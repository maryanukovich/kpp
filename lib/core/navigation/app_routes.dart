import 'package:flutter/material.dart';

import '../../data/demo_data.dart';

/// Імена маршрутів застосунку.
class AppRoutes {
  AppRoutes._();

  static const login = '/login';
  static const register = '/register';
  static const forgotPassword = '/forgot-password';
  static const home = '/home';
  static const profile = '/profile';
  static const changePassword = '/change-password';
  static const projects = '/projects';
  static const rooms = '/rooms';
  static const tasks = '/tasks';
  static const expenses = '/expenses';
  static const budget = '/budget';
  static const materials = '/materials';
}

/// Пункти бічної навігації.
enum NavItem {
  home('Головна', Icons.dashboard_outlined, AppRoutes.home),
  projects('Мої проєкти', Icons.folder_open_outlined, AppRoutes.projects),
  rooms('Приміщення', Icons.meeting_room_outlined, AppRoutes.rooms),
  tasks('Ремонтні роботи', Icons.construction_outlined, AppRoutes.tasks),
  expenses('Витрати', Icons.receipt_long_outlined, AppRoutes.expenses),
  budget('Бюджет', Icons.account_balance_wallet_outlined, AppRoutes.budget),
  materials('Матеріали', Icons.inventory_2_outlined, AppRoutes.materials),
  profile('Профіль', Icons.person_outline, AppRoutes.profile);

  const NavItem(this.label, this.icon, this.route);

  final String label;
  final IconData icon;
  final String route;
}

/// Допоміжні методи навігації.
class AppNavigator {
  AppNavigator._();

  /// Перехід до розділу з очищенням стека (бічна навігація, швидкі посилання).
  static void goSection(BuildContext context, String route) {
    Navigator.of(context).pushNamedAndRemoveUntil(route, (_) => false);
  }

  /// Звичайний перехід зі збереженням можливості повернення.
  static void push(BuildContext context, String route) {
    Navigator.of(context).pushNamed(route);
  }

  /// Демонстраційний вихід: повертає на екран авторизації.
  static void logout(BuildContext context) {
    DemoData.activeProject = DemoData.projects.first;
    goSection(context, AppRoutes.login);
  }
}
