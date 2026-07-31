import 'package:flutter/material.dart';

class CourseModule {
  const CourseModule({
    required this.code,
    required this.title,
    required this.tutor,
    required this.category,
    required this.progress,
    required this.nextTask,
    required this.status,
    required this.color,
    required this.icon,
    required this.route,
  });

  final String code;
  final String title;
  final String tutor;
  final String category;
  final double progress;
  final String nextTask;
  final String status;
  final Color color;
  final IconData icon;
  final String route;

  bool matchesSearch(String query) {
    final normalizedQuery = query.trim().toLowerCase();
    if (normalizedQuery.isEmpty) {
      return true;
    }

    return code.toLowerCase().contains(normalizedQuery) ||
        title.toLowerCase().contains(normalizedQuery) ||
        tutor.toLowerCase().contains(normalizedQuery) ||
        category.toLowerCase().contains(normalizedQuery) ||
        nextTask.toLowerCase().contains(normalizedQuery);
  }
}

class UpcomingCourseTask {
  const UpcomingCourseTask({
    required this.title,
    required this.module,
    required this.due,
  });

  final String title;
  final String module;
  final String due;
}
