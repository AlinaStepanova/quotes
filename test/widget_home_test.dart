import 'package:quotes/main.dart';
import 'package:quotes/widgets/icon_with_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Initial screen with progress bar test',
      (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    var progress = find.byType(CircularProgressIndicator);
    expect(progress, findsOneWidget);

    var nextButton = find.byType(IconWithAction);
    expect(nextButton, findsNothing);

    var anyText = find.byType(Text);
    expect(anyText, findsNothing);
  });

  testWidgets('First quote loaded test', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    var progress = find.byType(CircularProgressIndicator);
    expect(progress, findsOneWidget);

    var buttons = find.byType(IconWithAction);
    expect(buttons, findsNothing);

    var anyText = find.byType(Text);
    expect(anyText, findsNothing);

    await tester.pump(new Duration(milliseconds: 1000));

    expect(progress, findsNothing);
    expect(buttons, findsNWidgets(2));
    expect(anyText, findsNWidgets(4));

    var quoteText = find.byKey(Key('quote'));
    expect(quoteText, findsOneWidget);
  });

  testWidgets('Load next quote button click test', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    var progress = find.byType(CircularProgressIndicator);
    expect(progress, findsOneWidget);

    var nextButton = find.byKey(Key('nextQuote'));
    expect(nextButton, findsNothing);

    var quoteText = find.byKey(Key('quote'));
    expect(quoteText, findsNothing);

    await tester.pump(new Duration(milliseconds: 1000));

    expect(nextButton, findsOneWidget);
    await tester.tap(nextButton);
    await tester.pump(new Duration(milliseconds: 1000));

    expect(nextButton, findsOneWidget);
    expect(progress, findsNothing);
    expect((quoteText.evaluate().single.widget as Text).data?.isNotEmpty, true);
  });
}
