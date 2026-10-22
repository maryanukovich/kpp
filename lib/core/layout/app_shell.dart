import 'package:flutter/material.dart';

import '../navigation/app_routes.dart';
import '../theme/app_theme.dart';

/// Адаптивний каркас внутрішніх екранів.
/// Ширина ≥ 900 px — постійна бічна панель; вужче — AppBar із висувним меню.
class AppShell extends StatelessWidget {
  const AppShell({
    super.key,
    required this.selected,
    required this.title,
    required this.children,
    this.subtitle,
    this.actions = const [],
  });

  static const double wideBreakpoint = 900;

  final NavItem selected;
  final String title;
  final String? subtitle;
  final List<Widget> actions;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= wideBreakpoint;
        final content = _ShellContent(
          isWide: isWide,
          title: title,
          subtitle: subtitle,
          actions: actions,
          children: children,
        );

        if (isWide) {
          return Scaffold(
            body: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(width: 260, child: SidebarMenu(selected: selected)),
                const VerticalDivider(width: 1),
                Expanded(child: content),
              ],
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'RenoManager',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          drawer: Drawer(child: SidebarMenu(selected: selected)),
          body: content,
        );
      },
    );
  }
}

class _ShellContent extends StatelessWidget {
  const _ShellContent({
    required this.isWide,
    required this.title,
    required this.subtitle,
    required this.actions,
    required this.children,
  });

  final bool isWide;
  final String title;
  final String? subtitle;
  final List<Widget> actions;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final canPop = Navigator.of(context).canPop();

    final backButton = IconButton(
      tooltip: 'Назад',
      icon: const Icon(Icons.arrow_back),
      onPressed: () => Navigator.of(context).maybePop(),
    );

    final titleBlock = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
        if (subtitle != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              subtitle!,
              style:
                  textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
            ),
          ),
      ],
    );

    final Widget header = isWide
        ? Row(
            children: [
              if (canPop) backButton,
              Expanded(child: titleBlock),
              if (actions.isNotEmpty) ...[
                const SizedBox(width: AppSpacing.md),
                Wrap(spacing: 8, runSpacing: 8, children: actions),
              ],
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (canPop) backButton,
                  Expanded(child: titleBlock),
                ],
              ),
              if (actions.isNotEmpty) ...[
                const SizedBox(height: 12),
                Wrap(spacing: 8, runSpacing: 8, children: actions),
              ],
            ],
          );

    return SingleChildScrollView(
      padding: EdgeInsets.all(isWide ? AppSpacing.xl : AppSpacing.md),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              header,
              const SizedBox(height: AppSpacing.lg),
              for (var i = 0; i < children.length; i++) ...[
                if (i > 0) const SizedBox(height: 20),
                children[i],
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Бічне меню (використовується і як Drawer на вузьких екранах).
class SidebarMenu extends StatelessWidget {
  const SidebarMenu({super.key, required this.selected});

  final NavItem selected;

  @override
  Widget build(BuildContext context) {
    final muted = Theme.of(context)
        .textTheme
        .labelSmall
        ?.copyWith(color: AppColors.textSecondary, letterSpacing: 1);

    Widget tile(NavItem item) => _NavTile(
          icon: item.icon,
          label: item.label,
          selected: item == selected,
          onTap: () => AppNavigator.goSection(context, item.route),
        );

    return Container(
      color: AppColors.sidebar,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
              child: Row(
                children: [
                  const Icon(Icons.handyman_outlined),
                  const SizedBox(width: 8),
                  Text(
                    'RenoManager',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: [
                  tile(NavItem.home),
                  tile(NavItem.projects),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 16, 12, 6),
                    child: Text('ПРОЄКТ', style: muted),
                  ),
                  tile(NavItem.rooms),
                  tile(NavItem.tasks),
                  tile(NavItem.expenses),
                  tile(NavItem.budget),
                  tile(NavItem.materials),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
              child: Column(
                children: [
                  tile(NavItem.profile),
                  _NavTile(
                    icon: Icons.logout,
                    label: 'Вийти',
                    selected: false,
                    onTap: () => AppNavigator.logout(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavTile extends StatelessWidget {
  const _NavTile({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.onAccent : AppColors.textPrimary;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Material(
        color: selected ? AppColors.accent : Colors.transparent,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
            child: Row(
              children: [
                Icon(icon, size: 20, color: color),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: color,
                      fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
