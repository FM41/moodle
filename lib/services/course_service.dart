import 'package:flutter/material.dart';
import 'package:moodle/constants.dart';
import 'package:moodle/models/course_module.dart';

class CourseService {
  const CourseService();

  List<CourseModule> getModules() {
    return const [
      CourseModule(
        code: 'COMP101',
        title: 'Programming Language',
        tutor: 'Dr Jiacheng Tan',
        category: 'Computing',
        progress: 0.78,
        nextTask: 'Workshop 7 quiz',
        status: 'In progress',
        color: moodleBlue,
        icon: Icons.code_outlined,
        route: '/courses/programming-language',
      ),
      CourseModule(
        code: 'WEB204',
        title: 'Web Development',
        tutor: 'Ms R. Patel',
        category: 'Web',
        progress: 0.64,
        nextTask: 'Responsive layout task',
        status: 'Due soon',
        color: Color(0xFFD97706),
        icon: Icons.web_outlined,
        route: '/courses/web-development',
      ),
      CourseModule(
        code: 'DBS112',
        title: 'Database Systems',
        tutor: 'Mr K. Ahmed',
        category: 'Data',
        progress: 0.52,
        nextTask: 'ERD submission',
        status: 'In progress',
        color: Color(0xFF16845B),
        icon: Icons.storage_outlined,
        route: '/courses/database-systems',
      ),
      CourseModule(
        code: 'UXD130',
        title: 'User Experience Design',
        tutor: 'Dr L. Green',
        category: 'Design',
        progress: 0.86,
        nextTask: 'Prototype reflection',
        status: 'On track',
        color: Color(0xFFB4236A),
        icon: Icons.design_services_outlined,
        route: '/courses/user-experience-design',
      ),
    ];
  }

  List<UpcomingCourseTask> getUpcomingTasks() {
    return const [
      UpcomingCourseTask(
        title: 'Responsive layout task',
        module: 'Web Development',
        due: 'Today, 16:00',
      ),
      UpcomingCourseTask(
        title: 'Workshop 7 quiz',
        module: 'Programming Language',
        due: 'Friday, 11:30',
      ),
      UpcomingCourseTask(
        title: 'ERD submission',
        module: 'Database Systems',
        due: 'Monday, 09:00',
      ),
    ];
  }

  List<CourseModule> filterModules({
    required String query,
    required String status,
    required String category,
  }) {
    return getModules().where((module) {
      final bool matchesStatus = status == 'All' || module.status == status;
      final bool matchesCategory =
          category == 'All' || module.category == category;

      return module.matchesSearch(query) && matchesStatus && matchesCategory;
    }).toList();
  }

  List<UpcomingCourseTask> tasksForModules(List<CourseModule> modules) {
    final moduleNames = modules.map((module) => module.title).toSet();

    return getUpcomingTasks()
        .where((task) => moduleNames.contains(task.module))
        .toList();
  }
}
