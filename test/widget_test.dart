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

    // Verify Courses page contains module cards.
    expect(find.text('Programming Language'), findsWidgets);
    expect(find.text('Web Development'), findsWidgets);
    expect(find.text('Database Systems'), findsWidgets);
    expect(find.text('User Experience Design'), findsOneWidget);
    expect(find.text('Upcoming course work'), findsOneWidget);
  });

  testWidgets('Top app bar account menu opens profile',
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

    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();

    expect(find.text('Student information'), findsOneWidget);
    expect(find.text('Oluwaferanmi Muraino'), findsWidgets);
    expect(find.text('UP2248415'), findsWidgets);
    expect(find.text('up2248415@myport.ac.uk'), findsWidgets);
  });

  testWidgets('Side drawer profile menu opens basic information page',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(const MoodleApp());
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();

    expect(find.text('Student information'), findsOneWidget);
    expect(find.text('Full name'), findsOneWidget);
    expect(find.text('Student number'), findsOneWidget);
    expect(find.text('Email address'), findsOneWidget);
  });

  testWidgets('Programming Language module opens course details',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(const MoodleApp());
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    await tester.tap(find.text('My courses'));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('module-COMP101')));
    await tester.pumpAndSettle();

    expect(find.text('Module sections'), findsOneWidget);
    expect(find.text('Announcements'), findsOneWidget);
    expect(find.text('Learning materials'), findsOneWidget);
    expect(find.text('Weekly practicals'), findsOneWidget);
    expect(find.text('Assessments'), findsOneWidget);
    expect(
      find.text('https://moodle.port.ac.uk/course/view.php?id=2299'),
      findsOneWidget,
    );
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
