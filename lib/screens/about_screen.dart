import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 32),
            color: Colors.orange,
            child: const Icon(
              Icons.note_alt_outlined,
              size: 64,
              color: Colors.white,
            ),
          ),
          const ListTile(
            title: Text('Application'),
            trailing: Text('HaBIT Note'),
          ),
          const Divider(),
          const ListTile(
            title: Text('Version'),
            trailing: Text('v1.0.0'),
          ),
          const Divider(),
          const ListTile(
            title: Text('Privacy Policy'),
            trailing: Icon(Icons.chevron_right),
          ),
          const Divider(),
          const ListTile(
            title: Text('Terms of Use'),
            trailing: Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}
