import 'package:flutter/material.dart';

/// Model class for marketplace items
class MarketplaceItem {
  const MarketplaceItem({
    required this.name,
    required this.brand,
    required this.price,
    this.originalPrice,
    this.imageUrl,
    this.brandLogo,
    this.onTap,
  });

  final String name;
  final String brand;
  final String price;
  final String? originalPrice;
  final String? imageUrl;
  final String? brandLogo;
  final VoidCallback? onTap;
}

/// Marketplace section widget displaying featured products/services
class MarketplaceSection extends StatelessWidget {
  const MarketplaceSection({
    super.key,
    this.title = 'Shop from Marketplaces',
    this.items = const [],
    this.onSeeAllTap,
  });

  final String title;
  final List<MarketplaceItem> items;
  final VoidCallback? onSeeAllTap;

  @override
  Widget build(BuildContext context) {
    final defaultItems = items.isEmpty ? _getDefaultItems() : items;

    return Padding(
      padding: const EdgeInsets.all(16.0),
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
          _MarketplaceGrid(items: defaultItems),
        ],
      ),
    );
  }

  List<MarketplaceItem> _getDefaultItems() {
    return [
      const MarketplaceItem(
        name: 'iPhone 16 Pro Max',
        brand: 'amazon',
        price: '₹50,000',
      ),
      const MarketplaceItem(
        name: 'Apple Watch Series 9',
        brand: 'apple',
        price: '₹1,50,000',
      ),
      const MarketplaceItem(
        name: 'Samsung Galaxy S24',
        brand: 'samsung',
        price: '₹50,000',
      ),
      const MarketplaceItem(
        name: 'iPhone 16 Pro Max',
        brand: 'amazon',
        price: '₹50,000',
      ),
    ];
  }
}

class _MarketplaceGrid extends StatelessWidget {
  const _MarketplaceGrid({required this.items});

  final List<MarketplaceItem> items;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 12,
        mainAxisSpacing: 16,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return MarketplaceItemCard(item: items[index]);
      },
    );
  }
}

/// Individual marketplace item card widget
class MarketplaceItemCard extends StatelessWidget {
  const MarketplaceItemCard({super.key, required this.item});

  final MarketplaceItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ItemImage(item: item),
          Expanded(child: _ItemDetails(item: item)),
        ],
      ),
    );
  }
}

class _ItemImage extends StatelessWidget {
  const _ItemImage({required this.item});

  final MarketplaceItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        color: Colors.grey[100],
      ),
      child: Stack(
        children: [
          // Product image placeholder
          Center(
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(_getProductIcon(), size: 40, color: Colors.grey[600]),
            ),
          ),
          // Brand logo
          Positioned(top: 8, left: 8, child: _BrandLogo(brand: item.brand)),
        ],
      ),
    );
  }

  IconData _getProductIcon() {
    if (item.name.toLowerCase().contains('iphone')) {
      return Icons.phone_iphone;
    } else if (item.name.toLowerCase().contains('watch')) {
      return Icons.watch;
    } else if (item.name.toLowerCase().contains('samsung')) {
      return Icons.phone_android;
    }
    return Icons.devices;
  }
}

class _BrandLogo extends StatelessWidget {
  const _BrandLogo({required this.brand});

  final String brand;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Text(
        brand.toLowerCase(),
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }
}

class _ItemDetails extends StatelessWidget {
  const _ItemDetails({required this.item});

  final MarketplaceItem item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.name,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            item.price,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: item.onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6F3FCC),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 8),
                elevation: 0,
              ),
              child: const Text(
                'Get Deal',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
