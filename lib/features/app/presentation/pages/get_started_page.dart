import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:savedge/features/auth/presentation/pages/phone_verification_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class GetStartedPage extends StatefulWidget {
  const GetStartedPage({super.key});

  @override
  State<GetStartedPage> createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _setFirstTimeFlag();
    // Use a longer duration for a smoother, calming background animation
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _setFirstTimeFlag() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', false);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA), // Crisp off-white background
      body: Stack(
        children: [
          // Animated Background Orbs (Fun, playful pastel colors)
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Stack(
                children: [
                  // Top Right warm purple orb
                  Positioned(
                    top:
                        size.height * -0.1 +
                        math.sin(_animationController.value * math.pi * 2) * 40,
                    right:
                        size.width * -0.2 +
                        math.cos(_animationController.value * math.pi * 2) * 40,
                    child: Container(
                      width: size.width * 0.8,
                      height: size.width * 0.8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(
                          0xFFDDD6FE,
                        ).withOpacity(0.6), // Light violet
                      ),
                    ),
                  ),
                  // Bottom Left minty/savedge green orb
                  Positioned(
                    bottom:
                        size.height * -0.1 +
                        math.cos(_animationController.value * math.pi * 2) * 60,
                    left:
                        size.width * -0.3 +
                        math.sin(_animationController.value * math.pi * 2) * 60,
                    child: Container(
                      width: size.width * 0.9,
                      height: size.width * 0.9,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(
                          0xFFD1FAE5,
                        ).withOpacity(0.6), // Light emerald/mint
                      ),
                    ),
                  ),
                  // Center-ish blue/indigo playful orb
                  Positioned(
                    top:
                        size.height * 0.3 +
                        math.cos(
                              _animationController.value * math.pi * 2 +
                                  math.pi,
                            ) *
                            30,
                    left:
                        size.width * 0.2 +
                        math.sin(
                              _animationController.value * math.pi * 2 +
                                  math.pi,
                            ) *
                            30,
                    child: Container(
                      width: size.width * 0.5,
                      height: size.width * 0.5,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(
                          0xFFDBEAFE,
                        ).withOpacity(0.5), // Light blue
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          // Blur effect to make orbs look like soft gradients
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
            child: Container(color: Colors.white.withOpacity(0.4)),
          ),

          // Main Content
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Logo container with a subtle float and soft shadow
                        AnimatedBuilder(
                          animation: _animationController,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(
                                0,
                                math.sin(
                                      _animationController.value * math.pi * 4,
                                    ) *
                                    8,
                              ),
                              child: child,
                            );
                          },
                          child: Image.asset(
                            'assets/images/logo.png',
                            width: 140,
                            // Slightly smaller since the logo itself has text
                            fit: BoxFit.contain,
                          ),
                        ),

                        const SizedBox(height: 50),

                        // Fun, inviting text
                        const Text(
                          'Welcome',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.5,
                            color: Color(0xFF1E293B), // Slate 800
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Text(
                            'Discover exclusive offers and unlimited savings, everywhere you go.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              height: 1.5,
                              color: Color(0xFF64748B), // Slate 500
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Bottom Section (Button)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 40,
                  ),
                  child: Column(
                    children: [
                      // Get Started Button - playful, vibrant
                      Container(
                        width: double.infinity,
                        height: 64,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF6366F1).withOpacity(0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        const PhoneVerificationPage(),
                                transitionsBuilder:
                                    (
                                      context,
                                      animation,
                                      secondaryAnimation,
                                      child,
                                    ) {
                                      return FadeTransition(
                                        opacity: animation,
                                        child: child,
                                      );
                                    },
                                transitionDuration: const Duration(
                                  milliseconds: 400,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6366F1),
                            // Indigo 500
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Get Started',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(
                                  color: Colors.white24,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.arrow_forward_rounded,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 28),

                      // Terms and Privacy snippet
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF94A3B8), // Slate 400
                            height: 1.5,
                            fontWeight: FontWeight.w500,
                          ),
                          children: [
                            const TextSpan(text: 'By continuing, you agree to our\n'),
                            const TextSpan(
                              text: 'Terms of Service',
                              style: TextStyle(
                                color: Color(0xFF64748B),
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            const TextSpan(text: ' and '),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: const TextStyle(
                                color: Color(0xFF64748B),
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()..onTap = () {
                                launchUrl(Uri.parse('https://savedge.in/privacy'));
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
