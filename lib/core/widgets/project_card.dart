import 'package:flutter/material.dart';

import '../../models/repair_project.dart';
import '../theme/app_theme.dart';
import '../utils/formatters.dart';
import 'app_card.dart';
import 'app_progress_bar.dart';
import 'icon_label.dart';

/// Картка проєкту ремонту для списку проєктів.
class ProjectCard extends StatelessWidget {
  const ProjectCard({
    super.key,
    required this.project,
    required this.spent,
    required this.progress,
    this.isActive = false,
    this.onTap,
  });

  final RepairProject project;
  final double spent;
  final double progress;
  final bool isActive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final muted = textTheme.bodySmall?.copyWith(color: AppColors.textSecondary);
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
                  project.name,
                  style: textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              if (isActive) ...[
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceAlt,
                    borderRadius: BorderRadius.circular(99),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: const Text('Поточний', style: TextStyle(fontSize: 12)),
                ),
              ],
            ],
          ),
          const SizedBox(height: 8),
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
          AppProgressBar(value: progress),
          const SizedBox(height: 8),
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            runSpacing: 4,
            children: [
              Text('Виконано: ${formatPercent(progress)}', style: muted),
              Text(
                'Витрачено ${formatMoney(spent)} з ${formatMoney(project.budget)}',
                style: muted,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
