import 'package:flutter/material.dart';
import 'package:moodle/widgets/nav_drawer.dart';
import 'package:moodle/widgets/top_app_bar.dart';
import 'package:moodle/constants.dart';

class CoursesView extends StatelessWidget {
  const CoursesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MoodleTopAppBar(title: 'My courses'),
      drawer: const NavDrawer(),
      body: Container(
        color: moodleBg,
        child: const SingleChildScrollView(
          padding: EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My courses',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: moodlePurple,
                ),
              ),
              SizedBox(height: 24),
              Text(
                'This is the courses overview page.',
                style: TextStyle(fontSize: 16, color: moodleTextDark),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
