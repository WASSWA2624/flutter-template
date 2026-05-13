import 'package:flutter/material.dart';
import 'package:flutter_template/shared/components/components.dart';
import 'package:flutter_test/flutter_test.dart';

import 'component_test_app.dart';

void main() {
  testWidgets('AppStateView renders loading content with progress semantics', (
    WidgetTester tester,
  ) async {
    await pumpComponent(
      tester,
      const AppStateView(
        variant: AppStateViewVariant.loading,
        title: 'Loading',
        body: 'Preparing content.',
      ),
    );

    expect(find.text('Loading'), findsOneWidget);
    expect(find.text('Preparing content.'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('AppStateScaffold renders app bar and action content', (
    WidgetTester tester,
  ) async {
    await pumpComponent(
      tester,
      AppStateScaffold(
        appBarTitle: 'Template',
        variant: AppStateViewVariant.error,
        title: 'Could not load',
        body: 'Try the request again.',
        action: AppButton.primary(label: 'Retry', onPressed: () {}),
      ),
    );

    expect(find.text('Template'), findsOneWidget);
    expect(find.text('Could not load'), findsOneWidget);
    expect(find.text('Try the request again.'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);
    expect(find.byIcon(Icons.error_outline), findsOneWidget);
  });
}
