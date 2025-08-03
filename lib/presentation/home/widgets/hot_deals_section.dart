import 'package:flutter/material.dart';

/// Model class for hot deal items
class HotDeal {
  const HotDeal({
    required this.name,
    required this.rating,
    required this.offer,
    this.imageUrl,
    this.onTap,
  });

  final String name;
  final String rating;
  final String offer;
  final String? imageUrl;
  final VoidCallback? onTap;
}

/// Hot deals section widget with horizontal scrollable cards
class HotDealsSection extends StatelessWidget {
  const HotDealsSection({
    super.key,
    this.title = 'Hot Deals',
    this.deals = const [],
  });

  final String title;
  final List<HotDeal> deals;

  @override
  Widget build(BuildContext context) {
    final defaultDeals = deals.isEmpty ? _getDefaultDeals() : deals;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: defaultDeals.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                    right: index == defaultDeals.length - 1 ? 0 : 12,
                  ),
                  child: HotDealCard(deal: defaultDeals[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<HotDeal> _getDefaultDeals() {
    return [
      const HotDeal(
        name: 'Amrutam Restaurant',
        rating: '4.9',
        offer: 'Up to 50% OFF',
      ),
      const HotDeal(name: 'Amruta', rating: '4.8', offer: 'Up to 30% OFF'),
    ];
  }
}

/// Individual hot deal card widget
class HotDealCard extends StatelessWidget {
  const HotDealCard({super.key, required this.deal, this.width = 280});

  final HotDeal deal;
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: deal.onTap,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // Background image
              _DealBackground(),
              // Gradient overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                    stops: const [0.5, 1.0],
                  ),
                ),
              ),
              // Content
              Positioned(
                left: 16,
                right: 16,
                top: 16,
                bottom: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _OfferBadge(offer: deal.offer),
                    const Spacer(),
                    _DealInfo(deal: deal),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DealBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/restaurant_bg.jpg'),
          fit: BoxFit.cover,
          onError: null,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.brown[300]!.withOpacity(0.8),
              Colors.brown[600]!.withOpacity(0.8),
            ],
          ),
        ),
      ),
    );
  }
}

class _OfferBadge extends StatelessWidget {
  const _OfferBadge({required this.offer});

  final String offer;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF6F3FCC),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.local_offer, color: Colors.white, size: 14),
          const SizedBox(width: 4),
          Text(
            offer,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _DealInfo extends StatelessWidget {
  const _DealInfo({required this.deal});

  final HotDeal deal;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          deal.name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    deal.rating,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
