import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher_string.dart';

class FollowUsPage extends StatelessWidget {
  const FollowUsPage({super.key});

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
          'Follow Us',
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
              _buildHeader(),
              const SizedBox(height: 32),
              const Text(
                'Find us on',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: _dark,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 16),
              _buildSocialTile(
                name: 'Facebook',
                handle: '@SavEdge01',
                description: 'Daily deals & community discussions',
                assetPath: 'assets/icons/social_media_platforms/Facebook.png',
                bgColor: const Color(0xFFEBF4FF),
                accentColor: const Color(0xFF1877F2),
                url: 'https://www.facebook.com/SavEdge01',
              ),
              const SizedBox(height: 12),
              _buildSocialTile(
                name: 'Instagram',
                handle: '@savedge_in',
                description: 'Behind the scenes & visual stories',
                assetPath: 'assets/icons/social_media_platforms/Instagram.png',
                bgColor: const Color(0xFFFDF2F8),
                accentColor: const Color(0xFFE1306C),
                url: 'https://www.instagram.com/savedge_in',
              ),
              const SizedBox(height: 32),
              _buildCta(),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const Text(
          'Join our\ncommunity',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: _dark,
            letterSpacing: -0.5,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Stay in the loop with the latest deals, savings tips, and exclusive offers.',
          style: TextStyle(
            fontSize: 15,
            color: _grey,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialTile({
    required String name,
    required String handle,
    required String description,
    required String assetPath,
    required Color bgColor,
    required Color accentColor,
    required String url,
  }) {
    return GestureDetector(
      onTap: () => launchUrlString(url, mode: LaunchMode.externalApplication),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 48,
                height: 48,
                child: Image.asset(assetPath),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: _dark,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: accentColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          handle,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: accentColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 13,
                      color: _grey,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: accentColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCta() {
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
            '💬',
            style: TextStyle(fontSize: 32),
          ),
          const SizedBox(height: 10),
          const Text(
            'Tag us in your savings!',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Share your SavEdge wins on social media\nand we might feature you!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[400],
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              '#SavEdgeSavings',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
