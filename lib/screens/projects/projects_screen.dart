import 'package:flutter/material.dart';

import '../../core/layout/app_shell.dart';
import '../../core/navigation/app_routes.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/demo_message.dart';
import '../../core/widgets/project_card.dart';
import '../../core/widgets/responsive_grid.dart';
import '../../data/demo_data.dart';
import 'project_details_screen.dart';

/// Список проєктів ремонту.
class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  @override
  Widget build(BuildContext context) {
    return AppShell(
      selected: NavItem.projects,
      title: 'Мої проєкти',
      subtitle: 'Оберіть проєкт ремонту, щоб переглянути деталі',
      actions: [
        AppButton(
          label: 'Створити проєкт',
          icon: Icons.add,
          expanded: false,
          onPressed: () => showDemoMessage(
            context,
            'Демонстраційна дія: створення проєкту буде реалізовано пізніше.',
          ),
        ),
      ],
      children: [
        ResponsiveGrid(
          minItemWidth: 420,
          maxColumns: 2,
          children: [
            for (final project in DemoData.projects)
              ProjectCard(
                project: project,
                spent: DemoData.spentOn(project.id),
                progress: DemoData.progressOf(project.id),
                isActive: project.id == DemoData.activeProject.id,
                onTap: () async {
                  await ProjectDetailsScreen.open(context, project);
                  if (mounted) setState(() {});
                },
              ),
          ],
        ),
      ],
    );
  }
}
