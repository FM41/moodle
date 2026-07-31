import 'package:flutter/material.dart';
import 'package:moodle/constants.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  static const List<_DrawerEntry> _mainMenu = [
    _DrawerEntry(
      title: 'Dashboard',
      icon: Icons.speed_outlined,
      route: '/',
    ),
    _DrawerEntry(
      title: 'Site home',
      icon: Icons.home_outlined,
    ),
    _DrawerEntry(
      title: 'Calendar',
      icon: Icons.calendar_month_outlined,
    ),
    _DrawerEntry(
      title: 'Private files',
      icon: Icons.folder_outlined,
    ),
    _DrawerEntry(
      title: 'My courses',
      icon: Icons.school_outlined,
      route: '/courses',
    ),
  ];

  static const List<_DrawerEntry> _courseMenu = [
    _DrawerEntry(
      title: 'Current course',
      icon: Icons.menu_book_outlined,
      route: '/courses/programming-language',
    ),
    _DrawerEntry(
      title: 'Participants',
      icon: Icons.groups_outlined,
    ),
    _DrawerEntry(
      title: 'Grades',
      icon: Icons.grade_outlined,
    ),
    _DrawerEntry(
      title: 'Badges',
      icon: Icons.workspace_premium_outlined,
    ),
  ];

  static const List<_DrawerEntry> _supportMenu = [
    _DrawerEntry(
      title: 'Profile',
      icon: Icons.person_outline,
      route: '/profile',
    ),
    _DrawerEntry(
      title: 'Help and support',
      icon: Icons.help_outline,
    ),
    _DrawerEntry(
      title: 'Preferences',
      icon: Icons.tune_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name ?? '/';

    return Drawer(
      backgroundColor: moodleWhite,
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const _DrawerHeader(),
            const _DrawerSectionTitle(title: 'Navigation'),
            for (final entry in _mainMenu)
              _DrawerMenuItem(
                entry: entry,
                selected: entry.route == currentRoute,
              ),
            const Divider(height: 24, color: moodleBorder),
            const _DrawerSectionTitle(title: 'Course menu'),
            for (final entry in _courseMenu)
              _DrawerMenuItem(
                entry: entry,
                selected: false,
              ),
            const Divider(height: 24, color: moodleBorder),
            const _DrawerSectionTitle(title: 'Account'),
            for (final entry in _supportMenu)
              _DrawerMenuItem(
                entry: entry,
                selected: false,
              ),
          ],
        ),
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader();

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: const BoxDecoration(
        color: moodlePurple,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: moodleWhite,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset(
                  'images/moodle_logo.png',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Moodle',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: moodleWhite,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          const Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: moodleWhite,
                foregroundColor: moodlePurple,
                child: Text(
                  'OM',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Oluwaferanmi Muraino',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: moodleWhite,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      'up2248415@myport.ac.uk',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DrawerSectionTitle extends StatelessWidget {
  const _DrawerSectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          color: moodleTextMuted,
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 0,
        ),
      ),
    );
  }
}

class _DrawerMenuItem extends StatelessWidget {
  const _DrawerMenuItem({
    required this.entry,
    required this.selected,
  });

  final _DrawerEntry entry;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final Color foregroundColor = selected ? moodlePurple : moodleTextDark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: ListTile(
        minLeadingWidth: 24,
        dense: true,
        leading: Icon(entry.icon, color: foregroundColor),
        title: Text(
          entry.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: foregroundColor,
            fontSize: 15,
            fontWeight: selected ? FontWeight.bold : FontWeight.w500,
          ),
        ),
        selected: selected,
        selectedTileColor: moodlePurple.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        onTap: () {
          Navigator.pop(context);
          if (entry.route != null && !selected) {
            Navigator.pushReplacementNamed(context, entry.route!);
          }
        },
      ),
    );
  }
}

class _DrawerEntry {
  const _DrawerEntry({
    required this.title,
    required this.icon,
    this.route,
  });

  final String title;
  final IconData icon;
  final String? route;
}
