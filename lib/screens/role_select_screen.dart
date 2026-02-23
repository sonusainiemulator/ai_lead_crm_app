import 'package:flutter/material.dart';
import '../models/app_user.dart';
import 'home_shell_screen.dart';

class RoleSelectScreen extends StatelessWidget {
  final AppUser user;

  const RoleSelectScreen({super.key, required this.user});

  void _selectRole(BuildContext context, String role) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => HomeShellScreen(
          role: role,
          userName: user.name,
          userEmail: user.email,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Role')),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome, ${user.name}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Text('Signed in via ${user.authProvider.toUpperCase()}'),
            const SizedBox(height: 22),
            const Text('Choose your role', style: TextStyle(fontSize: 22)),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => _selectRole(context, 'Admin'),
              child: const Text('Admin'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _selectRole(context, 'Staff'),
              child: const Text('Staff/Employee'),
            ),
          ],
        ),
      ),
    );
  }
}
