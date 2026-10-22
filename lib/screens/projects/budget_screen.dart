import 'package:flutter/material.dart';

import '../../core/layout/app_shell.dart';
import '../../core/navigation/app_routes.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/formatters.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/app_progress_bar.dart';
import '../../core/widgets/responsive_grid.dart';
import '../../core/widgets/stat_card.dart';
import '../../data/demo_data.dart';

/// Бюджет поточного проєкту: план, факт, залишок і витрати за категоріями.
class BudgetScreen extends StatelessWidget {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final project = DemoData.activeProject;
    final spent = DemoData.spentOn(project.id);
    final remaining = project.budget - spent;
    final ratio = project.budget == 0 ? 0.0 : spent / project.budget;
    final overspent = remaining < 0;
    final textTheme = Theme.of(context).textTheme;
    final muted = textTheme.bodySmall?.copyWith(color: AppColors.textSecondary);

    final byCategory = <String, double>{};
    for (final e in DemoData.expensesOf(project.id)) {
      byCategory[e.category] = (byCategory[e.category] ?? 0) + e.amount;
    }
    final categories = byCategory.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    final Color barColor = overspent
        ? AppColors.danger
        : (ratio > 0.8 ? AppColors.warning : AppColors.accent);

    return AppShell(
      selected: NavItem.budget,
      title: 'Бюджет',
      subtitle: project.name,
      children: [
        ResponsiveGrid(
          minItemWidth: 240,
          maxColumns: 3,
          children: [
            StatCard(
              label: 'Запланований бюджет',
              value: formatMoney(project.budget),
              icon: Icons.account_balance_wallet_outlined,
            ),
            StatCard(
              label: 'Фактичні витрати',
              value: formatMoney(spent),
              icon: Icons.receipt_long_outlined,
            ),
            StatCard(
              label: 'Залишок',
              value: formatMoney(remaining),
              icon: Icons.savings_outlined,
              valueColor: overspent ? AppColors.danger : AppColors.success,
            ),
          ],
        ),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Використано бюджету',
                style:
                    textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              AppProgressBar(value: ratio, color: barColor),
              const SizedBox(height: 8),
              Text(
                '${formatMoney(spent)} з ${formatMoney(project.budget)} (${formatPercent(ratio)})',
                style: muted,
              ),
              if (overspent) ...[
                const SizedBox(height: 8),
                Text(
                  'Бюджет перевищено на ${formatMoney(-remaining)}',
                  style: textTheme.bodySmall?.copyWith(color: AppColors.danger),
                ),
              ],
            ],
          ),
        ),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Витрати за категоріями',
                style:
                    textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              if (categories.isEmpty) Text('Витрат ще немає.', style: muted),
              for (final entry in categories) ...[
                Row(
                  children: [
                    Expanded(child: Text(entry.key)),
                    Text(
                      formatMoney(entry.value),
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                AppProgressBar(
                  value: spent == 0 ? 0 : entry.value / spent,
                  color: AppColors.info,
                ),
                const SizedBox(height: 14),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
