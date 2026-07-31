import 'package:flutter/material.dart';
import 'package:moodle/constants.dart';
import 'package:moodle/widgets/nav_drawer.dart';
import 'package:moodle/widgets/top_app_bar.dart';

class ProgrammingLanguageView extends StatelessWidget {
  const ProgrammingLanguageView({Key? key}) : super(key: key);

  static const String _moodleUrl =
      'https://moodle.port.ac.uk/course/view.php?id=2299';

  static const List<_CourseSection> _sections = [
    _CourseSection(
      title: 'Announcements',
      subtitle: 'Latest module messages and tutor updates.',
      icon: Icons.campaign_outlined,
      items: [
        'Welcome to the Programming Language module',
        'Week 7 practical notes now available',
      ],
    ),
    _CourseSection(
      title: 'Learning materials',
      subtitle: 'Lecture slides, worksheets, and reading notes.',
      icon: Icons.menu_book_outlined,
      items: [
        'Variables, data types, and operators',
        'Control flow and functions',
        'Collections, classes, and error handling',
      ],
    ),
    _CourseSection(
      title: 'Weekly practicals',
      subtitle: 'Hands-on coding sessions and lab exercises.',
      icon: Icons.code_outlined,
      items: [
        'Practical 1: Program structure',
        'Practical 2: Decisions and loops',
        'Practical 3: Building reusable functions',
      ],
    ),
    _CourseSection(
      title: 'Assessments',
      subtitle: 'Coursework, quizzes, and submission checkpoints.',
      icon: Icons.assignment_outlined,
      items: [
        'Workshop 7 quiz',
        'Portfolio task checkpoint',
        'Final programming assignment',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MoodleTopAppBar(title: 'Programming Language'),
      drawer: const NavDrawer(),
      body: Container(
        color: moodleBg,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 860),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Programming Language',
                      style: TextStyle(
                        color: moodlePurple,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 14),
                    const _CourseHeaderCard(moodleUrl: _moodleUrl),
                    const SizedBox(height: 20),
                    const _SectionTitle(title: 'Module sections'),
                    const SizedBox(height: 10),
                    for (int i = 0; i < _sections.length; i++) ...[
                      _CourseSectionCard(section: _sections[i]),
                      if (i != _sections.length - 1) const SizedBox(height: 10),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CourseHeaderCard extends StatelessWidget {
  const _CourseHeaderCard({required this.moodleUrl});

  final String moodleUrl;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: moodleWhite,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: moodleBorder),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: moodleBlue.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.code_outlined,
                    color: moodleBlue,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'COMP101',
                        style: TextStyle(
                          color: moodleBlue,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Programming Language',
                        style: TextStyle(
                          color: moodleTextDark,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'A dummy Moodle-style module page with weekly sections, learning materials, and assessment information.',
                        style: TextStyle(
                          color: moodleTextMuted,
                          fontSize: 14,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(height: 1, color: moodleBorder),
            const SizedBox(height: 14),
            const Row(
              children: [
                Expanded(
                  child: _CourseInfoTile(
                    label: 'Tutor',
                    value: 'Dr A. Williams',
                    icon: Icons.person_outline,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: _CourseInfoTile(
                    label: 'Progress',
                    value: '78%',
                    icon: Icons.trending_up_outlined,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              'Moodle link',
              style: TextStyle(
                color: moodleTextDark.withValues(alpha: 0.75),
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            SelectableText(
              moodleUrl,
              style: const TextStyle(color: moodleBlue, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}

class _CourseInfoTile extends StatelessWidget {
  const _CourseInfoTile({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: moodleGrayBg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: moodlePurple, size: 21),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: moodleTextMuted, fontSize: 12),
                ),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: moodleTextDark,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: moodlePurple,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _CourseSectionCard extends StatelessWidget {
  const _CourseSectionCard({required this.section});

  final _CourseSection section;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: moodleWhite,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: moodleBorder),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: moodlePurple.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(section.icon, color: moodlePurple, size: 23),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        section.title,
                        style: const TextStyle(
                          color: moodleTextDark,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        section.subtitle,
                        style: const TextStyle(
                          color: moodleTextMuted,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            for (final item in section.items) _SectionItem(label: item),
          ],
        ),
      ),
    );
  }
}

class _SectionItem extends StatelessWidget {
  const _SectionItem({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.insert_drive_file_outlined,
            color: moodleTextMuted,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(color: moodleTextDark, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}

class _CourseSection {
  const _CourseSection({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.items,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final List<String> items;
}
