import 'package:dream_to_rank_mobile/core/constants/colors.dart';
import 'package:dream_to_rank_mobile/features/auth/presentation/screens/otp_verification.dart';
import 'package:flutter/material.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController phoneController =
      TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  void getOtp() {
    final phone = phoneController.text.trim();

    if (phone.length != 10 ||
        int.tryParse(phone) == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid 10-digit number'),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => OtpVerificationScreen(
          phoneNumber: '+91 $phone',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 20,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 40,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
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

                    const SizedBox(height: 36),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(
                        22, 32, 22, 28,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.black12,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x22000000),
                            blurRadius: 5,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'Create a free account to\n'
                            'unleash your UPSC journey',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                              height: 1.25,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF252525),
                            ),
                          ),

                          const SizedBox(height: 30),

                          Image.asset(
                            'assets/images/phone_otp_logo.png',
                            height: 160,
                            fit: BoxFit.contain,
                            errorBuilder: (_, __, ___) =>
                                const SizedBox(
                              height: 190,
                              child: Icon(
                                Icons.lock_person_outlined,
                                size: 100,
                                color: Colors.deepPurple,
                              ),
                            ),
                          ),

                          const SizedBox(height: 28),

                          TextField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            maxLength: 10,
                            decoration: InputDecoration(
                              counterText: '',
                              hintText: '+91 888 222 9990',
                              hintStyle: const TextStyle(
                                color: Colors.black38,
                                fontSize: 14,
                              ),
                              contentPadding:
                                  const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 22,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: AppColors.primaryColor,
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: getOtp,
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    AppColors.primaryColor,
                                foregroundColor: Colors.white,
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(13),
                                ),
                              ),
                              child: const Text(
                                'Get OTP',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Wrap(
                          //   alignment: WrapAlignment.center,
                          //   children: [
                          //     const Text(
                          //       'Existing user? ',
                          //       style: TextStyle(fontSize: 15),
                          //     ),
                          //     GestureDetector(
                          //       onTap: () {
                          //         // TODO: Open your login screen.
                          //       },
                          //       child: const Text(
                          //         'Sign In',
                          //         style: TextStyle(
                          //           color: AppColors.primaryColor,
                          //           fontSize: 15,
                          //           fontWeight: FontWeight.w500,
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),

                          const SizedBox(height: 26),

                          const Text(
                            'or',
                            style: TextStyle(
                              color: Colors.black38,
                              fontSize: 14,
                            ),
                          ),

                          const SizedBox(height: 24),

                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: OutlinedButton(
                              onPressed: () {
                                // TODO: Add Google Sign-In.
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.black87,
                                side: const BorderSide(
                                  color: Color(0xFFE8EAF2),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(12),
                                ),
                              ),
                              child:  Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/logo/google_logo.png"),
                                  SizedBox(width: 8),
                                  Text(
                                    'Sign up with Google',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}