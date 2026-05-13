import 'package:flutter_template/app/app.dart';
import 'package:flutter_template/l10n/app_strings.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders the minimal template shell', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const TemplateApp());

    expect(find.text(AppStrings.appTitle), findsOneWidget);
    expect(find.text(AppStrings.readyTitle), findsOneWidget);

    for (final String platform in AppStrings.supportedPlatforms) {
      expect(find.text(platform), findsOneWidget);
    }
  });
}
