import 'package:dream_to_rank_mobile/core/constants/colors.dart';
import 'package:dream_to_rank_mobile/features/onboarding/onboarding.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            children: [
              const SizedBox(height: 28),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo/logo .png',
                    height: 42,
                    fit: BoxFit.contain,
                  ),
                  Text(
                    "dreamtorank",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,

                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),

              const Spacer(),

              const Text(
                'Hi!\n'
                'Welcome to dreamtorank.\n'
                'We will be your guide throughout\n'
                'your UPSC journey.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  height: 1.2,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF252525),
                ),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 64,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const OnboardingScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                  ),
                  child: const Text('Continue', style: TextStyle(fontSize: 15)),
                ),
              ),

              const SizedBox(height: 70),
            ],
          ),
        ),
      ),
    );
  }
}
