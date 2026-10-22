import 'package:flutter/material.dart';

import '../../models/repair_task.dart';
import '../theme/app_theme.dart';
import '../utils/formatters.dart';
import 'app_card.dart';
import 'icon_label.dart';
import 'status_chip.dart';

/// Картка ремонтної роботи: назва, статус, опис, приміщення, етап і строки.
class RepairTaskCard extends StatelessWidget {
  const RepairTaskCard({
    super.key,
    required this.task,
    required this.roomName,
    this.onTap,
  });

  final RepairTask task;
  final String roomName;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return AppCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  task.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.titleSmall
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(width: 8),
              StatusChip(status: task.status),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            task.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 16,
            runSpacing: 6,
            children: [
              IconLabel(icon: Icons.meeting_room_outlined, text: roomName),
              IconLabel(icon: Icons.layers_outlined, text: task.stage),
              IconLabel(
                icon: Icons.event_outlined,
                text:
                    '${formatDate(task.startDate)} – ${formatDate(task.endDate)}',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
