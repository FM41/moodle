import 'package:flutter/material.dart';
import 'package:moodle/constants.dart';
import 'package:moodle/widgets/nav_drawer.dart';
import 'package:moodle/widgets/top_app_bar.dart';

class StaticInfoView extends StatelessWidget {
  const StaticInfoView({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.items,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final IconData icon;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MoodleTopAppBar(title: title),
      drawer: const NavDrawer(),
      body: Container(
        color: moodleBg,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 760),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: moodlePurple,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Card(
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
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: moodlePurple.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    icon,
                                    color: moodlePurple,
                                    size: 26,
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Text(
                                    subtitle,
                                    style: const TextStyle(
                                      color: moodleTextMuted,
                                      fontSize: 14,
                                      height: 1.35,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            const Divider(height: 1, color: moodleBorder),
                            const SizedBox(height: 8),
                            for (final item in items) _InfoRow(label: item),
                          ],
                        ),
                      ),
                    ),
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

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_outline, color: Color(0xFF16845B)),
          const SizedBox(width: 10),
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
