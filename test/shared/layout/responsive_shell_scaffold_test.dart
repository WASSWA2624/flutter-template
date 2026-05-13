import 'package:flutter/material.dart';
import 'package:flutter_template/shared/layout/responsive_shell_scaffold.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpShellAtSize(
    WidgetTester tester,
    Size size, {
    List<ResponsiveShellDestination> destinations =
        const <ResponsiveShellDestination>[
          ResponsiveShellDestination(
            label: 'Home',
            icon: Icons.home_outlined,
            selectedIcon: Icons.home,
          ),
          ResponsiveShellDestination(
            label: 'Settings',
            icon: Icons.settings_outlined,
            selectedIcon: Icons.settings,
          ),
        ],
  }) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = size;
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      MaterialApp(
        home: ResponsiveShellScaffold(
          title: 'Template',
          destinations: destinations,
          selectedIndex: 0,
          onDestinationSelected: (_) {},
          child: const Text('Body'),
        ),
      ),
    );
  }

  group('ResponsiveShellScaffold', () {
    testWidgets('uses bottom navigation for mobile widths', (
      WidgetTester tester,
    ) async {
      await pumpShellAtSize(tester, const Size(320, 640));

      expect(find.byType(NavigationBar), findsOneWidget);
      expect(find.byType(NavigationRail), findsNothing);
      expect(tester.takeException(), isNull);
    });

    testWidgets('omits mobile navigation for a single destination', (
      WidgetTester tester,
    ) async {
      await pumpShellAtSize(
        tester,
        const Size(320, 640),
        destinations: const <ResponsiveShellDestination>[
          ResponsiveShellDestination(
            label: 'Home',
            icon: Icons.home_outlined,
            selectedIcon: Icons.home,
          ),
        ],
      );

      expect(find.byType(NavigationBar), findsNothing);
      expect(find.byType(NavigationRail), findsNothing);
      expect(find.text('Body'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('uses a compact navigation rail for tablet widths', (
      WidgetTester tester,
    ) async {
      await pumpShellAtSize(tester, const Size(600, 800));

      final NavigationRail rail = tester.widget<NavigationRail>(
        find.byType(NavigationRail),
      );

      expect(find.byType(NavigationBar), findsNothing);
      expect(rail.extended, isFalse);
      expect(rail.labelType, NavigationRailLabelType.all);
      expect(tester.takeException(), isNull);
    });

    testWidgets('extends the navigation rail for desktop widths', (
      WidgetTester tester,
    ) async {
      await pumpShellAtSize(tester, const Size(1200, 900));

      final NavigationRail rail = tester.widget<NavigationRail>(
        find.byType(NavigationRail),
      );

      expect(find.byType(NavigationBar), findsNothing);
      expect(rail.extended, isTrue);
      expect(rail.labelType, isNull);
      expect(tester.takeException(), isNull);
    });
  });
}
