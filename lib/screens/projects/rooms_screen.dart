import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/layout/app_shell.dart';
import '../../core/navigation/app_routes.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/demo_message.dart';
import '../../core/widgets/icon_label.dart';
import '../../core/widgets/responsive_grid.dart';
import '../../data/demo_data.dart';
import '../../models/room.dart';
import 'tasks_screen.dart';

/// Список приміщень поточного проєкту.
class RoomsScreen extends StatelessWidget {
  const RoomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final project = DemoData.activeProject;
    final rooms = DemoData.roomsOf(project.id);

    return AppShell(
      selected: NavItem.rooms,
      title: 'Приміщення',
      subtitle: project.name,
      actions: [
        AppButton(
          label: 'Додати приміщення',
          icon: Icons.add,
          expanded: false,
          onPressed: () => showDemoMessage(
            context,
            'Демонстраційна дія: додавання приміщень буде реалізовано пізніше.',
          ),
        ),
      ],
      children: [
        if (rooms.isEmpty)
          const AppCard(child: Text('У цьому проєкті ще немає приміщень.'))
        else
          ResponsiveGrid(
            minItemWidth: 400,
            maxColumns: 2,
            children: [for (final room in rooms) _RoomCard(room: room)],
          ),
      ],
    );
  }
}

class _RoomCard extends StatelessWidget {
  const _RoomCard({required this.room});

  final Room room;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final muted = textTheme.bodySmall?.copyWith(color: AppColors.textSecondary);
    final shown = math.min(room.photoCount, 4);

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      room.name,
                      style: textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    Text(room.type, style: muted),
                  ],
                ),
              ),
              IconButton(
                tooltip: 'Редагувати',
                icon: const Icon(Icons.edit_outlined, size: 20),
                onPressed: () => showDemoMessage(
                  context,
                  'Демонстраційна дія: редагування приміщення «${room.name}».',
                ),
              ),
              IconButton(
                tooltip: 'Видалити',
                icon: const Icon(Icons.delete_outline, size: 20),
                onPressed: () => showDemoMessage(
                  context,
                  'Демонстраційна дія: приміщення «${room.name}» не видалено.',
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          IconLabel(
            icon: Icons.straighten_outlined,
            text: 'Площа: ${room.area.toStringAsFixed(0)} м²',
          ),
          const SizedBox(height: 8),
          Text(room.description, style: textTheme.bodySmall),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Фотографії',
                  style: textTheme.labelLarge
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              TextButton.icon(
                onPressed: () => showDemoMessage(
                  context,
                  'Демонстраційна дія: завантаження фото буде реалізовано пізніше.',
                ),
                icon: const Icon(Icons.add_photo_alternate_outlined, size: 18),
                label: const Text('Додати'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (shown == 0)
            Text('Фотографій ще немає', style: muted)
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (var i = 0; i < shown; i++) const _PhotoPlaceholder(),
              ],
            ),
          const SizedBox(height: 16),
          AppButton(
            label: 'Ремонтні роботи',
            icon: Icons.construction_outlined,
            variant: AppButtonVariant.outlined,
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => TasksScreen(room: room),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Локальна заглушка замість реальної фотографії.
class _PhotoPlaceholder extends StatelessWidget {
  const _PhotoPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        border: Border.all(color: AppColors.border),
      ),
      child: const Icon(Icons.image_outlined, color: AppColors.textSecondary),
    );
  }
}
