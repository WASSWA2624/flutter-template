import 'package:flutter/material.dart';
import 'package:flutter_template/app/theme/app_theme_extensions.dart';
import 'package:flutter_template/shared/components/components.dart';
import 'package:flutter_template/shared/layout/app_breakpoints.dart';

final class ResponsiveShellDestination {
  const ResponsiveShellDestination({
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });

  final String label;
  final IconData icon;
  final IconData selectedIcon;
}

class ResponsiveShellScaffold extends StatelessWidget {
  const ResponsiveShellScaffold({
    required this.title,
    required this.destinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.child,
    super.key,
  });

  final String title;
  final List<ResponsiveShellDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final AppBreakpoint breakpoint = AppBreakpoints.fromConstraints(
          constraints,
        );
        final bool canNavigate = destinations.length > 1;
        final int effectiveSelectedIndex = destinations.isEmpty
            ? 0
            : selectedIndex.clamp(0, destinations.length - 1);

        if (breakpoint.isMobile) {
          return Scaffold(
            appBar: AppBar(title: _ShellTitle(title: title)),
            drawer: canNavigate
                ? _MobileShellDrawer(
                    title: title,
                    destinations: destinations,
                    selectedIndex: effectiveSelectedIndex,
                    onDestinationSelected: onDestinationSelected,
                  )
                : null,
            body: child,
          );
        }

        if (!breakpoint.supportsExtendedNavigationRail) {
          return Scaffold(
            body: Row(
              children: <Widget>[
                _CompactShellRail(
                  destinations: destinations,
                  selectedIndex: effectiveSelectedIndex,
                  onDestinationSelected: onDestinationSelected,
                ),
                const VerticalDivider(width: _dividerWidth),
                Expanded(child: child),
              ],
            ),
          );
        }

        return Scaffold(
          body: Row(
            children: <Widget>[
              _DesktopShellSidebar(
                title: title,
                destinations: destinations,
                selectedIndex: effectiveSelectedIndex,
                onDestinationSelected: onDestinationSelected,
              ),
              const VerticalDivider(width: _dividerWidth),
              Expanded(child: child),
            ],
          ),
        );
      },
    );
  }
}

class _ShellTitle extends StatelessWidget {
  const _ShellTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const AppLogo(size: _appBarLogoSize),
        SizedBox(width: Theme.of(context).spacing.sm),
        Expanded(child: Text(title, overflow: TextOverflow.ellipsis)),
      ],
    );
  }
}

class _MobileShellDrawer extends StatelessWidget {
  const _MobileShellDrawer({
    required this.title,
    required this.destinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  final String title;
  final List<ResponsiveShellDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(theme.spacing.lg),
              child: _ShellTitle(title: title),
            ),
            const Divider(height: _dividerWidth),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: theme.spacing.sm),
                itemCount: destinations.length,
                itemBuilder: (BuildContext context, int index) {
                  return _ShellMenuItem(
                    destination: destinations[index],
                    selected: index == selectedIndex,
                    onTap: () {
                      Navigator.of(context).pop();
                      if (index != selectedIndex) {
                        onDestinationSelected(index);
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CompactShellRail extends StatelessWidget {
  const _CompactShellRail({
    required this.destinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  final List<ResponsiveShellDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return NavigationRail(
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      labelType: NavigationRailLabelType.all,
      leading: Padding(
        padding: EdgeInsets.only(bottom: theme.spacing.lg),
        child: const AppLogo(size: _railLogoSize),
      ),
      destinations: <NavigationRailDestination>[
        for (final ResponsiveShellDestination destination in destinations)
          NavigationRailDestination(
            icon: Icon(destination.icon),
            selectedIcon: Icon(destination.selectedIcon),
            label: Text(destination.label),
          ),
      ],
    );
  }
}

class _DesktopShellSidebar extends StatelessWidget {
  const _DesktopShellSidebar({
    required this.title,
    required this.destinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  final String title;
  final List<ResponsiveShellDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return ColoredBox(
      color: colorScheme.surface,
      child: SizedBox(
        width: _sidebarWidth,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(theme.spacing.lg),
                child: _ShellTitle(title: title),
              ),
              const Divider(height: _dividerWidth),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: theme.spacing.sm),
                  itemCount: destinations.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _ShellMenuItem(
                      destination: destinations[index],
                      selected: index == selectedIndex,
                      onTap: () {
                        if (index != selectedIndex) {
                          onDestinationSelected(index);
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ShellMenuItem extends StatelessWidget {
  const _ShellMenuItem({
    required this.destination,
    required this.selected,
    required this.onTap,
  });

  final ResponsiveShellDestination destination;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: theme.spacing.sm),
      child: ListTile(
        selected: selected,
        selectedTileColor: colorScheme.secondaryContainer,
        selectedColor: colorScheme.onSecondaryContainer,
        leading: Icon(selected ? destination.selectedIcon : destination.icon),
        title: Text(destination.label, overflow: TextOverflow.ellipsis),
        minLeadingWidth: theme.spacing.xl,
        contentPadding: EdgeInsets.symmetric(horizontal: theme.spacing.md),
        shape: const RoundedRectangleBorder(),
        onTap: onTap,
      ),
    );
  }
}

const double _appBarLogoSize = 32;
const double _railLogoSize = 36;
const double _sidebarWidth = 248;
const double _dividerWidth = 1;
