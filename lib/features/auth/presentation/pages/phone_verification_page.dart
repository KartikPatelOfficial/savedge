import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savedge/features/auth/presentation/bloc/otp_auth_cubit.dart';
import 'package:savedge/features/auth/presentation/pages/otp_verification_page.dart';
import 'package:url_launcher/url_launcher.dart';

class PhoneVerificationPage extends StatefulWidget {
  const PhoneVerificationPage({super.key});

  @override
  State<PhoneVerificationPage> createState() => _PhoneVerificationPageState();
}

class _PhoneVerificationPageState extends State<PhoneVerificationPage>
    with TickerProviderStateMixin {
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late AnimationController _fadeAnimationController;
  late AnimationController _slideAnimationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  Country _selectedCountry = Country(
    phoneCode: '91',
    countryCode: 'IN',
    e164Sc: 91,
    geographic: true,
    level: 1,
    name: 'India',
    example: '9123456789',
    displayName: 'India (IN) [+91]',
    displayNameNoCountryCode: 'India (IN)',
    e164Key: '91-IN-0',
  );

  @override
  void initState() {
    super.initState();
    _fadeAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _fadeAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _slideAnimationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _fadeAnimationController.forward();
    _slideAnimationController.forward();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _fadeAnimationController.dispose();
    _slideAnimationController.dispose();
    super.dispose();
  }

  bool get _isValidPhone => _phoneController.text.trim().length >= 8;

  String get _fullPhoneNumber =>
      '+${_selectedCountry.phoneCode}${_phoneController.text.trim()}';

  void _launchPrivacyPolicy() async {
    final uri = Uri.parse('https://savedge.in/privacy-policy.html');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _selectCountry() {
    HapticFeedback.lightImpact();
    showCountryPicker(
      context: context,
      countryListTheme: CountryListThemeData(
        flagSize: 24,
        backgroundColor: const Color(0xFFFAFBFC),
        textStyle: const TextStyle(
          fontSize: 16,
          color: Color(0xFF1F2937),
          fontWeight: FontWeight.w500,
        ),
        bottomSheetHeight: MediaQuery.of(context).size.height * 0.75,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
        inputDecoration: InputDecoration(
          labelText: 'Search countries',
          hintText: 'Type to search...',
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: Color(0xFF6F3FCC),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFFE5E7EB), width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFF6F3FCC), width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
      onSelect: (Country country) {
        HapticFeedback.selectionClick();
        setState(() {
          _selectedCountry = country;
        });
      },
    );
  }

  void _sendOtp() {
    if (!_formKey.currentState!.validate()) return;

    HapticFeedback.mediumImpact();
    FocusScope.of(context).unfocus();
    context.read<OtpAuthCubit>().sendOtp(_fullPhoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocConsumer<OtpAuthCubit, OtpAuthState>(
      listener: (context, state) {
        if (state is OtpAuthCodeSent) {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  OtpVerificationPage(phoneNumber: _fullPhoneNumber),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    return SlideTransition(
                      position: animation.drive(
                        Tween(
                          begin: const Offset(1.0, 0.0),
                          end: Offset.zero,
                        ).chain(CurveTween(curve: Curves.easeInOutCubic)),
                      ),
                      child: child,
                    );
                  },
              transitionDuration: const Duration(milliseconds: 400),
            ),
          );
        } else if (state is OtpAuthError) {
          HapticFeedback.lightImpact();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(
                    Icons.error_outline_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      state.message,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              backgroundColor: const Color(0xFFDC2626),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              margin: const EdgeInsets.all(16),
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is OtpAuthLoading;

        return Scaffold(
          backgroundColor: const Color(0xFFFAFBFC),
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFFAFBFC), Color(0xFFF3F4F6)],
                stops: [0.0, 1.0],
              ),
            ),
            child: SafeArea(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.08,
                        vertical: 24,
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight:
                              screenHeight -
                              MediaQuery.of(context).padding.top -
                              MediaQuery.of(context).padding.bottom -
                              48,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                SizedBox(height: screenHeight * 0.08),

                                // Logo with shadow
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(24),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(
                                          0xFF6F3FCC,
                                        ).withOpacity(0.15),
                                        blurRadius: 32,
                                        offset: const Offset(0, 8),
                                        spreadRadius: 0,
                                      ),
                                    ],
                                  ),
                                  child: Image.asset(
                                    'assets/images/logo_transparant.png',
                                    width: 56,
                                    height: 56,
                                  ),
                                ),

                                SizedBox(height: screenHeight * 0.06),

                                // Welcome Section
                                Column(
                                  children: [
                                    ShaderMask(
                                      shaderCallback: (bounds) =>
                                          const LinearGradient(
                                            colors: [
                                              Color(0xFF6F3FCC),
                                              Color(0xFF8B5FD1),
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ).createShader(bounds),
                                      child: const Text(
                                        'Welcome to Savedge',
                                        style: TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white,
                                          letterSpacing: -1.0,
                                          height: 1.2,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),

                                    const SizedBox(height: 16),

                                    Text(
                                      'Enter your phone number and we\'ll send\nyou a verification code',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: const Color(
                                          0xFF6B7280,
                                        ).withOpacity(0.8),
                                        fontWeight: FontWeight.w400,
                                        height: 1.5,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),

                                SizedBox(height: screenHeight * 0.08),

                                // Phone Input Section
                                Container(
                                  padding: const EdgeInsets.all(24),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(24),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.08),
                                        blurRadius: 32,
                                        offset: const Offset(0, 8),
                                        spreadRadius: -4,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Mobile Number',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF374151),
                                          letterSpacing: 0.2,
                                        ),
                                      ),
                                      const SizedBox(height: 16),

                                      Row(
                                        children: [
                                          // Country Picker
                                          GestureDetector(
                                            onTap: _selectCountry,
                                            child: AnimatedContainer(
                                              duration: const Duration(
                                                milliseconds: 200,
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 16,
                                                    vertical: 18,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFF8FAFC),
                                                border: Border.all(
                                                  color: const Color(
                                                    0xFFE2E8F0,
                                                  ),
                                                  width: 1.5,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    _selectedCountry.flagEmoji,
                                                    style: const TextStyle(
                                                      fontSize: 22,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    '+${_selectedCountry.phoneCode}',
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0xFF1F2937),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 6),
                                                  const Icon(
                                                    Icons
                                                        .keyboard_arrow_down_rounded,
                                                    color: Color(0xFF6B7280),
                                                    size: 18,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                          const SizedBox(width: 12),

                                          // Phone Input
                                          Expanded(
                                            child: TextFormField(
                                              controller: _phoneController,
                                              keyboardType: TextInputType.phone,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF1F2937),
                                              ),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.trim().isEmpty) {
                                                  return 'Please enter your phone number';
                                                }
                                                if (value.trim().length < 8) {
                                                  return 'Please enter a valid phone number';
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                hintText:
                                                    _selectedCountry.example,
                                                hintStyle: const TextStyle(
                                                  color: Color(0xFF9CA3AF),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                filled: true,
                                                fillColor: const Color(
                                                  0xFFF8FAFC,
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  borderSide: const BorderSide(
                                                    color: Color(0xFFE2E8F0),
                                                    width: 1.5,
                                                  ),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            16,
                                                          ),
                                                      borderSide:
                                                          const BorderSide(
                                                            color: Color(
                                                              0xFFE2E8F0,
                                                            ),
                                                            width: 1.5,
                                                          ),
                                                    ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            16,
                                                          ),
                                                      borderSide:
                                                          const BorderSide(
                                                            color: Color(
                                                              0xFF6F3FCC,
                                                            ),
                                                            width: 2.5,
                                                          ),
                                                    ),
                                                errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  borderSide: const BorderSide(
                                                    color: Color(0xFFDC2626),
                                                    width: 1.5,
                                                  ),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            16,
                                                          ),
                                                      borderSide:
                                                          const BorderSide(
                                                            color: Color(
                                                              0xFFDC2626,
                                                            ),
                                                            width: 2.5,
                                                          ),
                                                    ),
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 18,
                                                    ),
                                              ),
                                              onChanged: (_) => setState(() {}),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 32),

                                // Send OTP Button
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  width: double.infinity,
                                  height: 56,
                                  child: ElevatedButton(
                                    onPressed: !_isValidPhone || isLoading
                                        ? null
                                        : _sendOtp,
                                    style:
                                        ElevatedButton.styleFrom(
                                          backgroundColor: const Color(
                                            0xFF6F3FCC,
                                          ),
                                          foregroundColor: Colors.white,
                                          disabledBackgroundColor: const Color(
                                            0xFFE5E7EB,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                          ),
                                          elevation: 0,
                                          shadowColor: Colors.transparent,
                                        ).copyWith(
                                          backgroundColor:
                                              WidgetStateProperty.resolveWith<
                                                Color
                                              >((Set<WidgetState> states) {
                                                if (states.contains(
                                                  WidgetState.disabled,
                                                )) {
                                                  return const Color(
                                                    0xFFE5E7EB,
                                                  );
                                                }
                                                if (states.contains(
                                                  WidgetState.pressed,
                                                )) {
                                                  return const Color(
                                                    0xFF5B2FA3,
                                                  );
                                                }
                                                return const Color(0xFF6F3FCC);
                                              }),
                                        ),
                                    child: isLoading
                                        ? const SizedBox(
                                            width: 24,
                                            height: 24,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 2.5,
                                            ),
                                          )
                                        : const Text(
                                            'Send Verification Code',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              letterSpacing: 0.2,
                                            ),
                                          ),
                                  ),
                                ),
                              ],
                            ),

                            // Privacy Policy Footer
                            Padding(
                              padding: EdgeInsets.only(
                                top: screenHeight * 0.04,
                                bottom: 16,
                              ),
                              child: Text.rich(
                                TextSpan(
                                  text: 'By continuing, you agree to our ',
                                  style: const TextStyle(
                                    color: Color(0xFF9CA3AF),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    height: 1.4,
                                  ),
                                  children: [
                                    WidgetSpan(
                                      child: GestureDetector(
                                        onTap: _launchPrivacyPolicy,
                                        child: const Text(
                                          'Privacy Policy',
                                          style: TextStyle(
                                            color: Color(0xFF6F3FCC),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor: Color(0xFF6F3FCC),
                                            decorationThickness: 1.5,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
