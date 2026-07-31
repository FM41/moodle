import 'package:flutter/material.dart';
import 'package:moodle/constants.dart';
import 'package:moodle/models/course_module.dart';
import 'package:moodle/services/course_service.dart';
import 'package:moodle/widgets/nav_drawer.dart';
import 'package:moodle/widgets/top_app_bar.dart';

class CoursesView extends StatefulWidget {
  const CoursesView({Key? key}) : super(key: key);

  @override
  State<CoursesView> createState() => _CoursesViewState();
}

class _CoursesViewState extends State<CoursesView> {
  static const CourseService _courseService = CourseService();
  static const List<String> _statuses = [
    'All',
    'In progress',
    'Due soon',
    'On track',
  ];
  static const List<String> _categories = [
    'All',
    'Computing',
    'Web',
    'Data',
    'Design',
  ];

  final TextEditingController _searchController = TextEditingController();
  String _query = '';
  String _selectedStatus = 'All';
  String _selectedCategory = 'All';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<CourseModule> modules = _courseService.filterModules(
      query: _query,
      status: _selectedStatus,
      category: _selectedCategory,
    );
    final List<UpcomingCourseTask> tasks =
        _courseService.tasksForModules(modules);

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
                          'Search and filter your modules from the local course data service.',
                          style: TextStyle(
                            fontSize: 14,
                            color: moodleTextMuted,
                          ),
                        ),
                        const SizedBox(height: 18),
                        _CourseFilters(
                          controller: _searchController,
                          statuses: _statuses,
                          categories: _categories,
                          selectedStatus: _selectedStatus,
                          selectedCategory: _selectedCategory,
                          resultCount: modules.length,
                          onSearchChanged: (value) {
                            setState(() {
                              _query = value;
                            });
                          },
                          onStatusChanged: (value) {
                            setState(() {
                              _selectedStatus = value;
                            });
                          },
                          onCategoryChanged: (value) {
                            setState(() {
                              _selectedCategory = value;
                            });
                          },
                          onReset: _resetFilters,
                        ),
                        const SizedBox(height: 18),
                        if (modules.isEmpty)
                          const _EmptyCourses()
                        else
                          _ModuleGrid(modules: modules, isWide: isWide),
                        const SizedBox(height: 22),
                        const _SectionTitle(title: 'Upcoming course work'),
                        const SizedBox(height: 10),
                        _UpcomingTaskList(tasks: tasks),
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

  void _resetFilters() {
    setState(() {
      _query = '';
      _selectedStatus = 'All';
      _selectedCategory = 'All';
      _searchController.clear();
    });
  }
}

class _CourseFilters extends StatelessWidget {
  const _CourseFilters({
    required this.controller,
    required this.statuses,
    required this.categories,
    required this.selectedStatus,
    required this.selectedCategory,
    required this.resultCount,
    required this.onSearchChanged,
    required this.onStatusChanged,
    required this.onCategoryChanged,
    required this.onReset,
  });

  final TextEditingController controller;
  final List<String> statuses;
  final List<String> categories;
  final String selectedStatus;
  final String selectedCategory;
  final int resultCount;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<String> onStatusChanged;
  final ValueChanged<String> onCategoryChanged;
  final VoidCallback onReset;

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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              key: const ValueKey('course-search-field'),
              controller: controller,
              onChanged: onSearchChanged,
              decoration: const InputDecoration(
                labelText: 'Search courses',
                hintText: 'Try "web", "database", or "quiz"',
                prefixIcon: Icon(Icons.search_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Status',
              style: TextStyle(
                color: moodleTextDark,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final status in statuses)
                  ChoiceChip(
                    label: Text(status),
                    selected: selectedStatus == status,
                    onSelected: (_) => onStatusChanged(status),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    key: const ValueKey('course-category-filter'),
                    value: selectedCategory,
                    decoration: const InputDecoration(
                      labelText: 'Category',
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      for (final category in categories)
                        DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        onCategoryChanged(value);
                      }
                    },
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  tooltip: 'Reset course filters',
                  onPressed: onReset,
                  icon: const Icon(Icons.refresh_outlined),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              '$resultCount courses shown',
              style: const TextStyle(color: moodleTextMuted, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyCourses extends StatelessWidget {
  const _EmptyCourses();

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
        padding: EdgeInsets.all(18),
        child: Text(
          'No courses match your search and filters.',
          style: TextStyle(color: moodleTextMuted, fontSize: 14),
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

  final List<CourseModule> modules;
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
        mainAxisExtent: 228,
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

  final CourseModule module;

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
        onTap: () => Navigator.pushNamed(context, module.route),
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
              const SizedBox(height: 6),
              Text(
                module.category,
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

  final List<UpcomingCourseTask> tasks;

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return Card(
        color: moodleWhite,
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: moodleBorder),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'No upcoming course work for the current results.',
            style: TextStyle(color: moodleTextMuted, fontSize: 14),
          ),
        ),
      );
    }

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

  final UpcomingCourseTask task;

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
