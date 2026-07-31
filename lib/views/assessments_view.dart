import 'package:flutter/material.dart';
import 'package:moodle/constants.dart';
import 'package:moodle/widgets/nav_drawer.dart';
import 'package:moodle/widgets/top_app_bar.dart';

class AssessmentsView extends StatelessWidget {
  const AssessmentsView({Key? key}) : super(key: key);

  static const List<_Assessment> _assessments = [
    _Assessment(
      title: 'Workshop 7 Quiz',
      module: 'Programming Language',
      dueDate: 'Tuesday, 4 August 2026',
      status: 'Due soon',
      weight: '10%',
      color: Color(0xFFD97706),
      icon: Icons.quiz_outlined,
    ),
    _Assessment(
      title: 'Responsive Layout Task',
      module: 'Web Development',
      dueDate: 'Today, 28 July 2026',
      status: 'Not submitted',
      weight: '20%',
      color: Color(0xFFB4236A),
      icon: Icons.web_outlined,
    ),
    _Assessment(
      title: 'ERD Submission',
      module: 'Database Systems',
      dueDate: 'Friday, 7 August 2026',
      status: 'In progress',
      weight: '25%',
      color: moodleBlue,
      icon: Icons.account_tree_outlined,
    ),
    _Assessment(
      title: 'Prototype Reflection',
      module: 'User Experience Design',
      dueDate: 'Friday, 14 August 2026',
      status: 'On track',
      weight: '15%',
      color: Color(0xFF16845B),
      icon: Icons.design_services_outlined,
    ),
    _Assessment(
      title: 'Final Programming Assignment',
      module: 'Programming Language',
      dueDate: 'Monday, 24 August 2026',
      status: 'Upcoming',
      weight: '45%',
      color: moodlePurple,
      icon: Icons.assignment_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MoodleTopAppBar(title: 'Assessments'),
      drawer: const NavDrawer(),
      body: Container(
        color: moodleBg,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 900),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Assessments',
                      style: TextStyle(
                        color: moodlePurple,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Static overview of upcoming coursework, dates, weights, and submission status.',
                      style: TextStyle(
                        color: moodleTextMuted,
                        fontSize: 14,
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 18),
                    const _AssessmentSummary(),
                    const SizedBox(height: 18),
                    const _SectionTitle(title: 'Assessment details'),
                    const SizedBox(height: 10),
                    for (int i = 0; i < _assessments.length; i++) ...[
                      _AssessmentCard(assessment: _assessments[i]),
                      if (i != _assessments.length - 1)
                        const SizedBox(height: 10),
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

class _AssessmentSummary extends StatelessWidget {
  const _AssessmentSummary();

  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        mainAxisExtent: 96,
      ),
      children: const [
        _SummaryCard(
          label: 'Total',
          value: '5',
          icon: Icons.assignment_outlined,
          color: moodlePurple,
        ),
        _SummaryCard(
          label: 'Due soon',
          value: '2',
          icon: Icons.schedule_outlined,
          color: Color(0xFFD97706),
        ),
        _SummaryCard(
          label: 'Submitted',
          value: '0',
          icon: Icons.task_alt_outlined,
          color: Color(0xFF16845B),
        ),
        _SummaryCard(
          label: 'Pending',
          value: '5',
          icon: Icons.pending_actions_outlined,
          color: moodleBlue,
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

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
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: const TextStyle(
                      color: moodleTextDark,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: moodleTextMuted,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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

class _AssessmentCard extends StatelessWidget {
  const _AssessmentCard({required this.assessment});

  final _Assessment assessment;

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
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: assessment.color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    assessment.icon,
                    color: assessment.color,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        assessment.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: moodleTextDark,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        assessment.module,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: moodleTextMuted,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                _StatusPill(
                  label: assessment.status,
                  color: assessment.color,
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: _DetailTile(
                    label: 'Due date',
                    value: assessment.dueDate,
                    icon: Icons.event_outlined,
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 96,
                  child: _DetailTile(
                    label: 'Weight',
                    value: assessment.weight,
                    icon: Icons.percent_outlined,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({
    required this.label,
    required this.color,
  });

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _DetailTile extends StatelessWidget {
  const _DetailTile({
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
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: moodleGrayBg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: moodlePurple, size: 20),
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
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: moodleTextDark,
                    fontSize: 13,
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

class _Assessment {
  const _Assessment({
    required this.title,
    required this.module,
    required this.dueDate,
    required this.status,
    required this.weight,
    required this.color,
    required this.icon,
  });

  final String title;
  final String module;
  final String dueDate;
  final String status;
  final String weight;
  final Color color;
  final IconData icon;
}
