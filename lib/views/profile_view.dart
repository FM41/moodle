import 'package:flutter/material.dart';
import 'package:moodle/constants.dart';
import 'package:moodle/widgets/nav_drawer.dart';
import 'package:moodle/widgets/top_app_bar.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  static const List<_ProfileDetail> _details = [
    _ProfileDetail(
      label: 'Full name',
      value: 'Oluwaferanmi Muraino',
      icon: Icons.person_outline,
    ),
    _ProfileDetail(
      label: 'Student number',
      value: 'UP2248415',
      icon: Icons.badge_outlined,
    ),
    _ProfileDetail(
      label: 'Email address',
      value: 'up2248415@myport.ac.uk',
      icon: Icons.mail_outline,
    ),
    _ProfileDetail(
      label: 'Role',
      value: 'Student',
      icon: Icons.school_outlined,
    ),
    _ProfileDetail(
      label: 'Institution',
      value: 'University of Portsmouth',
      icon: Icons.account_balance_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MoodleTopAppBar(title: 'Profile'),
      drawer: const NavDrawer(),
      body: Container(
        color: moodleBg,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Profile',
                      style: TextStyle(
                        color: moodlePurple,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 14),
                    const _ProfileSummaryCard(),
                    const SizedBox(height: 18),
                    const _SectionHeading(title: 'Student information'),
                    const SizedBox(height: 10),
                    Card(
                      color: moodleWhite,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: moodleBorder),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          for (int i = 0; i < _details.length; i++) ...[
                            _ProfileDetailRow(detail: _details[i]),
                            if (i != _details.length - 1)
                              const Divider(height: 1, color: moodleBorder),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    const _SectionHeading(title: 'Course access'),
                    const SizedBox(height: 10),
                    const _CourseAccessCard(),
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

class _ProfileSummaryCard extends StatelessWidget {
  const _ProfileSummaryCard();

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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 64,
              height: 64,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: moodlePurple.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'OM',
                style: TextStyle(
                  color: moodlePurple,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Oluwaferanmi Muraino',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: moodleTextDark,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'UP2248415',
                    style: TextStyle(
                      color: moodlePurple,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Student account',
                    style: TextStyle(color: moodleTextMuted, fontSize: 13),
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

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({required this.title});

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

class _ProfileDetailRow extends StatelessWidget {
  const _ProfileDetailRow({required this.detail});

  final _ProfileDetail detail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: moodleGrayBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(detail.icon, color: moodlePurple, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  detail.label,
                  style: const TextStyle(color: moodleTextMuted, fontSize: 13),
                ),
                const SizedBox(height: 3),
                Text(
                  detail.value,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: moodleTextDark,
                    fontSize: 15,
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

class _CourseAccessCard extends StatelessWidget {
  const _CourseAccessCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: moodleWhite,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: moodleBorder),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enrolled courses',
              style: TextStyle(
                color: moodleTextDark,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            _CourseChip(label: 'Programming Principles'),
            SizedBox(height: 8),
            _CourseChip(label: 'Web Development'),
            SizedBox(height: 8),
            _CourseChip(label: 'Database Systems'),
          ],
        ),
      ),
    );
  }
}

class _CourseChip extends StatelessWidget {
  const _CourseChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.check_circle_outline, color: Color(0xFF16845B)),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: moodleTextDark, fontSize: 14),
          ),
        ),
      ],
    );
  }
}

class _ProfileDetail {
  const _ProfileDetail({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;
}
