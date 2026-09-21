import 'package:flutter_test/flutter_test.dart';

import 'package:worldnews/main.dart';

void main() {
  testWidgets('News app loads login screen', (WidgetTester tester) async {
    await tester.pumpWidget(const NewsApp());

    expect(find.text('Welcome back'), findsOneWidget);
    expect(find.text("Log in to catch up on today's top stories."), findsOneWidget);
  });
}
