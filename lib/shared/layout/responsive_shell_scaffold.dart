import 'package:flutter/material.dart';

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

  static const double mobileBreakpoint = 600;
  static const double desktopBreakpoint = 840;

  final String title;
  final List<ResponsiveShellDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final bool usesBottomNavigation =
            constraints.maxWidth < mobileBreakpoint;

        if (usesBottomNavigation) {
          return Scaffold(
            appBar: AppBar(title: Text(title)),
            body: child,
            bottomNavigationBar: NavigationBar(
              selectedIndex: selectedIndex,
              onDestinationSelected: onDestinationSelected,
              destinations: <NavigationDestination>[
                for (final ResponsiveShellDestination destination
                    in destinations)
                  NavigationDestination(
                    icon: Icon(destination.icon),
                    selectedIcon: Icon(destination.selectedIcon),
                    label: destination.label,
                  ),
              ],
            ),
          );
        }

        final bool extendsNavigationRail =
            constraints.maxWidth >= desktopBreakpoint;

        return Scaffold(
          appBar: AppBar(title: Text(title)),
          body: Row(
            children: <Widget>[
              NavigationRail(
                selectedIndex: selectedIndex,
                onDestinationSelected: onDestinationSelected,
                extended: extendsNavigationRail,
                labelType: extendsNavigationRail
                    ? null
                    : NavigationRailLabelType.all,
                destinations: <NavigationRailDestination>[
                  for (final ResponsiveShellDestination destination
                      in destinations)
                    NavigationRailDestination(
                      icon: Icon(destination.icon),
                      selectedIcon: Icon(destination.selectedIcon),
                      label: Text(destination.label),
                    ),
                ],
              ),
              const VerticalDivider(width: 1),
              Expanded(child: child),
            ],
          ),
        );
      },
    );
  }
}
