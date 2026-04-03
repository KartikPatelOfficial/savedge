import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:savedge/features/auth/presentation/pages/phone_verification_page.dart';

/// Shows a beautifully animated bottom sheet prompting the user to sign in.
/// Use this when a guest user tries to access account-based features.
class LoginPrompt {
  static void show(BuildContext context, {String? message}) {
    HapticFeedback.mediumImpact();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      barrierColor: Colors.black54,
      builder: (context) => _LoginPromptSheet(message: message),
    );
  }
}

class _LoginPromptSheet extends StatefulWidget {
  const _LoginPromptSheet({this.message});
  final String? message;

  @override
  State<_LoginPromptSheet> createState() => _LoginPromptSheetState();
}

class _LoginPromptSheetState extends State<_LoginPromptSheet>
    with TickerProviderStateMixin {
  late final AnimationController _entranceController;
  late final AnimationController _pulseController;

  // Staggered entrance animations
  late final Animation<double> _iconScale;
  late final Animation<double> _iconFade;
  late final Animation<Offset> _titleSlide;
  late final Animation<double> _titleFade;
  late final Animation<Offset> _messageSlide;
  late final Animation<double> _messageFade;
  late final Animation<Offset> _benefitsSlide;
  late final Animation<double> _benefitsFade;
  late final Animation<Offset> _buttonSlide;
  late final Animation<double> _buttonFade;
  late final Animation<Offset> _secondarySlide;
  late final Animation<double> _secondaryFade;

  // Subtle pulse on icon
  late final Animation<double> _pulse;

  @override
  void initState() {
    super.initState();

    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    _pulse = Tween<double>(begin: 1.0, end: 1.06).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Icon: 0ms - 400ms
    _iconScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.0, 0.45, curve: Curves.elasticOut),
      ),
    );
    _iconFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.0, 0.25, curve: Curves.easeOut),
      ),
    );

    // Title: 100ms - 450ms
    _titleSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.12, 0.5, curve: Curves.easeOutCubic),
    ));
    _titleFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.12, 0.4, curve: Curves.easeOut),
      ),
    );

    // Message: 200ms - 550ms
    _messageSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.22, 0.6, curve: Curves.easeOutCubic),
    ));
    _messageFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.22, 0.5, curve: Curves.easeOut),
      ),
    );

    // Benefits: 300ms - 650ms
    _benefitsSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.33, 0.72, curve: Curves.easeOutCubic),
    ));
    _benefitsFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.33, 0.6, curve: Curves.easeOut),
      ),
    );

    // Button: 400ms - 750ms
    _buttonSlide = Tween<Offset>(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.44, 0.83, curve: Curves.easeOutCubic),
    ));
    _buttonFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.44, 0.7, curve: Curves.easeOut),
      ),
    );

    // Secondary: 500ms - 850ms
    _secondarySlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.55, 0.95, curve: Curves.easeOutCubic),
    ));
    _secondaryFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.55, 0.85, curve: Curves.easeOut),
      ),
    );

    _entranceController.forward();
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _entranceController,
      builder: (context, child) => child!,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Drag handle
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE2E8F0),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 28),

                // Animated icon
                _buildIcon(),
                const SizedBox(height: 24),

                // Title
                _buildAnimatedSlide(
                  slide: _titleSlide,
                  fade: _titleFade,
                  child: const Text(
                    'Unlock the full experience',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1A202C),
                      letterSpacing: -0.3,
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Message
                _buildAnimatedSlide(
                  slide: _messageSlide,
                  fade: _messageFade,
                  child: Text(
                    widget.message ?? 'Sign in to access all features for free.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color(0xFF64748B),
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Benefit chips
                _buildAnimatedSlide(
                  slide: _benefitsSlide,
                  fade: _benefitsFade,
                  child: _buildBenefitChips(),
                ),
                const SizedBox(height: 28),

                // Primary CTA
                _buildAnimatedSlide(
                  slide: _buttonSlide,
                  fade: _buttonFade,
                  child: _buildSignInButton(),
                ),
                const SizedBox(height: 12),

                // Secondary
                _buildAnimatedSlide(
                  slide: _secondarySlide,
                  fade: _secondaryFade,
                  child: TextButton(
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: const Text(
                      'Maybe later',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF94A3B8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return AnimatedBuilder(
      animation: Listenable.merge([_entranceController, _pulseController]),
      builder: (context, child) {
        return Opacity(
          opacity: _iconFade.value,
          child: Transform.scale(
            scale: _iconScale.value * _pulse.value,
            child: child,
          ),
        );
      },
      child: Image.asset(
        'assets/images/logo_transparant.png',
        width: 90,
        height: 90,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildBenefitChips() {
    const benefits = [
      (Icons.local_offer_rounded, 'Redeem coupons'),
      (Icons.favorite_rounded, 'Save favorites'),
      (Icons.card_giftcard_rounded, 'Earn rewards'),
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: benefits.map((b) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F3FF),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFFEDE9FE),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(b.$1, size: 16, color: const Color(0xFF7C3AED)),
              const SizedBox(width: 6),
              Text(
                b.$2,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF5B21B6),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSignInButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [Color(0xFF7C3AED), Color(0xFF6366F1)],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF7C3AED).withValues(alpha: 0.35),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            HapticFeedback.mediumImpact();
            Navigator.pop(context);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const PhoneVerificationPage(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
                ),
              ),
              SizedBox(width: 8),
              Icon(Icons.arrow_forward_rounded, size: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedSlide({
    required Animation<Offset> slide,
    required Animation<double> fade,
    required Widget child,
  }) {
    return AnimatedBuilder(
      animation: _entranceController,
      builder: (context, _) {
        return FractionalTranslation(
          translation: slide.value,
          child: Opacity(
            opacity: fade.value,
            child: child,
          ),
        );
      },
    );
  }
}
