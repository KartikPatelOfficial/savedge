import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  static const _purple = Color(0xFF6F3FCC);
  static const _lightPurple = Color(0xFFEDE9FE);
  static const _dark = Color(0xFF1A202C);
  static const _grey = Color(0xFF718096);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _dark,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
              size: 16,
            ),
          ),
        ),
        title: const Text(
          'About Us',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: _dark,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              _buildBrandHeader(),
              const SizedBox(height: 36),
              _buildMission(),
              const SizedBox(height: 36),
              _buildValues(),
              const SizedBox(height: 36),
              _buildWhatWeDo(),
              const SizedBox(height: 36),
              _buildTeamBanner(),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBrandHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          'assets/images/logo.png',
          width: 56,
          height: 56,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 16),
        const Text(
          'We connect you with the best deals and exclusive offers from your favorite local brands. Save smarter, live better.',
          style: TextStyle(
            fontSize: 15,
            color: _grey,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildMission() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionLabel(text: 'Our Mission'),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFFF0FDF4),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('🎯', style: TextStyle(fontSize: 28)),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  'To democratize savings and make smart shopping accessible to everyone, everywhere.',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.green[800],
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildValues() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionLabel(text: 'What We Believe In'),
        const SizedBox(height: 16),
        _buildValueRow(
          'Customer First',
          'Your savings and satisfaction come before everything.',
        ),
        const SizedBox(height: 12),
        _buildValueRow(
          'Transparency',
          'Clear, honest deals. No hidden conditions, ever.',
        ),
        const SizedBox(height: 12),
        _buildValueRow(
          'Innovation',
          'Always improving to bring you better ways to save.',
        ),
        const SizedBox(height: 12),
        _buildValueRow(
          'Community',
          'Building a network of smart savers and great businesses.',
        ),
      ],
    );
  }

  Widget _buildValueRow(String title, String desc) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F8),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: _dark,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  desc,
                  style: const TextStyle(
                    fontSize: 13,
                    color: _grey,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWhatWeDo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionLabel(text: 'How It Works'),
        const SizedBox(height: 16),
        _buildStep('1', 'Browse Vendors', 'Discover local businesses near you with amazing offers.'),
        _buildStepConnector(),
        _buildStep('2', 'Grab Coupons', 'Pick the deals that fit your lifestyle and budget.'),
        _buildStepConnector(),
        _buildStep('3', 'Save Money', 'Show your coupon at checkout and enjoy instant savings.'),
      ],
    );
  }

  Widget _buildStep(String number, String title, String desc) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: _purple,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: _dark,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                desc,
                style: const TextStyle(
                  fontSize: 13,
                  color: _grey,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStepConnector() {
    return Padding(
      padding: const EdgeInsets.only(left: 17),
      child: Container(
        width: 2,
        height: 24,
        color: _lightPurple,
      ),
    );
  }

  Widget _buildTeamBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: _dark,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Text(
            '🚀',
            style: TextStyle(fontSize: 36),
          ),
          const SizedBox(height: 12),
          const Text(
            'Built by a passionate team',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'We\'re a small team on a big mission — helping you keep more money in your pocket.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[400],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w800,
        color: Color(0xFF1A202C),
        letterSpacing: -0.3,
      ),
    );
  }
}
