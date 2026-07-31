import 'package:flutter/material.dart';
import 'package:moodle/widgets/nav_drawer.dart';
import 'package:moodle/constants.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  static const List<_DashboardStat> _stats = [
    _DashboardStat(
      label: 'Courses',
      value: '4',
      icon: Icons.school_outlined,
      color: moodlePurple,
    ),
    _DashboardStat(
      label: 'Due soon',
      value: '3',
      icon: Icons.event_note_outlined,
      color: Color(0xFFD97706),
    ),
    _DashboardStat(
      label: 'Messages',
      value: '7',
      icon: Icons.chat_bubble_outline,
      color: moodleBlue,
    ),
    _DashboardStat(
      label: 'Grades',
      value: '82%',
      icon: Icons.verified_outlined,
      color: Color(0xFF16845B),
    ),
  ];

  static const List<_CourseProgress> _courses = [
    _CourseProgress(
      code: 'COMP101',
      title: 'Programming Principles',
      progress: 0.78,
      nextItem: 'Workshop 7 quiz',
      color: moodleBlue,
    ),
    _CourseProgress(
      code: 'WEB204',
      title: 'Web Development',
      progress: 0.64,
      nextItem: 'Responsive layout task',
      color: Color(0xFF16845B),
    ),
    _CourseProgress(
      code: 'DBS112',
      title: 'Database Systems',
      progress: 0.52,
      nextItem: 'ERD submission',
      color: Color(0xFFD97706),
    ),
  ];

  static const List<_Deadline> _deadlines = [
    _Deadline(
      day: 'Today',
      time: '16:00',
      title: 'Dashboard wireframe review',
      course: 'Web Development',
    ),
    _Deadline(
      day: 'Fri',
      time: '11:30',
      title: 'Programming quiz',
      course: 'Programming Principles',
    ),
    _Deadline(
      day: 'Mon',
      time: '09:00',
      title: 'Database normalisation worksheet',
      course: 'Database Systems',
    ),
  ];

  static const List<_Activity> _activities = [
    _Activity(
      icon: Icons.assignment_turned_in_outlined,
      title: 'Coursework draft submitted',
      meta: 'Web Development - 22 mins ago',
      color: Color(0xFF16845B),
    ),
    _Activity(
      icon: Icons.forum_outlined,
      title: 'Tutor replied to your forum post',
      meta: 'Programming Principles - 1 hour ago',
      color: moodleBlue,
    ),
    _Activity(
      icon: Icons.grade_outlined,
      title: 'New grade released',
      meta: 'Database Systems - Yesterday',
      color: Color(0xFFD97706),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: moodleWhite,
        foregroundColor: moodleTextDark,
        elevation: 1,
        titleSpacing: 0,
        title: Row(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              width: 32,
              height: 32,
              child: Image.asset(
                'images/moodle_logo.png',
                fit: BoxFit.contain,
              ),
            ),
            const Flexible(
              child: Text(
                'Dashboard',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ],
        ),
        actions: _buildAppBarActions(context),
      ),
      drawer: const NavDrawer(),
      body: Container(
        color: moodleBg,
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final bool isWide = constraints.maxWidth >= 720;
              return SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  isWide ? 32 : 16,
                  16,
                  isWide ? 32 : 16,
                  28,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 980),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Dashboard',
                          style: TextStyle(
                            color: moodlePurple,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 14),
                        const _WelcomePanel(),
                        const SizedBox(height: 18),
                        _StatsGrid(stats: _stats, isWide: isWide),
                        const SizedBox(height: 22),
                        const _SectionTitle(
                          title: 'Course progress',
                          actionLabel: 'View all',
                        ),
                        const SizedBox(height: 10),
                        const _CourseProgressList(courses: _courses),
                        const SizedBox(height: 22),
                        _DashboardSplit(
                          isWide: isWide,
                          left: const _DeadlineList(deadlines: _deadlines),
                          right: const _ActivityList(activities: _activities),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  List<Widget> _buildAppBarActions(BuildContext context) {
    final bool compact = MediaQuery.of(context).size.width < 390;
    return [
      IconButton(
        tooltip: 'Search',
        icon: const Icon(Icons.search_outlined),
        onPressed: () {},
      ),
      IconButton(
        tooltip: 'Notifications',
        icon: const Icon(Icons.notifications_none_outlined),
        onPressed: () {},
      ),
      if (!compact)
        IconButton(
          tooltip: 'Messages',
          icon: const Icon(Icons.chat_bubble_outline),
          onPressed: () {},
        ),
      const Padding(
        padding: EdgeInsets.only(left: 4, right: 12),
        child: CircleAvatar(
          radius: 18,
          backgroundColor: moodleGrayBg,
          foregroundColor: moodlePurple,
          child: Text(
            'OM',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
        ),
      ),
    ];
  }
}

class _WelcomePanel extends StatelessWidget {
  const _WelcomePanel();

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: moodlePurple.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.dashboard_outlined, color: moodlePurple),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back, Oluwaferanmi',
                    style: TextStyle(
                      color: moodleTextDark,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'You have 3 upcoming deadlines and 2 new course updates.',
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
      ),
    );
  }
}

class _StatsGrid extends StatelessWidget {
  const _StatsGrid({
    required this.stats,
    required this.isWide,
  });

  final List<_DashboardStat> stats;
  final bool isWide;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: stats.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isWide ? 4 : 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        mainAxisExtent: 124,
      ),
      itemBuilder: (context, index) {
        return _StatCard(stat: stats[index]);
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.stat});

  final _DashboardStat stat;

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(stat.icon, color: stat.color, size: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stat.value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: moodleTextDark,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  stat.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: moodleTextMuted, fontSize: 13),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.title,
    this.actionLabel,
  });

  final String title;
  final String? actionLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: moodlePurple,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (actionLabel != null)
          TextButton(
            onPressed: () {},
            child: Text(actionLabel!),
          ),
      ],
    );
  }
}

class _CourseProgressList extends StatelessWidget {
  const _CourseProgressList({required this.courses});

  final List<_CourseProgress> courses;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < courses.length; i++) ...[
          _CourseProgressCard(course: courses[i]),
          if (i != courses.length - 1) const SizedBox(height: 10),
        ],
      ],
    );
  }
}

class _CourseProgressCard extends StatelessWidget {
  const _CourseProgressCard({required this.course});

  final _CourseProgress course;

  @override
  Widget build(BuildContext context) {
    final int percentage = (course.progress * 100).round();
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
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: course.color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    course.code.substring(0, 3),
                    style: TextStyle(
                      color: course.color,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course.title,
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
                        course.nextItem,
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
                Text(
                  '$percentage%',
                  style: TextStyle(
                    color: course.color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                value: course.progress,
                minHeight: 8,
                color: course.color,
                backgroundColor: moodleGrayBg,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardSplit extends StatelessWidget {
  const _DashboardSplit({
    required this.isWide,
    required this.left,
    required this.right,
  });

  final bool isWide;
  final Widget left;
  final Widget right;

  @override
  Widget build(BuildContext context) {
    if (!isWide) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          left,
          const SizedBox(height: 22),
          right,
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: left),
        const SizedBox(width: 18),
        Expanded(child: right),
      ],
    );
  }
}

class _DeadlineList extends StatelessWidget {
  const _DeadlineList({required this.deadlines});

  final List<_Deadline> deadlines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _SectionTitle(title: 'Upcoming deadlines'),
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
              for (int i = 0; i < deadlines.length; i++) ...[
                _DeadlineRow(deadline: deadlines[i]),
                if (i != deadlines.length - 1)
                  const Divider(height: 1, color: moodleBorder),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _DeadlineRow extends StatelessWidget {
  const _DeadlineRow({required this.deadline});

  final _Deadline deadline;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 58,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: moodleGrayBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Text(
                  deadline.day,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: moodlePurple,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  deadline.time,
                  style: const TextStyle(color: moodleTextMuted, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  deadline.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: moodleTextDark,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  deadline.course,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: moodleTextMuted, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivityList extends StatelessWidget {
  const _ActivityList({required this.activities});

  final List<_Activity> activities;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _SectionTitle(title: 'Recent activity'),
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
              for (int i = 0; i < activities.length; i++) ...[
                _ActivityRow(activity: activities[i]),
                if (i != activities.length - 1)
                  const Divider(height: 1, color: moodleBorder),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _ActivityRow extends StatelessWidget {
  const _ActivityRow({required this.activity});

  final _Activity activity;

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
              color: activity.color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(activity.icon, color: activity.color, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: moodleTextDark,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  activity.meta,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: moodleTextMuted, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DashboardStat {
  const _DashboardStat({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;
}

class _CourseProgress {
  const _CourseProgress({
    required this.code,
    required this.title,
    required this.progress,
    required this.nextItem,
    required this.color,
  });

  final String code;
  final String title;
  final double progress;
  final String nextItem;
  final Color color;
}

class _Deadline {
  const _Deadline({
    required this.day,
    required this.time,
    required this.title,
    required this.course,
  });

  final String day;
  final String time;
  final String title;
  final String course;
}

class _Activity {
  const _Activity({
    required this.icon,
    required this.title,
    required this.meta,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String meta;
  final Color color;
}
