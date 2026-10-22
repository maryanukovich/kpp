import 'package:flutter/material.dart';

import '../../core/layout/app_shell.dart';
import '../../core/navigation/app_routes.dart';
import '../../core/utils/formatters.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/demo_message.dart';
import '../../core/widgets/list_entry_tile.dart';
import '../../core/widgets/stat_card.dart';
import '../../data/demo_data.dart';

/// Облік витрат поточного проєкту.
class ExpensesScreen extends StatelessWidget {
  const ExpensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final project = DemoData.activeProject;
    final expenses = DemoData.expensesOf(project.id);
    final total = DemoData.spentOn(project.id);

    return AppShell(
      selected: NavItem.expenses,
      title: 'Витрати',
      subtitle: project.name,
      actions: [
        AppButton(
          label: 'Додати витрату',
          icon: Icons.add,
          expanded: false,
          onPressed: () => showDemoMessage(
            context,
            'Демонстраційна дія: додавання витрат буде реалізовано пізніше.',
          ),
        ),
      ],
      children: [
        StatCard(
          label: 'Загальна сума витрат',
          value: formatMoney(total),
          icon: Icons.receipt_long_outlined,
          caption: 'Записів: ${expenses.length}',
        ),
        if (expenses.isEmpty)
          const AppCard(child: Text('Витрат ще немає.'))
        else
          AppCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                for (var i = 0; i < expenses.length; i++) ...[
                  if (i > 0) const Divider(),
                  ListEntryTile(
                    title: expenses[i].title,
                    subtitle: expenses[i].description,
                    meta: [
                      expenses[i].category,
                      formatDate(expenses[i].date),
                      if (DemoData.taskById(expenses[i].taskId) != null)
                        'Робота: ${DemoData.taskById(expenses[i].taskId)!.title}',
                    ],
                    trailing: formatMoney(expenses[i].amount),
                  ),
                ],
              ],
            ),
          ),
      ],
    );
  }
}
