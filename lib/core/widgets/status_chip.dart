import 'package:flutter/material.dart';

import '../../models/repair_task.dart';
import '../theme/app_theme.dart';

Color taskStatusColor(TaskStatus status) => switch (status) {
      TaskStatus.planned => AppColors.info,
      TaskStatus.inProgress => AppColors.warning,
      TaskStatus.done => AppColors.success,
    };

/// Позначка статусу ремонтної роботи.
class StatusChip extends StatelessWidget {
  const StatusChip({super.key, required this.status, this.label});

  final TaskStatus status;

  /// Власний текст (наприклад, «Виконано: 2»); за замовчуванням — назва статусу.
  final String? label;

  @override
  Widget build(BuildContext context) {
    final color = taskStatusColor(status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withAlpha(36),
        borderRadius: BorderRadius.circular(99),
        border: Border.all(color: color.withAlpha(110)),
      ),
      child: Text(
        label ?? status.label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
