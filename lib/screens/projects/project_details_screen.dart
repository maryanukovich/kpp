import 'package:flutter/material.dart';

import '../../core/layout/app_shell.dart';
import '../../core/navigation/app_routes.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/formatters.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/demo_message.dart';
import '../../core/widgets/icon_label.dart';
import '../../core/widgets/quick_link_tile.dart';
import '../../core/widgets/responsive_grid.dart';
import '../../core/widgets/section_header.dart';
import '../../core/widgets/stat_card.dart';
import '../../data/demo_data.dart';
import '../../models/repair_project.dart';
import '../../models/repair_task.dart';

/// Деталі проєкту з переходами до приміщень, робіт, витрат, бюджету і матеріалів.
class ProjectDetailsScreen extends StatelessWidget {
  const ProjectDetailsScreen({super.key, required this.project});

  final RepairProject project;

  /// Робить проєкт поточним і відкриває його деталі.
  static Future<void> open(BuildContext context, RepairProject project) {
    DemoData.activeProject = project;
    return Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ProjectDetailsScreen(project: project),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final spent = DemoData.spentOn(project.id);
    final tasks = DemoData.tasksOf(project.id);
    final done = tasks.where((t) => t.status == TaskStatus.done).length;
    final textTheme = Theme.of(context).textTheme;

    void openSection(String route) => AppNavigator.push(context, route);

    return AppShell(
      selected: NavItem.projects,
      title: project.name,
      subtitle: project.address,
      actions: [
        AppButton(
          label: 'Редагувати',
          icon: Icons.edit_outlined,
          variant: AppButtonVariant.outlined,
          expanded: false,
          onPressed: () => showDemoMessage(
            context,
            'Демонстраційна дія: редагування проєкту буде реалізовано пізніше.',
          ),
        ),
      ],
      children: [
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Опис проєкту',
                style:
                    textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Text(
                project.description,
                style: textTheme.bodyMedium
                    ?.copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 16,
                runSpacing: 6,
                children: [
                  IconLabel(
                    icon: Icons.event_outlined,
                    text:
                        '${formatDate(project.startDate)} – ${formatDate(project.endDate)}',
                  ),
                  IconLabel(
                    icon: Icons.meeting_room_outlined,
                    text: 'Приміщень: ${DemoData.roomsOf(project.id).length}',
                  ),
                ],
              ),
            ],
          ),
        ),
        ResponsiveGrid(
          minItemWidth: 240,
          maxColumns: 3,
          children: [
            StatCard(
              label: 'Загальний бюджет',
              value: formatMoney(project.budget),
              icon: Icons.account_balance_wallet_outlined,
            ),
            StatCard(
              label: 'Витрачено',
              value: formatMoney(spent),
              icon: Icons.receipt_long_outlined,
            ),
            StatCard(
              label: 'Прогрес робіт',
              value: formatPercent(DemoData.progressOf(project.id)),
              icon: Icons.task_alt_outlined,
              caption: 'Виконано $done з ${tasks.length}',
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SectionHeader(title: 'Розділи проєкту'),
            const SizedBox(height: 8),
            ResponsiveGrid(
              minItemWidth: 150,
              maxColumns: 5,
              spacing: 12,
              children: [
                QuickLinkTile(
                  icon: Icons.meeting_room_outlined,
                  label: 'Приміщення',
                  onTap: () => openSection(AppRoutes.rooms),
                ),
                QuickLinkTile(
                  icon: Icons.construction_outlined,
                  label: 'Ремонтні роботи',
                  onTap: () => openSection(AppRoutes.tasks),
                ),
                QuickLinkTile(
                  icon: Icons.receipt_long_outlined,
                  label: 'Витрати',
                  onTap: () => openSection(AppRoutes.expenses),
                ),
                QuickLinkTile(
                  icon: Icons.account_balance_wallet_outlined,
                  label: 'Бюджет',
                  onTap: () => openSection(AppRoutes.budget),
                ),
                QuickLinkTile(
                  icon: Icons.inventory_2_outlined,
                  label: 'Матеріали',
                  onTap: () => openSection(AppRoutes.materials),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
