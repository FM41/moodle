import 'package:flutter/material.dart';
import 'package:moodle/constants.dart';

class MoodleTopAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MoodleTopAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final bool compact = MediaQuery.of(context).size.width < 390;

    return AppBar(
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
          Flexible(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          tooltip: 'Search',
          icon: const Icon(Icons.search_outlined),
          onPressed: () {},
        ),
        IconButton(
          tooltip: 'Notifications',
          icon: const Badge(
            smallSize: 8,
            backgroundColor: Color(0xFFD97706),
            child: Icon(Icons.notifications_none_outlined),
          ),
          onPressed: () {},
        ),
        if (!compact)
          IconButton(
            tooltip: 'Messages',
            icon: const Icon(Icons.chat_bubble_outline),
            onPressed: () {},
          ),
        Padding(
          padding: const EdgeInsets.only(left: 2, right: 8),
          child: PopupMenuButton<String>(
            tooltip: 'Account menu',
            offset: const Offset(0, 44),
            onSelected: (value) {
              if (value == 'profile' &&
                  ModalRoute.of(context)?.settings.name != '/profile') {
                Navigator.pushReplacementNamed(context, '/profile');
              } else if (value == 'logout') {
                Navigator.pushReplacementNamed(context, '/login');
              }
            },
            icon: const CircleAvatar(
              radius: 18,
              backgroundColor: moodleGrayBg,
              foregroundColor: moodlePurple,
              child: Text(
                'OM',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ),
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: 'profile',
                child: Text('Profile'),
              ),
              PopupMenuItem(
                value: 'preferences',
                child: Text('Preferences'),
              ),
              PopupMenuItem(
                value: 'logout',
                child: Text('Log out'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
