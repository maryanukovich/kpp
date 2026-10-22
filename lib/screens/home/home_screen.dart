import 'package:flutter/material.dart';

import '../../core/layout/app_shell.dart';
import '../../core/navigation/app_routes.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/formatters.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/app_progress_bar.dart';
import '../../core/widgets/demo_message.dart';
import '../../core/widgets/icon_label.dart';
import '../../core/widgets/quick_link_tile.dart';
import '../../core/widgets/repair_task_card.dart';
import '../../core/widgets/responsive_grid.dart';
import '../../core/widgets/section_header.dart';
import '../../core/widgets/stat_card.dart';
import '../../core/widgets/status_chip.dart';
import '../../data/demo_data.dart';
import '../../models/repair_task.dart';
import '../projects/project_details_screen.dart';

/// Головна сторінка: поточний проєкт, бюджет, прогрес, найближчі завдання
/// та швидкі переходи. Використовує локальні демонстраційні дані.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final project = DemoData.activeProject;
    final spent = DemoData.spentOn(project.id);
    final remaining = project.budget - spent;
    final progress = DemoData.progressOf(project.id);
    final tasks = DemoData.tasksOf(project.id);
    int count(TaskStatus s) => tasks.where((t) => t.status == s).length;
    final upcoming = DemoData.upcomingTasks(project.id);
    final textTheme = Theme.of(context).textTheme;

    void go(String route) => AppNavigator.goSection(context, route);

    final progressCard = AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Прогрес виконання робіт',
            style:
                textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          Text(
            formatPercent(progress),
            style:
                textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          Text(
            'Виконано ${count(TaskStatus.done)} з ${tasks.length} робіт',
            style: textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 12),
          AppProgressBar(value: progress),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final status in TaskStatus.values)
                StatusChip(
                  status: status,
                  label: '${status.label}: ${count(status)}',
                ),
            ],
          ),
        ],
      ),
    );

    final upcomingColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(
          title: 'Найближчі завдання',
          actionLabel: 'Усі роботи',
          onAction: () => go(AppRoutes.tasks),
        ),
        const SizedBox(height: 8),
        if (upcoming.isEmpty)
          const AppCard(child: Text('Усі роботи виконано.'))
        else
          for (final task in upcoming) ...[
            RepairTaskCard(
              task: task,
              roomName: DemoData.roomById(task.roomId)?.name ?? '—',
              onTap: () => go(AppRoutes.tasks),
            ),
            const SizedBox(height: 12),
          ],
      ],
    );

    return AppShell(
      selected: NavItem.home,
      title: 'Вітаю, ${DemoData.user.name}!',
      subtitle: 'Огляд вашого поточного ремонту',
      children: [
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.home_work_outlined),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Поточний проєкт',
                          style: textTheme.bodySmall
                              ?.copyWith(color: AppColors.textSecondary),
                        ),
                        Text(
                          project.name,
                          style: textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 16,
                runSpacing: 6,
                children: [
                  IconLabel(icon: Icons.place_outlined, text: project.address),
                  IconLabel(
                    icon: Icons.event_outlined,
                    text:
                        '${formatDate(project.startDate)} – ${formatDate(project.endDate)}',
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  AppButton(
                    label: 'Відкрити проєкт',
                    icon: Icons.open_in_new,
                    variant: AppButtonVariant.outlined,
                    expanded: false,
                    onPressed: () =>
                        ProjectDetailsScreen.open(context, project),
                  ),
                  AppButton(
                    label: 'Додати завдання',
                    icon: Icons.add,
                    expanded: false,
                    onPressed: () => showDemoMessage(
                      context,
                      'Демонстраційна дія: додавання завдань буде реалізовано пізніше.',
                    ),
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
              label: 'Запланований бюджет',
              value: formatMoney(project.budget),
              icon: Icons.account_balance_wallet_outlined,
            ),
            StatCard(
              label: 'Витрачено',
              value: formatMoney(spent),
              icon: Icons.receipt_long_outlined,
            ),
            StatCard(
              label: 'Залишок',
              value: formatMoney(remaining),
              icon: Icons.savings_outlined,
              valueColor: remaining < 0 ? AppColors.danger : AppColors.success,
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SectionHeader(title: 'Швидкий доступ'),
            const SizedBox(height: 8),
            ResponsiveGrid(
              minItemWidth: 150,
              maxColumns: 6,
              spacing: 12,
              children: [
                QuickLinkTile(
                  icon: Icons.folder_copy_outlined,
                  label: 'Проєкти',
                  onTap: () => go(AppRoutes.projects),
                ),
                QuickLinkTile(
                  icon: Icons.meeting_room_outlined,
                  label: 'Приміщення',
                  onTap: () => go(AppRoutes.rooms),
                ),
                QuickLinkTile(
                  icon: Icons.construction_outlined,
                  label: 'Ремонтні роботи',
                  onTap: () => go(AppRoutes.tasks),
                ),
                QuickLinkTile(
                  icon: Icons.receipt_long_outlined,
                  label: 'Витрати',
                  onTap: () => go(AppRoutes.expenses),
                ),
                QuickLinkTile(
                  icon: Icons.account_balance_wallet_outlined,
                  label: 'Бюджет',
                  onTap: () => go(AppRoutes.budget),
                ),
                QuickLinkTile(
                  icon: Icons.person_outline,
                  label: 'Профіль',
                  onTap: () => go(AppRoutes.profile),
                ),
              ],
            ),
          ],
        ),
        ResponsiveGrid(
          minItemWidth: 420,
          maxColumns: 2,
          children: [progressCard, upcomingColumn],
        ),
      ],
    );
  }
}
