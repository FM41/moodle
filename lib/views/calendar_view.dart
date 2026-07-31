import 'package:flutter/material.dart';
import 'package:moodle/constants.dart';
import 'package:moodle/widgets/nav_drawer.dart';
import 'package:moodle/widgets/top_app_bar.dart';

class CalendarView extends StatelessWidget {
  const CalendarView({Key? key}) : super(key: key);

  static const String _moodleUrl =
      'https://moodle.port.ac.uk/calendar/view.php?view=month';

  static const List<_CalendarTask> _upcomingTasks = [
    _CalendarTask(
      day: '31',
      month: 'Jul',
      title: 'Responsive Layout Task',
      module: 'Web Development',
      time: '16:00',
      status: 'Due today',
      color: Color(0xFFB4236A),
      icon: Icons.web_outlined,
    ),
    _CalendarTask(
      day: '07',
      month: 'Aug',
      title: 'Workshop 7 Quiz',
      module: 'Programming Language',
      time: '11:30',
      status: 'Upcoming',
      color: Color(0xFFD97706),
      icon: Icons.quiz_outlined,
    ),
    _CalendarTask(
      day: '10',
      month: 'Aug',
      title: 'ERD Submission',
      module: 'Database Systems',
      time: '09:00',
      status: 'Upcoming',
      color: moodleBlue,
      icon: Icons.account_tree_outlined,
    ),
    _CalendarTask(
      day: '21',
      month: 'Aug',
      title: 'Prototype Reflection',
      module: 'User Experience Design',
      time: '15:00',
      status: 'Upcoming',
      color: Color(0xFF16845B),
      icon: Icons.design_services_outlined,
    ),
  ];

  static const List<_CalendarTask> _pastTasks = [
    _CalendarTask(
      day: '24',
      month: 'Jul',
      title: 'Database worksheet',
      module: 'Database Systems',
      time: '12:00',
      status: 'Completed',
      color: Color(0xFF16845B),
      icon: Icons.task_alt_outlined,
    ),
    _CalendarTask(
      day: '18',
      month: 'Jul',
      title: 'Programming lab notes',
      module: 'Programming Language',
      time: '17:00',
      status: 'Completed',
      color: moodlePurple,
      icon: Icons.code_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MoodleTopAppBar(title: 'Calendar'),
      drawer: const NavDrawer(),
      body: Container(
        color: moodleBg,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 900),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Calendar',
                      style: TextStyle(
                        color: moodlePurple,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Static month view showing upcoming and past Moodle deadlines.',
                      style: TextStyle(
                        color: moodleTextMuted,
                        fontSize: 14,
                        height: 1.35,
                      ),
                    ),
                    SizedBox(height: 18),
                    _MonthSummaryCard(moodleUrl: _moodleUrl),
                    SizedBox(height: 18),
                    _SectionTitle(title: 'Upcoming deadlines'),
                    SizedBox(height: 10),
                    _TaskList(tasks: _upcomingTasks),
                    SizedBox(height: 22),
                    _SectionTitle(title: 'Past tasks'),
                    SizedBox(height: 10),
                    _TaskList(tasks: _pastTasks),
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

class _MonthSummaryCard extends StatelessWidget {
  const _MonthSummaryCard({required this.moodleUrl});

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
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: moodlePurple.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.calendar_month_outlined,
                    color: moodlePurple,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'July 2026',
                        style: TextStyle(
                          color: moodleTextDark,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '4 upcoming deadlines and 2 completed tasks.',
                        style: TextStyle(
                          color: moodleTextMuted,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                Expanded(
                  child: _CalendarMetric(
                    label: 'Upcoming',
                    value: '4',
                    color: moodleBlue,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: _CalendarMetric(
                    label: 'Completed',
                    value: '2',
                    color: Color(0xFF16845B),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            const Text(
              'Moodle calendar link',
              style: TextStyle(
                color: moodleTextDark,
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

class _CalendarMetric extends StatelessWidget {
  const _CalendarMetric({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: const TextStyle(color: moodleTextMuted, fontSize: 12),
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

class _TaskList extends StatelessWidget {
  const _TaskList({required this.tasks});

  final List<_CalendarTask> tasks;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: moodleWhite,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: moodleBorder),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          for (int i = 0; i < tasks.length; i++) ...[
            _TaskRow(task: tasks[i]),
            if (i != tasks.length - 1)
              const Divider(height: 1, color: moodleBorder),
          ],
        ],
      ),
    );
  }
}

class _TaskRow extends StatelessWidget {
  const _TaskRow({required this.task});

  final _CalendarTask task;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 56,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: task.color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Text(
                  task.month,
                  style: TextStyle(
                    color: task.color,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  task.day,
                  style: TextStyle(
                    color: task.color,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(task.icon, color: task.color, size: 20),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        task.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: moodleTextDark,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  task.module,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: moodleTextMuted, fontSize: 13),
                ),
                const SizedBox(height: 5),
                Text(
                  '${task.time} - ${task.status}',
                  style: TextStyle(
                    color: task.color,
                    fontSize: 12,
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

class _CalendarTask {
  const _CalendarTask({
    required this.day,
    required this.month,
    required this.title,
    required this.module,
    required this.time,
    required this.status,
    required this.color,
    required this.icon,
  });

  final String day;
  final String month;
  final String title;
  final String module;
  final String time;
  final String status;
  final Color color;
  final IconData icon;
}
