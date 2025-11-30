import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:savedge/core/constants/categories_constants.dart';
import 'package:savedge/core/themes/app_theme.dart';
import 'package:savedge/features/coupons/data/models/coupon_gifting_models.dart';
import 'package:savedge/features/coupons/presentation/widgets/coupon_hero_tag.dart';

/// Modern ticket-style coupon card with varied colors and category icons
class CouponCard extends StatelessWidget {
  const CouponCard({
    super.key,
    required this.coupon,
    required this.onTap,
    this.enableHero = true,
  });

  final UserCouponDetailModel coupon;
  final VoidCallback onTap;
  final bool enableHero;

  String get _heroTag => couponHeroTag(
    couponId: coupon.couponId,
    userCouponId: coupon.id,
    source: 'wallet',
  );

  @override
  Widget build(BuildContext context) {
    final content = Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // Main ticket layout
              Row(
                children: [
                  // Left: Discount Stub (30%)
                  _buildDiscountStub(),

                  // Right: Voucher Details (70%)
                  Expanded(child: _buildVoucherPanel()),
                ],
              ),

              // Internal cutouts on the divider
              _buildInternalCutouts(),
            ],
          ),
        ),
      ),
    );

    final wrapped = enableHero ? Hero(tag: _heroTag, child: content) : content;

    return GestureDetector(onTap: onTap, child: wrapped);
  }

  Widget _buildDiscountStub() {
    final couponColor = _getCouponColor();

    return Container(
      width: 100,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          bottomLeft: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Discount value
          Text(
            _getDiscountValue(),
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: couponColor,
              height: 1.0,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 6),
          // "OFF" text
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              _getDiscountLabel(),
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: couponColor,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVoucherPanel() {
    return Container(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Top: Category Icon + Vendor Name & Status
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category icon
              _buildCategoryIcon(),
              const SizedBox(width: 10),
              // Brand name & title
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      coupon.vendorName,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      coupon.title,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppTheme.textTertiary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Status pill
              _buildStatusPill(),
            ],
          ), // Bottom: Validity & Barcode strip
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Validity date
              Row(
                children: [
                  Text(
                    'Valid until: ',
                    style: TextStyle(
                      fontSize: 10,
                      color: AppTheme.textTertiary,
                    ),
                  ),
                  Text(
                    _formatExpiryDate(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: _getExpiryColor(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              // Barcode strip
              _buildBarcodeStrip(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryIcon() {
    final category = _getCategoryFromTitle();
    final iconAsset = _getCategoryIconAsset(category);
    final color = _getCouponColor();

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        width: 36,
        height: 36,
        iconAsset,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          // Fallback to Material Icon if asset not found
          return Icon(Icons.local_offer, size: 18, color: color);
        },
      ),
    );
  }

  Widget _buildStatusPill() {
    final status = coupon.status;
    Color bgColor;
    Color textColor;
    String text;

    if (status == 'Used' || coupon.isUsed) {
      bgColor = AppTheme.warningColor.withValues(alpha: 0.15);
      textColor = AppTheme.warningColor;
      text = 'Used';
    } else if (status == 'Expired' || coupon.isExpired) {
      bgColor = AppTheme.errorColor.withValues(alpha: 0.15);
      textColor = AppTheme.errorColor;
      text = 'Expired';
    } else {
      bgColor = AppTheme.successColor.withValues(alpha: 0.15);
      textColor = AppTheme.successColor;
      text = 'Active';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: textColor, shape: BoxShape.circle),
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBarcodeStrip() {
    final code = coupon.uniqueCode;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FA),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          // Barcode icon
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: AppTheme.borderColor, width: 1),
            ),
            child: const Icon(
              Icons.qr_code_2,
              size: 14,
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(width: 8),
          // Coupon code in monospace
          Expanded(
            child: Text(
              code,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                fontFamily: 'monospace',
                color: AppTheme.textPrimary,
                letterSpacing: 0.5,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 4),
          // Copy/arrow icon
          Icon(Icons.arrow_forward_ios, size: 12, color: AppTheme.textTertiary),
        ],
      ),
    );
  }

  Widget _buildInternalCutouts() {
    return Positioned(
      left: 95,
      top: 0,
      bottom: 0,
      child: SizedBox(width: 10, child: CustomPaint(painter: _CutoutPainter())),
    );
  }

  // Helper methods for color selection based on coupon properties
  Color _getCouponColor() {
    final category = _getCategoryFromTitle();

    switch (category) {
      case 'fastfood':
        return const Color(0xFFFF6B6B); // Red
      case 'dessert':
        return const Color(0xFFFF69B4); // Hot Pink
      case 'cafe':
        return const Color(0xFF8B4513); // Saddle Brown
      case 'food':
        return const Color(0xFFFF5722); // Deep Orange
      case 'shopping':
        return const Color(0xFFAB47BC); // Purple
      case 'spa':
        return const Color(0xFFEC407A); // Pink
      case 'beauty':
        return const Color(0xFFE91E63); // Pink
      case 'fitness':
        return const Color(0xFF26A69A); // Teal
      case 'hotel':
        return const Color(0xFF42A5F5); // Blue
      case 'travel':
        return const Color(0xFF00BCD4); // Cyan
      case 'entertainment':
        return const Color(0xFFFF7043); // Deep Orange
      case 'grocery':
        return const Color(0xFF66BB6A); // Green
      case 'electronics':
        return const Color(0xFF5C6BC0); // Indigo
      default:
        // Use couponId for consistent color variation
        final colors = [
          const Color(0xFF6F3FCC), // Purple
          const Color(0xFF2196F3), // Blue
          const Color(0xFF4CAF50), // Green
          const Color(0xFFFF9800), // Orange
          const Color(0xFFE91E63), // Pink
          const Color(0xFF00BCD4), // Cyan
          const Color(0xFFFF5722), // Deep Orange
          const Color(0xFF9C27B0), // Deep Purple
        ];
        return colors[coupon.couponId % colors.length];
    }
  }

  String _getCategoryFromTitle() {
    // First, try to use the actual vendor category from backend
    if (coupon.vendorCategory.isNotEmpty) {
      return _mapBackendCategoryToFrontend(coupon.vendorCategory);
    }

    // Fallback: infer from title if vendor category is empty
    final titleLower = coupon.title.toLowerCase();

    // Fast food
    if (titleLower.contains('fast food') ||
        titleLower.contains('burger') ||
        titleLower.contains('pizza') ||
        titleLower.contains('fries')) {
      return 'fastfood';
    }
    // Dessert
    if (titleLower.contains('dessert') ||
        titleLower.contains('ice cream') ||
        titleLower.contains('cake') ||
        titleLower.contains('sweet')) {
      return 'dessert';
    }
    // Cafe
    if (titleLower.contains('cafe') ||
        titleLower.contains('coffee') ||
        titleLower.contains('tea')) {
      return 'cafe';
    }
    // Restaurant / Food
    if (titleLower.contains('food') ||
        titleLower.contains('restaurant') ||
        titleLower.contains('dining') ||
        titleLower.contains('meal')) {
      return 'food';
    }
    // Shopping
    if (titleLower.contains('shop') ||
        titleLower.contains('fashion') ||
        titleLower.contains('clothing') ||
        titleLower.contains('store') ||
        titleLower.contains('wear') ||
        titleLower.contains('boutique')) {
      return 'shopping';
    }
    // Spa
    if (titleLower.contains('spa') || titleLower.contains('massage')) {
      return 'spa';
    }
    // Beauty / Salon
    if (titleLower.contains('salon') ||
        titleLower.contains('beauty') ||
        titleLower.contains('hair') ||
        titleLower.contains('cosmetic')) {
      return 'beauty';
    }
    // Fitness
    if (titleLower.contains('gym') ||
        titleLower.contains('fitness') ||
        titleLower.contains('sport') ||
        titleLower.contains('yoga') ||
        titleLower.contains('workout')) {
      return 'fitness';
    }
    // Hotel
    if (titleLower.contains('hotel') ||
        titleLower.contains('resort') ||
        titleLower.contains('stay') ||
        titleLower.contains('booking')) {
      return 'hotel';
    }
    // Travel
    if (titleLower.contains('travel') ||
        titleLower.contains('tour') ||
        titleLower.contains('trip') ||
        titleLower.contains('vacation')) {
      return 'travel';
    }
    // Entertainment
    if (titleLower.contains('movie') ||
        titleLower.contains('cinema') ||
        titleLower.contains('theatre') ||
        titleLower.contains('entertainment') ||
        titleLower.contains('show')) {
      return 'entertainment';
    }
    // Grocery
    if (titleLower.contains('grocery') ||
        titleLower.contains('super') ||
        titleLower.contains('mart') ||
        titleLower.contains('vegetables')) {
      return 'grocery';
    }
    // Electronics
    if (titleLower.contains('electronic') ||
        titleLower.contains('mobile') ||
        titleLower.contains('laptop') ||
        titleLower.contains('gadget') ||
        titleLower.contains('phone')) {
      return 'electronics';
    }

    return 'default';
  }

  /// Maps backend vendor category to frontend internal category names
  String _mapBackendCategoryToFrontend(String backendCategory) {
    final categoryLower = backendCategory.toLowerCase().trim();

    // Map based on CategoriesConstants categories
    if (categoryLower == 'fast food') return 'fastfood';
    if (categoryLower == 'dessert' || categoryLower == 'ice cream')
      return 'dessert';
    if (categoryLower == 'cafe') return 'cafe';
    if (categoryLower == 'restaurant' || categoryLower == 'salads and more')
      return 'food';
    if (categoryLower == 'clothing store' ||
        categoryLower == 'boutique' ||
        categoryLower == 'footwear' ||
        categoryLower == 'innerwear' ||
        categoryLower == 'bag shop' ||
        categoryLower == 'belt and accessories' ||
        categoryLower == 'handloom')
      return 'shopping';
    if (categoryLower == 'spa') return 'spa';
    if (categoryLower == 'salon' ||
        categoryLower == 'skin clinic' ||
        categoryLower == 'cosmetic shop')
      return 'beauty';
    if (categoryLower == 'gym' || categoryLower == 'health and wellness')
      return 'fitness';
    if (categoryLower == 'hotels' || categoryLower == 'resort and gateways')
      return 'hotel';
    if (categoryLower == 'tours and travels') return 'travel';
    if (categoryLower == 'theatre') return 'entertainment';
    if (categoryLower == 'grocery') return 'grocery';
    if (categoryLower == 'mobile shop') return 'electronics';

    // Additional categories
    if (categoryLower == 'opticals') return 'default';
    if (categoryLower == 'photography' || categoryLower == 'designer')
      return 'default';
    if (categoryLower == 'tattoo') return 'spa';
    if (categoryLower == 'jewellers') return 'shopping';
    if (categoryLower == 'stationary' || categoryLower == 'kitchen utensils')
      return 'shopping';
    if (categoryLower == 'indoor games') return 'entertainment';
    if (categoryLower == 'consultancy' || categoryLower == 'financial services')
      return 'default';
    if (categoryLower == 'service centre') return 'default';

    return 'default';
  }

  String _getCategoryIconAsset(String category) {
    // Map our internal category names to CategoriesConstants category names
    switch (category) {
      case 'food':
        return CategoriesConstants.getCategoryIcon('Restaurant');
      case 'fastfood':
        return CategoriesConstants.getCategoryIcon('Fast food');
      case 'dessert':
        return CategoriesConstants.getCategoryIcon('Dessert');
      case 'cafe':
        return CategoriesConstants.getCategoryIcon('Cafe');
      case 'shopping':
        return CategoriesConstants.getCategoryIcon('Clothing store');
      case 'beauty':
        return CategoriesConstants.getCategoryIcon('Salon');
      case 'spa':
        return CategoriesConstants.getCategoryIcon('Spa');
      case 'fitness':
        return CategoriesConstants.getCategoryIcon('Gym');
      case 'travel':
        return CategoriesConstants.getCategoryIcon('Tours and travels');
      case 'hotel':
        return CategoriesConstants.getCategoryIcon('Hotels');
      case 'entertainment':
        return CategoriesConstants.getCategoryIcon('Theatre');
      case 'grocery':
        return CategoriesConstants.getCategoryIcon('Grocery');
      case 'electronics':
        return CategoriesConstants.getCategoryIcon('Mobile shop');
      default:
        return CategoriesConstants.getCategoryIcon('Others');
    }
  }

  String _getDiscountValue() {
    if (coupon.discountType.toLowerCase() == 'percentage') {
      return '${coupon.discountValue.toInt()}%';
    } else {
      return '₹${coupon.discountValue.toInt()}';
    }
  }

  String _getDiscountLabel() {
    return 'OFF';
  }

  String _formatExpiryDate() {
    try {
      final date = coupon.expiryDate;
      return DateFormat('dd MMM yyyy').format(date);
    } catch (e) {
      return coupon.expiryDate.toString();
    }
  }

  Color _getExpiryColor() {
    try {
      final expiry = coupon.expiryDate;
      final daysLeft = expiry.difference(DateTime.now()).inDays;

      if (daysLeft < 0) {
        return AppTheme.errorColor; // Expired
      } else if (daysLeft <= 7) {
        return AppTheme.warningColor; // Expiring soon
      } else {
        return AppTheme.successColor; // Valid
      }
    } catch (e) {
      return AppTheme.textSecondary;
    }
  }
}

/// Custom painter for internal cutouts (semi-circles on divider)
class _CutoutPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color =
          const Color(0xFFF5F5F5) // Match page background
      ..style = PaintingStyle.fill;

    // Top semi-circle cutout
    canvas.drawCircle(Offset(size.width / 2, 0), 8, paint);

    // Bottom semi-circle cutout
    canvas.drawCircle(Offset(size.width / 2, size.height), 8, paint);

    // Dotted line between cutouts
    final linePaint = Paint()
      ..color = const Color(0xFFE0E0E0)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    const dashHeight = 4.0;
    const dashSpace = 4.0;
    double startY = 8; // Start after top cutout

    while (startY < size.height - 8) {
      // End before bottom cutout
      canvas.drawLine(
        Offset(size.width / 2, startY),
        Offset(size.width / 2, startY + dashHeight),
        linePaint,
      );
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
