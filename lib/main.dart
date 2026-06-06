import 'package:flutter/material.dart';
import 'splash_screen.dart';

void main() {
  runApp(const HaBIT());
}

class HaBIT extends StatelessWidget {
  const HaBIT({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'HaBIT Note';

    return MaterialApp(
      title: appTitle,
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
      themeMode: ThemeMode.light,
      home: const SplashScreen(),
    );
  }
}
