import 'package:flutter/material.dart';
import '/screens/forgot_password_screen.dart';

class HelpTab extends StatelessWidget {
  const HelpTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 60, bottom: 24),
            width: double.infinity,
            color: Colors.orange,
            child: const Center(
              child: Text(
                'User Guide',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          _buildHelpCard(
            icon: Icons.notes,
            title: 'Notes',
            onTap: () {},
          ),
          _buildHelpCard(
            icon: Icons.image_search,
            title: 'OCR',
            onTap: () {},
          ),
          _buildHelpCard(
            icon: Icons.lock,
            title: 'Reset Password',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHelpCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
          child: Row(
            children: [
              Icon(icon, color: Colors.white),
              const SizedBox(width: 16),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              const Text(
                'Tap to view',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
