import 'package:flutter/material.dart';

import '../../core/layout/app_shell.dart';
import '../../core/navigation/app_routes.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/demo_message.dart';
import '../../core/widgets/repair_task_card.dart';
import '../../core/widgets/responsive_grid.dart';
import '../../data/demo_data.dart';
import '../../models/repair_task.dart';
import '../../models/room.dart';

/// Ремонтні роботи поточного проєкту (за потреби — лише для одного приміщення).
class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key, this.room});

  final Room? room;

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  TaskStatus? _filter;

  Widget _chip(String label, TaskStatus? status) {
    final selected = _filter == status;
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      showCheckmark: false,
      selectedColor: AppColors.accent,
      backgroundColor: AppColors.surface,
      side: const BorderSide(color: AppColors.border),
      labelStyle: TextStyle(
        color: selected ? AppColors.onAccent : AppColors.textPrimary,
        fontWeight: FontWeight.w600,
      ),
      onSelected: (_) => setState(() => _filter = status),
    );
  }

  @override
  Widget build(BuildContext context) {
    final project = DemoData.activeProject;
    final room = widget.room;
    final tasks = DemoData.tasksOf(project.id)
        .where((t) => room == null || t.roomId == room.id)
        .where((t) => _filter == null || t.status == _filter)
        .toList();

    return AppShell(
      selected: NavItem.tasks,
      title: 'Ремонтні роботи',
      subtitle: room == null ? project.name : 'Приміщення: ${room.name}',
      actions: [
        AppButton(
          label: 'Додати роботу',
          icon: Icons.add,
          expanded: false,
          onPressed: () => showDemoMessage(
            context,
            'Демонстраційна дія: додавання робіт буде реалізовано пізніше.',
          ),
        ),
      ],
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _chip('Усі', null),
            for (final status in TaskStatus.values) _chip(status.label, status),
          ],
        ),
        if (tasks.isEmpty)
          const AppCard(child: Text('За вибраними умовами робіт немає.'))
        else
          ResponsiveGrid(
            minItemWidth: 460,
            maxColumns: 2,
            children: [
              for (final task in tasks)
                RepairTaskCard(
                  task: task,
                  roomName: DemoData.roomById(task.roomId)?.name ?? '—',
                  onTap: () => showDemoMessage(
                    context,
                    'Демонстраційна дія: деталі роботи «${task.title}».',
                  ),
                ),
            ],
          ),
      ],
    );
  }
}
