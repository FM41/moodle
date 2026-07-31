import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:moodle/main.dart';

void main() {
  testWidgets('App renders dashboard and courses screen correctly',
      (WidgetTester tester) async {
    // Set desktop screen size
    tester.view.physicalSize = const Size(1200, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    // Build our app and trigger a frame.
    await tester.pumpWidget(const MoodleApp());

    // Verify that Dashboard title exists.
    expect(find.text('Dashboard'), findsNWidgets(2));

    // Open drawer
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    expect(find.text('Site home'), findsOneWidget);
    expect(find.text('Private files'), findsOneWidget);
    expect(find.text('Participants'), findsOneWidget);
    expect(find.text('Badges'), findsOneWidget);

    // Navigate to My Courses in drawer
    await tester.tap(find.text('My courses'));
    await tester.pumpAndSettle();

    // Verify Courses page contains title
    expect(find.text('This is the courses overview page.'), findsOneWidget);
  });

  testWidgets('Top app bar account menu renders actions',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(const MoodleApp());
    await tester.tap(find.byTooltip('Account menu'));
    await tester.pumpAndSettle();

    expect(find.text('Profile'), findsOneWidget);
    expect(find.text('Preferences'), findsOneWidget);
    expect(find.text('Log out'), findsOneWidget);
  });

  testWidgets('Dashboard renders correctly on a mobile viewport',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(const MoodleApp());

    expect(find.text('Welcome back, Oluwaferanmi'), findsOneWidget);
    expect(find.text('Course progress'), findsOneWidget);
    expect(find.text('Upcoming deadlines'), findsOneWidget);
    expect(find.text('Recent activity'), findsOneWidget);
  });
}
