import 'package:flutter/material.dart';
import 'package:moodle/constants.dart';
import 'package:moodle/widgets/nav_drawer.dart';
import 'package:moodle/widgets/top_app_bar.dart';

class CoursesView extends StatelessWidget {
  const CoursesView({Key? key}) : super(key: key);

  static const List<_Module> _modules = [
    _Module(
      code: 'COMP101',
      title: 'Programming Language',
      tutor: 'Dr Jiacheng Tan',
      progress: 0.78,
      nextTask: 'Workshop 7 quiz',
      status: 'In progress',
      color: moodleBlue,
      icon: Icons.code_outlined,
      route: '/courses/programming-language',
    ),
    _Module(
      code: 'WEB204',
      title: 'Web Development',
      tutor: 'Ms R. Patel',
      progress: 0.64,
      nextTask: 'Responsive layout task',
      status: 'Due soon',
      color: Color(0xFFD97706),
      icon: Icons.web_outlined,
      route: '/courses/web-development',
    ),
    _Module(
      code: 'DBS112',
      title: 'Database Systems',
      tutor: 'Mr K. Ahmed',
      progress: 0.52,
      nextTask: 'ERD submission',
      status: 'In progress',
      color: Color(0xFF16845B),
      icon: Icons.storage_outlined,
      route: '/courses/database-systems',
    ),
    _Module(
      code: 'UXD130',
      title: 'User Experience Design',
      tutor: 'Dr L. Green',
      progress: 0.86,
      nextTask: 'Prototype reflection',
      status: 'On track',
      color: Color(0xFFB4236A),
      icon: Icons.design_services_outlined,
      route: '/courses/user-experience-design',
    ),
  ];

  static const List<_UpcomingTask> _upcomingTasks = [
    _UpcomingTask(
      title: 'Responsive layout task',
      module: 'Web Development',
      due: 'Today, 16:00',
    ),
    _UpcomingTask(
      title: 'Workshop 7 quiz',
      module: 'Programming Language',
      due: 'Friday, 11:30',
    ),
    _UpcomingTask(
      title: 'ERD submission',
      module: 'Database Systems',
      due: 'Monday, 09:00',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MoodleTopAppBar(title: 'My courses'),
      drawer: const NavDrawer(),
      body: Container(
        color: moodleBg,
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final bool isWide = constraints.maxWidth >= 760;

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
                          'My courses',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: moodlePurple,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'This is the courses overview page.',
                          style: TextStyle(
                            fontSize: 14,
                            color: moodleTextMuted,
                          ),
                        ),
                        const SizedBox(height: 18),
                        _ModuleGrid(modules: _modules, isWide: isWide),
                        const SizedBox(height: 22),
                        const _SectionTitle(title: 'Upcoming course work'),
                        const SizedBox(height: 10),
                        const _UpcomingTaskList(tasks: _upcomingTasks),
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
}

class _ModuleGrid extends StatelessWidget {
  const _ModuleGrid({
    required this.modules,
    required this.isWide,
  });

  final List<_Module> modules;
  final bool isWide;

  @override
  Widget build(BuildContext context) {
    if (!isWide) {
      return Column(
        children: [
          for (int i = 0; i < modules.length; i++) ...[
            _ModuleCard(
              key: ValueKey('module-${modules[i].code}'),
              module: modules[i],
            ),
            if (i != modules.length - 1) const SizedBox(height: 10),
          ],
        ],
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: modules.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        mainAxisExtent: 210,
      ),
      itemBuilder: (context, index) {
        return _ModuleCard(
          key: ValueKey('module-${modules[index].code}'),
          module: modules[index],
        );
      },
    );
  }
}

class _ModuleCard extends StatelessWidget {
  const _ModuleCard({
    Key? key,
    required this.module,
  }) : super(key: key);

  final _Module module;

  @override
  Widget build(BuildContext context) {
    final int percentage = (module.progress * 100).round();

    return Card(
      color: moodleWhite,
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: moodleBorder),
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: module.route == null
            ? null
            : () => Navigator.pushNamed(context, module.route!),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: module.color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(module.icon, color: module.color, size: 24),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          module.code,
                          style: TextStyle(
                            color: module.color,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          module.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: moodleTextDark,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                module.tutor,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: moodleTextMuted, fontSize: 13),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: LinearProgressIndicator(
                        value: module.progress,
                        minHeight: 8,
                        color: module.color,
                        backgroundColor: moodleGrayBg,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '$percentage%',
                    style: TextStyle(
                      color: module.color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _StatusPill(label: module.status, color: module.color),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      module.nextTask,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        color: moodleTextMuted,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
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

class _UpcomingTaskList extends StatelessWidget {
  const _UpcomingTaskList({required this.tasks});

  final List<_UpcomingTask> tasks;

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
            _UpcomingTaskRow(task: tasks[i]),
            if (i != tasks.length - 1)
              const Divider(height: 1, color: moodleBorder),
          ],
        ],
      ),
    );
  }
}

class _UpcomingTaskRow extends StatelessWidget {
  const _UpcomingTaskRow({required this.task});

  final _UpcomingTask task;

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
              color: moodlePurple.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.assignment_outlined, color: moodlePurple),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
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
                  task.module,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: moodleTextMuted, fontSize: 13),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text(
            task.due,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: moodlePurple,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _Module {
  const _Module({
    required this.code,
    required this.title,
    required this.tutor,
    required this.progress,
    required this.nextTask,
    required this.status,
    required this.color,
    required this.icon,
    this.route,
  });

  final String code;
  final String title;
  final String tutor;
  final double progress;
  final String nextTask;
  final String status;
  final Color color;
  final IconData icon;
  final String? route;
}

class _UpcomingTask {
  const _UpcomingTask({
    required this.title,
    required this.module,
    required this.due,
  });

  final String title;
  final String module;
  final String due;
}
