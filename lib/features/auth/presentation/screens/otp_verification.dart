import 'package:dream_to_rank_mobile/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String phoneNumber;

  const OtpVerificationScreen({super.key, required this.phoneNumber});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<TextEditingController> controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  bool isVerifying = false;

  @override
  void dispose() {
    for (final controller in controllers) {
      controller.dispose();
    }
    for (final node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void onOtpChanged(String value, int index) {
    if (value.isNotEmpty && index < 5) {
      focusNodes[index + 1].requestFocus();
    }

    if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }

    final otp = controllers.map((c) => c.text).join();

    if (otp.length == 6 && !otp.contains('')) {
      // All six boxes contain a digit.
      verifyOtp();
    }
  }

  Future<void> verifyOtp() async {
    final otp = controllers.map((c) => c.text).join();

    if (otp.length != 6 || int.tryParse(otp) == null || isVerifying) {
      return;
    }

    setState(() => isVerifying = true);

    try {
      // TODO: Call your OTP verification API here.
      // On success, navigate to your next screen.
      await Future<void>.delayed(const Duration(milliseconds: 400));

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Connect your OTP verification API')),
      );
    } finally {
      if (mounted) {
        setState(() => isVerifying = false);
      }
    }
  }

  void resendCode() {
    for (final controller in controllers) {
      controller.clear();
    }

    focusNodes.first.requestFocus();

    // TODO: Call your resend OTP API here.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Connect your resend OTP API')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),

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

            const SizedBox(height: 78),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Enter 6 digit verification code sent\n'
                'to your phone number',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
    fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF252525),
                ),
              ),
            ),

            const SizedBox(height: 8),

            Text(
              widget.phoneNumber,
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),

            const SizedBox(height: 82),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(6, (index) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: SizedBox(
                        height: 54,
                        child: TextField(
                          controller: controllers[index],
                          focusNode: focusNodes[index],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          maxLength: 1,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: InputDecoration(
                            counterText: '',
                            contentPadding: EdgeInsets.zero,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: AppColors.primaryColor,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: AppColors.primaryColor,
                                width: 1.5,
                              ),
                            ),
                          ),
                          onChanged: (value) => onOtpChanged(value, index),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(height: 26),

            TextButton(
              onPressed: resendCode,
              child: const Text(
                'Resend Code',

                style: TextStyle(
                      fontFamily: 'Inter',
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),

            const Spacer(),

            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 28),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: isVerifying ? null : verifyOtp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child:
                      isVerifying
                          ? const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                          : const Text(
                            'Verify OTP',
                            style: TextStyle(
                              fontSize: 16,
                                  fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
