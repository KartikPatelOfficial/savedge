import 'package:flutter/material.dart';

/// Model class for special offers
class SpecialOffer {
  const SpecialOffer({
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.color,
    required this.icon,
    this.imageUrl,
    this.onTap,
  });

  final String title;
  final String subtitle;
  final String buttonText;
  final Color color;
  final IconData icon;
  final String? imageUrl;
  final VoidCallback? onTap;
}

/// Special offers section widget with horizontal scrollable cards
class SpecialOffersSection extends StatelessWidget {
  const SpecialOffersSection({super.key, this.offers = const []});

  final List<SpecialOffer> offers;

  @override
  Widget build(BuildContext context) {
    final defaultOffers = offers.isEmpty ? _getDefaultOffers() : offers;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      height: 200,
      child: PageView.builder(
        padEnds: false,
        itemCount: defaultOffers.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? 16 : 8,
              right: index == defaultOffers.length - 1 ? 16 : 8,
            ),
            child: SpecialOfferCard(offer: defaultOffers[index]),
          );
        },
      ),
    );
  }

  List<SpecialOffer> _getDefaultOffers() {
    return [
      const SpecialOffer(
        title: 'Special Offer for July',
        subtitle: 'We are here with the best deserts in town!',
        buttonText: 'Order Now',
        color: Color(0xFFFF6B7A),
        icon: Icons.local_offer,
      ),
      const SpecialOffer(
        title: 'Summer Special',
        subtitle: 'Cool drinks and refreshing treats!',
        buttonText: 'Order Now',
        color: Color(0xFF4CAF50),
        icon: Icons.local_drink,
      ),
    ];
  }
}

/// Individual special offer card widget
class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({super.key, required this.offer});

  final SpecialOffer offer;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: offer.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: offer.color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            // Background pattern/decoration
            Positioned(
              right: -20,
              top: -20,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              right: 40,
              bottom: -30,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(flex: 3, child: _OfferContent(offer: offer)),
                  Expanded(flex: 2, child: _OfferImage(offer: offer)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OfferContent extends StatelessWidget {
  const _OfferContent({required this.offer});

  final SpecialOffer offer;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          offer.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          offer.subtitle,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            offer.buttonText,
            style: TextStyle(
              color: offer.color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _OfferImage extends StatelessWidget {
  const _OfferImage({required this.offer});

  final SpecialOffer offer;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: offer.imageUrl != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                offer.imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    _PlaceholderImage(),
              ),
            )
          : _PlaceholderImage(),
    );
  }
}

class _PlaceholderImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: Icon(Icons.fastfood, size: 40, color: Colors.white),
      ),
    );
  }
}
