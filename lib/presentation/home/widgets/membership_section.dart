import 'package:flutter/material.dart';

/// Membership section widget for SavEdge club subscription
class MembershipSection extends StatelessWidget {
  const MembershipSection({
    super.key,
    this.title = 'SavEdge Annual Package Subscription',
    this.onJoinTap,
  });

  final String title;
  final VoidCallback? onJoinTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          _MembershipCard(onJoinTap: onJoinTap),
        ],
      ),
    );
  }
}

class _MembershipCard extends StatelessWidget {
  const _MembershipCard({this.onJoinTap});

  final VoidCallback? onJoinTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(flex: 1, child: _MembershipContent()),
            Expanded(flex: 1, child: _MembershipDetails(onJoinTap: onJoinTap)),
          ],
        ),
      ),
    );
  }
}

class _MembershipContent extends StatelessWidget {
  const _MembershipContent();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF6F3FCC), Color(0xFF9C4DFF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Join',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w700,
              height: 1.1,
            ),
          ),
          const Text(
            'The',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w700,
              height: 1.1,
            ),
          ),
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'Sav',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    height: 1.1,
                  ),
                ),
                TextSpan(
                  text: 'Edge',
                  style: TextStyle(
                    color: Color(0xFF4CAF50),
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    height: 1.1,
                  ),
                ),
              ],
            ),
          ),
          const Text(
            'Club',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w700,
              height: 1.1,
            ),
          ),
        ],
      ),
    );
  }
}

class _MembershipDetails extends StatelessWidget {
  const _MembershipDetails({this.onJoinTap});

  final VoidCallback? onJoinTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Yearly\nMembership',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 12),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '₹',
                    style: TextStyle(
                      color: Color(0xFF6F3FCC),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '499',
                    style: TextStyle(
                      color: Color(0xFF6F3FCC),
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                "You'll Get",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              const _BenefitItem(
                'All the Discount Coupons available on SavEdge throughout the year!',
              ),
              const SizedBox(height: 8),
              const _BenefitItem(
                'Pay Only Once a year & get savings with 50,000/- Many more Perks!',
              ),
              const SizedBox(height: 8),
              const _BenefitItem('Many More Perks!'),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onJoinTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6F3FCC),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
                elevation: 0,
              ),
              child: const Text(
                'Subscribe Now',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BenefitItem extends StatelessWidget {
  const _BenefitItem(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 2),
          child: const Icon(
            Icons.check_circle,
            color: Color(0xFF4CAF50),
            size: 18,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
              height: 1.4,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
