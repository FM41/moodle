import 'package:flutter/material.dart';
import 'package:moodle/constants.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: moodleBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 28),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _BrandHeader(),
                  SizedBox(height: 16),
                  _LoginFormCard(),
                  SizedBox(height: 16),
                  _FooterCard(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BrandHeader extends StatelessWidget {
  const _BrandHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 74,
          height: 74,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: moodleWhite,
            border: Border.all(color: moodleBorder),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Image.asset(
            'images/moodle_logo.png',
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Welcome to Moodle Cloud',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: moodlePurple,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'University of Portsmouth learning environment',
          textAlign: TextAlign.center,
          style: TextStyle(color: moodleTextMuted, fontSize: 14),
        ),
      ],
    );
  }
}

class _LoginFormCard extends StatelessWidget {
  const _LoginFormCard();

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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Log in using your account on:',
              style: TextStyle(
                color: moodleTextDark,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: () => Navigator.pushReplacementNamed(context, '/'),
              icon: const Icon(Icons.account_circle_outlined),
              label: const Text('OpenID Connect'),
              style: FilledButton.styleFrom(
                backgroundColor: moodlePurple,
                foregroundColor: moodleWhite,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 18),
            const Divider(height: 1, color: moodleBorder),
            const SizedBox(height: 18),
            const Text(
              'Already have an account?',
              style: TextStyle(
                color: moodleTextDark,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Username or email',
                prefixIcon: Icon(Icons.person_outline),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock_outline),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 14),
            FilledButton(
              onPressed: () => Navigator.pushReplacementNamed(context, '/'),
              style: FilledButton.styleFrom(
                backgroundColor: moodleBlue,
                foregroundColor: moodleWhite,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Log in'),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {},
              child: const Text('Lost password?'),
            ),
          ],
        ),
      ),
    );
  }
}

class _FooterCard extends StatelessWidget {
  const _FooterCard();

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
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Cookies notice',
              style: TextStyle(
                color: moodleTextDark,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 6),
            Text(
              'You are not logged in.',
              textAlign: TextAlign.center,
              style: TextStyle(color: moodleTextMuted, fontSize: 13),
            ),
            SizedBox(height: 10),
            Text(
              'Powered by Moodle | Privacy Policy | Accessibility Statement',
              textAlign: TextAlign.center,
              style: TextStyle(color: moodleTextMuted, fontSize: 12),
            ),
            SizedBox(height: 6),
            Text(
              '© 2025 University of Portsmouth',
              textAlign: TextAlign.center,
              style: TextStyle(color: moodleTextMuted, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
