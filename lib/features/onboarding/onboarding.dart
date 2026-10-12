import 'package:dream_to_rank_mobile/core/constants/colors.dart';
import 'package:dream_to_rank_mobile/features/auth/presentation/screens/signup.dart';
import 'package:flutter/material.dart';

class OnboardingItem {
  final String image;
  final String title;
  final String description;

  const OnboardingItem({
    required this.image,
    required this.title,
    required this.description,
  });
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() =>
      _OnboardingScreenState();
}

class _OnboardingScreenState
    extends State<OnboardingScreen> {
  final PageController _controller = PageController();

  int currentPage = 0;

  final List<OnboardingItem> pages = const [
    OnboardingItem(
      image: 'assets/images/onboarding0.png',
      title: 'Meet Your Smarter UPSC\nPreparation Toolkit',
      description: '',
    ),
    OnboardingItem(
      image: 'assets/images/onboarding1.png',
      title: 'AI Smart Quiz',
      description:
          'Test your knowledge with AI smart multiple-choice quiz!',
    ),
    OnboardingItem(
      image: 'assets/images/onboarding2.png',
      title: 'AI Mains Evaluator',
      description:
          'Recognize handwriting and instantly assess descriptive exam answers, providing automated scores, structural breakdowns, missing keywords, and personalized feedback within seconds.',
    ),
    OnboardingItem(
      image: 'assets/images/onboarding3.png',
      title: '34 Years PYQs',
      description:
          'Helps you learn the exam pattern, find recurring high weightage topics, and practice time management.',
    ),
    OnboardingItem(
      image: 'assets/images/onboarding4.png',
      title: '1:1 Mentorship',
      description:
          'One-on-one mentorship provides personalized guidance, customized study plans, regular answer writing evaluation.',
    ),
  ];

  void nextPage() {
    if (currentPage < pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
     Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
    }
  }

  void previousPage() {
    if (currentPage > 0) {
      _controller.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void finishOnboarding() {

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Onboarding completed'),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final compact = screenHeight < 750;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: pages.length,
                onPageChanged: (index) {
                  setState(() => currentPage = index);
                },
                itemBuilder: (context, index) {
                  return _buildPage(
                    pages[index],
                    compact,
                  );
                },
              ),
            ),

            // Page indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 7,
                  ),
                  width: 48,
                  height: 5,
                  decoration: BoxDecoration(
                    color: currentPage == index
                        ? AppColors.primaryColor
                        : const Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            SizedBox(height: compact ? 22 : 48),

            // Bottom navigation buttons
            Padding(
              padding: const EdgeInsets.fromLTRB(
                32, 0, 32, 28,
              ),
              child: Row(
                children: [
                  if (currentPage > 0)
                    _button(
                      label: 'Back',
                      background:AppColors.peachColor,
                      foreground: AppColors.primaryColor,
                      onPressed: previousPage,
                    )
                  else
                    const SizedBox(width: 1),

                  const Spacer(),

                  _button(
                    label: currentPage == pages.length - 1
                        ? 'Get Started'
                        : 'Next',
                    background:  AppColors.primaryColor,
                    foreground: Colors.white,
                    wide: currentPage == pages.length - 1,
                    onPressed: nextPage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(
    OnboardingItem item,
    bool compact,
  ) {
    return Stack(
      children: [
        // Decorative peach circles
        Positioned(
          left: -90,
          top: 100,
          child: _circle(180),
        ),
        Positioned(
          right: 70,
          top: 90,
          child: _circle(48),
        ),
        Positioned(
          left: 55,
          top: 265,
          child: _circle(28),
        ),

        // Skip button
        Positioned(
          top: 24,
          right: 20,
          child: TextButton(
            onPressed: finishOnboarding,
            child: const Text(
              'Skip',
              style: TextStyle(
                color:  AppColors.primaryColor,
                fontSize: 15,
              ),
            ),
          ),
        ),

        // Illustration and text
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 28,
          ),
          child: Column(
            children: [
              SizedBox(height: compact ? 65 : 90),

              Expanded(
                flex: 6,
                child: Center(
                  child: Image.asset(
                    item.image,
                    fit: BoxFit.contain,
                    width: MediaQuery.sizeOf(context).width * 0.58,
                    errorBuilder: (_, __, ___) =>
                        const Icon(
                      Icons.image_outlined,
                      size: 65,
                      color:  AppColors.peachColor,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              Text(
                item.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 23,
                  height: 1.2,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF252525),
                ),
              ),

              if (item.description.isNotEmpty) ...[
                const SizedBox(height: 18),
                Text(
                  item.description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.25,
                    color: Color(0xFF303030),
                  ),
                ),
              ],

              const Spacer(flex: 3),
            ],
          ),
        ),
      ],
    );
  }

  Widget _circle(double size) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          color:  AppColors.peachColor,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _button({
    required String label,
    required Color background,
    required Color foreground,
    required VoidCallback onPressed,
    bool wide = false,
  }) {
    return SizedBox(
      height: 48,
      width: wide ? 174 : 122,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: background,
          foregroundColor: foreground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}