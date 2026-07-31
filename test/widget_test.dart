import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:moodle/main.dart';

Future<void> _setMobileViewport(WidgetTester tester) async {
  tester.view.physicalSize = const Size(390, 844);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(() {
    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  });
}

Future<void> _setDesktopViewport(WidgetTester tester) async {
  tester.view.physicalSize = const Size(1200, 800);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(() {
    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  });
}

Future<void> _openDrawerItem(WidgetTester tester, String label) async {
  await tester.tap(find.byIcon(Icons.menu));
  await tester.pumpAndSettle();
  final item = find.widgetWithText(ListTile, label);
  if (item.evaluate().isEmpty) {
    await tester.scrollUntilVisible(
      item,
      100,
      scrollable: find.byType(Scrollable).last,
    );
  }
  await tester.tap(item);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('App renders dashboard and courses screen correctly',
      (WidgetTester tester) async {
    // Set desktop screen size
    await _setDesktopViewport(tester);

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
    await _setMobileViewport(tester);

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

  testWidgets('Top app bar log out opens static login page',
      (WidgetTester tester) async {
    await _setMobileViewport(tester);

    await tester.pumpWidget(const MoodleApp());
    await tester.tap(find.byTooltip('Account menu'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Log out'));
    await tester.pumpAndSettle();

    expect(find.text('Welcome to Moodle Cloud'), findsOneWidget);
    expect(find.text('OpenID Connect'), findsOneWidget);
    expect(find.text('Already have an account?'), findsOneWidget);
    expect(find.text('Username or email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Lost password?'), findsOneWidget);
    expect(find.text('Login page link'), findsNothing);
    expect(
        find.text('https://moodle.port.ac.uk/login/index.php'), findsNothing);
  });

  testWidgets('Side drawer profile menu opens basic information page',
      (WidgetTester tester) async {
    await _setMobileViewport(tester);

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
    await _setMobileViewport(tester);

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

  testWidgets('Assessments drawer item opens assessment details',
      (WidgetTester tester) async {
    await _setMobileViewport(tester);

    await tester.pumpWidget(const MoodleApp());
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(ListTile, 'Grades'));
    await tester.pumpAndSettle();

    expect(find.text('Assessment details'), findsOneWidget);
    expect(find.text('Workshop 7 Quiz'), findsOneWidget);
    expect(find.text('Responsive Layout Task'), findsOneWidget);
    expect(find.text('Friday, 7 August 2026'), findsOneWidget);
    expect(find.text('Not submitted'), findsOneWidget);
    expect(find.text('Due soon'), findsWidgets);
  });

  testWidgets('Calendar drawer item opens deadlines and tasks page',
      (WidgetTester tester) async {
    await _setMobileViewport(tester);

    await tester.pumpWidget(const MoodleApp());
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(ListTile, 'Calendar'));
    await tester.pumpAndSettle();

    expect(find.text('Upcoming deadlines'), findsOneWidget);
    expect(find.text('Past tasks'), findsOneWidget);
    expect(find.text('Responsive Layout Task'), findsOneWidget);
    expect(find.text('Workshop 7 Quiz'), findsOneWidget);
    expect(find.text('Database worksheet'), findsOneWidget);
    expect(
      find.text('https://moodle.port.ac.uk/calendar/view.php?view=month'),
      findsOneWidget,
    );
  });

  testWidgets('Drawer navigation routes every menu item',
      (WidgetTester tester) async {
    await _setDesktopViewport(tester);

    await tester.pumpWidget(const MoodleApp());

    await _openDrawerItem(tester, 'Site home');
    expect(
        find.text(
            'Landing page for Moodle site-wide links and notices.'),
        findsOneWidget);

    await _openDrawerItem(tester, 'Private files');
    expect(find.text('coursework-draft.pdf'), findsOneWidget);

    await _openDrawerItem(tester, 'Participants');
    expect(find.text('Dr Jiacheng Tan - Module tutor'), findsOneWidget);

    await _openDrawerItem(tester, 'Badges');
    expect(find.text('Quiz participation badge'), findsOneWidget);

    await _openDrawerItem(tester, 'Help and support');
    expect(find.text('Visit student IT support'), findsOneWidget);

    await _openDrawerItem(tester, 'Preferences');
    expect(find.text('Email digest: daily'), findsOneWidget);

    await _openDrawerItem(tester, 'Current course');
    expect(find.text('Module sections'), findsOneWidget);

    await _openDrawerItem(tester, 'Dashboard');
    expect(find.text('Welcome back, Oluwaferanmi'), findsOneWidget);
  });

  testWidgets('App bar buttons and course cards navigate to pages',
      (WidgetTester tester) async {
    await _setDesktopViewport(tester);

    await tester.pumpWidget(const MoodleApp());

    await tester.tap(find.byTooltip('Search'));
    await tester.pumpAndSettle();
    expect(
        find.text(
            'Search page showing example results across Moodle content.'),
        findsOneWidget);

    await tester.tap(find.byTooltip('Notifications'));
    await tester.pumpAndSettle();
    expect(find.text('Notification page with example course alerts.'),
        findsOneWidget);

    await tester.tap(find.byTooltip('Messages'));
    await tester.pumpAndSettle();
    expect(find.text('Messages page with example Moodle conversations.'),
        findsOneWidget);

    await tester.tap(find.byTooltip('Account menu'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Preferences'));
    await tester.pumpAndSettle();
    expect(find.text('Editor preference: default'), findsOneWidget);

    await _openDrawerItem(tester, 'Dashboard');
    await tester.tap(find.text('View all'));
    await tester.pumpAndSettle();
    expect(find.text('User Experience Design'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('module-WEB204')));
    await tester.pumpAndSettle();
    expect(find.text('JavaScript workshop materials'), findsOneWidget);
  });

  testWidgets('Dashboard renders correctly on a mobile viewport',
      (WidgetTester tester) async {
    await _setMobileViewport(tester);

    await tester.pumpWidget(const MoodleApp());

    expect(find.text('Welcome back, Oluwaferanmi'), findsOneWidget);
    expect(find.text('Course progress'), findsOneWidget);
    expect(find.text('Upcoming deadlines'), findsOneWidget);
    expect(find.text('Recent activity'), findsOneWidget);
  });
}
