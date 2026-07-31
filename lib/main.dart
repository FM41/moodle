import 'package:flutter/material.dart';
import 'package:moodle/views/assessments_view.dart';
import 'package:moodle/views/calendar_view.dart';
import 'package:moodle/views/dashboard_view.dart';
import 'package:moodle/views/courses_view.dart';
import 'package:moodle/views/login_view.dart';
import 'package:moodle/views/profile_view.dart';
import 'package:moodle/views/programming_language_view.dart';
import 'package:moodle/views/static_info_view.dart';
import 'package:moodle/constants.dart';

void main() {
  runApp(const MoodleApp());
}

class MoodleApp extends StatelessWidget {
  const MoodleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moodle',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: moodlePurple,
          primary: moodlePurple,
          secondary: moodleSecondary,
          surface: moodleSurface,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const DashboardView(),
        '/calendar': (context) => const CalendarView(),
        '/courses': (context) => const CoursesView(),
        '/courses/programming-language': (context) =>
            const ProgrammingLanguageView(),
        '/courses/web-development': (context) => const StaticInfoView(
              title: 'Web Development',
              subtitle:
                  'Module page for web development resources and coursework.',
              icon: Icons.web_outlined,
              items: [
                'Responsive layout task',
                'HTML and CSS revision resources',
                'JavaScript workshop materials',
              ],
            ),
        '/courses/database-systems': (context) => const StaticInfoView(
              title: 'Database Systems',
              subtitle:
                  'Module page for database design, ERDs, and SQL practice.',
              icon: Icons.storage_outlined,
              items: [
                'ERD submission',
                'Normalisation worksheet',
                'SQL query practice',
              ],
            ),
        '/courses/user-experience-design': (context) => const StaticInfoView(
              title: 'User Experience Design',
              subtitle:
                  'Module page for UX research, prototyping, and reflection tasks.',
              icon: Icons.design_services_outlined,
              items: [
                'Prototype reflection',
                'Wireframe review',
                'Usability testing notes',
              ],
            ),
        '/assessments': (context) => const AssessmentsView(),
        '/login': (context) => const LoginView(),
        '/profile': (context) => const ProfileView(),
        '/site-home': (context) => const StaticInfoView(
              title: 'Site home',
              subtitle:
                  'Static landing page for Moodle site-wide links and notices.',
              icon: Icons.home_outlined,
              items: [
                'University Moodle announcements',
                'Student support shortcuts',
                'Library and study resources',
              ],
            ),
        '/private-files': (context) => const StaticInfoView(
              title: 'Private files',
              subtitle:
                  'Static file area showing placeholder personal Moodle files.',
              icon: Icons.folder_outlined,
              items: [
                'coursework-draft.pdf',
                'programming-notes.docx',
                'database-diagram.png',
              ],
            ),
        '/participants': (context) => const StaticInfoView(
              title: 'Participants',
              subtitle:
                  'Static participant list for the current Programming Language course.',
              icon: Icons.groups_outlined,
              items: [
                'Dr Jiacheng Tan - Module tutor',
                'Oluwaferanmi Muraino - Student',
                'Course group: COMP101 practical class',
              ],
            ),
        '/badges': (context) => const StaticInfoView(
              title: 'Badges',
              subtitle:
                  'Badges page showing example Moodle achievements.',
              icon: Icons.workspace_premium_outlined,
              items: [
                'First login badge',
                'Quiz participation badge',
                'Course progress badge',
              ],
            ),
        '/help': (context) => const StaticInfoView(
              title: 'Help and support',
              subtitle:
                  'Support page with common Moodle help destinations.',
              icon: Icons.help_outline,
              items: [
                'Contact your module tutor',
                'Visit student IT support',
                'Check Moodle guidance pages',
              ],
            ),
        '/preferences': (context) => const StaticInfoView(
              title: 'Preferences',
              subtitle:
                  'Preferences page for account and notification settings.',
              icon: Icons.tune_outlined,
              items: [
                'Email digest: daily',
                'Forum tracking: enabled',
                'Editor preference: default',
              ],
            ),
        '/search': (context) => const StaticInfoView(
              title: 'Search',
              subtitle:
                  'Search page showing example results across Moodle content.',
              icon: Icons.search_outlined,
              items: [
                'Programming Language - Workshop 7 quiz',
                'Web Development - Responsive layout task',
                'Database Systems - ERD submission',
              ],
            ),
        '/notifications': (context) => const StaticInfoView(
              title: 'Notifications',
              subtitle: 'Notification page with example course alerts.',
              icon: Icons.notifications_none_outlined,
              items: [
                'Responsive Layout Task is due today',
                'New grade released for Database Systems',
                'Tutor replied to your forum post',
              ],
            ),
        '/messages': (context) => const StaticInfoView(
              title: 'Messages',
              subtitle:
                  'Messages page with example Moodle conversations.',
              icon: Icons.chat_bubble_outline,
              items: [
                'Tutor: Please check the workshop feedback',
                'Course group: Practical room changed',
                'Support: Your request has been received',
              ],
            ),
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => const StaticInfoView(
          title: 'Page not found',
          subtitle: 'The requested Moodle page could not be found.',
          icon: Icons.error_outline,
          items: [
            'Open the drawer to choose an available page',
            'Return to Dashboard from the navigation menu',
          ],
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
