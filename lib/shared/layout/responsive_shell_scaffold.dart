import 'package:flutter/material.dart';
import 'package:flutter_template/app/theme/app_theme_extensions.dart';
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
    final ThemeData theme = Theme.of(context);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final AppBreakpoint breakpoint = AppBreakpoints.fromConstraints(
          constraints,
        );
        final bool hasMultipleDestinations = destinations.length > 1;

        if (breakpoint.isMobile && hasMultipleDestinations) {
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

        if (breakpoint.isMobile) {
          return Scaffold(
            appBar: AppBar(title: Text(title)),
            body: child,
          );
        }

        final bool extendsNavigationRail =
            breakpoint.supportsExtendedNavigationRail;

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
              VerticalDivider(width: theme.appTokens.dividerThickness),
              Expanded(child: child),
            ],
          ),
        );
      },
    );
  }
}
