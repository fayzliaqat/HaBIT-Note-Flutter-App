import 'package:flutter/material.dart';
import 'onboarding_page.dart';
import 'onboarding_drawer.dart';
import '/screens/register_screen.dart';
import '../login_screen.dart';

const onboardingData = [
  {
    'image': 'assets/images/onboarding_1.png',
    'title': 'Take Notes',
    'subtitle': 'Quickly capture what’s on your mind',
  },
  {
    'image': 'assets/images/onboarding_2.png',
    'title': 'To-dos',
    'subtitle': 'List out your day-to-day tasks',
  },
  {
    'image': 'assets/images/onboarding_3.png',
    'title': 'Image to Text Converter',
    'subtitle': 'Upload your images and convert to text',
  },
];

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const OnboardingDrawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu, color: Colors.orange),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
              const SizedBox(height: 12),

              if (_currentPage == 0) ...[
                const Text(
                  'WELCOME TO',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                ),
                const Text(
                  'HaBIT Note',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 12),
              ],

              // PageView
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: onboardingData.length,
                  onPageChanged: (index) {
                    setState(() => _currentPage = index);
                  },
                  itemBuilder: (_, index) {
                    final data = onboardingData[index];
                    return OnboardingPage(
                      image: data['image']!,
                      title: data['title']!,
                      subtitle: data['subtitle']!,
                      isFirstPage: index == 0,
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              // Dot indicators
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildDot(isActive: _currentPage == 0),
                  _buildDot(isActive: _currentPage == 1),
                  _buildDot(isActive: _currentPage == 2),
                ],
              ),

              const SizedBox(height: 24),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  side: const BorderSide(color: Colors.white),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterScreen()),
                  );
                },
                child: const Text(
                  'CREATE ACCOUNT',
                  style: TextStyle(color: Colors.white),
                ),
              ),

              const SizedBox(height: 12),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Colors.orange),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
                },
                child: const Text(
                  'LOG IN',
                  style: TextStyle(color: Colors.orange),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Dot indicator
  Widget _buildDot({bool isActive = false}) {
    return Container(
      width: isActive ? 25 : 10,
      height: 10,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: isActive ? Colors.orange : Colors.grey,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
