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

/// Матеріали поточного проєкту.
class MaterialsScreen extends StatelessWidget {
  const MaterialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final project = DemoData.activeProject;
    final items = DemoData.materialsOf(project.id);
    final total = items.fold(0.0, (sum, m) => sum + m.total);

    return AppShell(
      selected: NavItem.materials,
      title: 'Матеріали',
      subtitle: project.name,
      actions: [
        AppButton(
          label: 'Додати матеріал',
          icon: Icons.add,
          expanded: false,
          onPressed: () => showDemoMessage(
            context,
            'Демонстраційна дія: додавання матеріалів буде реалізовано пізніше.',
          ),
        ),
      ],
      children: [
        StatCard(
          label: 'Загальна вартість матеріалів',
          value: formatMoney(total),
          icon: Icons.inventory_2_outlined,
          caption: 'Позицій: ${items.length}',
        ),
        if (items.isEmpty)
          const AppCard(child: Text('Матеріалів ще немає.'))
        else
          AppCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                for (var i = 0; i < items.length; i++) ...[
                  if (i > 0) const Divider(),
                  ListEntryTile(
                    title: items[i].name,
                    meta: [
                      '${formatQuantity(items[i].quantity)} ${items[i].unit}',
                      'Ціна: ${formatMoney(items[i].price)}',
                    ],
                    trailing: formatMoney(items[i].total),
                  ),
                ],
              ],
            ),
          ),
      ],
    );
  }
}
