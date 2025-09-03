import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get_it/get_it.dart';
import 'package:savedge/core/injection/injection.dart';
import 'package:savedge/features/coupons/data/services/coupon_service.dart';
import 'package:savedge/features/coupons/presentation/pages/coupon_redemption_options_page.dart';
import 'package:savedge/features/vendors/domain/entities/coupon.dart';
import 'package:savedge/features/vendors/presentation/bloc/coupons_bloc.dart';

// Shared UI builders (top-level) so both views can reuse them
Widget _buildLoadingState() {
  return Container(
    height: 200,
    margin: const EdgeInsets.symmetric(horizontal: 24),
    child: const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: Color(0xFF6F3FCC), strokeWidth: 3),
          SizedBox(height: 16),
          Text(
            'Loading offers...',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildErrorWidget(String message) {
  return Container(
    height: 200,
    margin: const EdgeInsets.symmetric(horizontal: 24),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFFEF4444).withOpacity(0.1),
              borderRadius: BorderRadius.circular(40),
              border: Border.all(
                color: const Color(0xFFEF4444).withOpacity(0.2),
                width: 2,
              ),
            ),
            child: Icon(
              Icons.error_outline,
              size: 36,
              color: const Color(0xFFEF4444).withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Failed to load offers',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A202C),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: const TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}

Widget _buildEmptyState() {
  return Container(
    height: 200,
    margin: const EdgeInsets.symmetric(horizontal: 24),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFF6F3FCC).withOpacity(0.1),
              borderRadius: BorderRadius.circular(40),
              border: Border.all(
                color: const Color(0xFF6F3FCC).withOpacity(0.2),
                width: 2,
              ),
            ),
            child: Icon(
              Icons.local_offer_outlined,
              size: 36,
              color: const Color(0xFF6F3FCC).withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'No offers available',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A202C),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Check back later for amazing deals!',
            style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
          ),
        ],
      ),
    ),
  );
}

Widget _buildCouponsList(List<Coupon> coupons, String vendorUid, String vendorName) {
  if (coupons.isEmpty) {
    return _buildEmptyState();
  }

  return AnimationLimiter(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: coupons.asMap().entries.map((entry) {
          final index = entry.key;
          final coupon = entry.value;
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 600),
            child: SlideAnimation(
              verticalOffset: 30.0,
              child: FadeInAnimation(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: VendorOfferCard(
                    coupon: coupon,
                    vendorUid: vendorUid,
                    vendorName: vendorName,
                    index: index,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    ),
  );
}

/// Beautiful vendor offers section with animations
class VendorOffersSection extends StatelessWidget {
  const VendorOffersSection({
    super.key,
    required this.vendorId,
    required this.vendorUid,
    required this.vendorName,
    this.coupons,
    this.title = 'Special Offers',
  });

  final int vendorId;
  final String vendorUid;
  final String vendorName;
  final List<Coupon>? coupons;
  final String title;

  @override
  Widget build(BuildContext context) {
    // If coupons are provided with the vendor, render directly.
    if (coupons != null) {
      return VendorOffersView(
        title: title,
        vendorUid: vendorUid,
        vendorName: vendorName,
        coupons: coupons!,
      );
    }

    // Fallback to loading via bloc
    return BlocProvider(
      create: (context) =>
          getIt<CouponsBloc>()..add(LoadVendorCoupons(vendorId: vendorId)),
      child: VendorOffersBlocView(
        title: title,
        vendorUid: vendorUid,
        vendorName: vendorName,
      ),
    );
  }
}

class VendorOffersBlocView extends StatelessWidget {
  const VendorOffersBlocView({
    super.key,
    required this.title,
    required this.vendorUid,
    required this.vendorName,
  });

  final String title;
  final String vendorUid;
  final String vendorName;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6F3FCC).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.local_offer,
                    color: Color(0xFF6F3FCC),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A202C),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          BlocBuilder<CouponsBloc, CouponsState>(
            builder: (context, state) {
              if (state is CouponsLoading) {
                return _buildLoadingState();
              } else if (state is CouponsError) {
                return _buildErrorWidget(state.message);
              } else if (state is CouponsLoaded) {
                return _buildCouponsList(state.coupons, vendorUid, vendorName);
              }
              return _buildEmptyState();
            },
          ),
        ],
      ),
    );
  }
}

class VendorOffersView extends StatelessWidget {
  const VendorOffersView({
    super.key,
    required this.title,
    required this.vendorUid,
    required this.vendorName,
    required this.coupons,
  });

  final String title;
  final String vendorUid;
  final String vendorName;
  final List<Coupon> coupons;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6F3FCC).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.local_offer,
                    color: Color(0xFF6F3FCC),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A202C),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          coupons.isNotEmpty
              ? _buildCouponsList(coupons, vendorUid, vendorName)
              : _buildEmptyState(),
        ],
      ),
    );
  }
}

/// Modern, beautiful vendor offer card with enhanced animations
class VendorOfferCard extends StatefulWidget {
  const VendorOfferCard({
    super.key,
    required this.coupon,
    required this.vendorUid,
    required this.vendorName,
    this.index = 0,
  });

  final Coupon coupon;
  final String vendorUid;
  final String vendorName;
  final int index;

  @override
  State<VendorOfferCard> createState() => _VendorOfferCardState();
}

class _VendorOfferCardState extends State<VendorOfferCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gradient = _getCouponGradient();
    final primaryColor = _getPrimaryColor();

    return GestureDetector(
      onTapDown: (_) {
        setState(() => _isPressed = true);
        _animationController.forward();
        HapticFeedback.lightImpact();
      },
      onTapUp: (_) {
        setState(() => _isPressed = false);
        _animationController.reverse();
        _onCouponTap(context);
      },
      onTapCancel: () {
        setState(() => _isPressed = false);
        _animationController.reverse();
      },
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) => Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                // Animated background pattern
                Positioned.fill(
                  child: CustomPaint(
                    painter: CouponPatternPainter(
                      color: Colors.white.withOpacity(0.1),
                      index: widget.index,
                    ),
                  ),
                ),

                // Main content
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Offer badge
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.25),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: const Text(
                                'EXCLUSIVE OFFER',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.8,
                                ),
                              ),
                            ),

                            const SizedBox(height: 8),

                            // Discount display
                            Text(
                              'Save ${widget.coupon.discountDisplay}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                height: 1.1,
                                shadows: [
                                  Shadow(
                                    color: Colors.black26,
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 4),

                            // Title or minimum amount
                            Text(
                              widget.coupon.minimumAmountDisplay.isNotEmpty
                                  ? widget.coupon.minimumAmountDisplay
                                  : widget.coupon.title,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                height: 1.2,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),

                            const SizedBox(height: 8),

                            // Price info
                            Row(
                              children: [
                                if (widget.coupon.cashPrice != null &&
                                    widget.coupon.cashPrice! > 0) ...[
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 3,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      '₹${widget.coupon.cashPrice!.toInt()}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                ],
                                Text(
                                  widget.coupon.cashPrice != null &&
                                          widget.coupon.cashPrice! > 0
                                      ? 'or Free with subscription'
                                      : 'Free for subscribers',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.8),
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 16),

                      // Action button
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.redeem, color: primaryColor, size: 18),
                            const SizedBox(width: 6),
                            Text(
                              widget.coupon.cashPrice != null &&
                                      widget.coupon.cashPrice! > 0
                                  ? 'Buy'
                                  : 'Claim',
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
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
          ),
        ),
      ),
    );
  }

  LinearGradient _getCouponGradient() {
    // Enhanced gradient collection with more beautiful combinations
    final gradients = [
      const LinearGradient(
        colors: [Color(0xFF6F3FCC), Color(0xFF9F7AEA)], // Purple
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      const LinearGradient(
        colors: [Color(0xFF38B2AC), Color(0xFF4FD1C7)], // Teal
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      const LinearGradient(
        colors: [Color(0xFFED8936), Color(0xFFF56500)], // Orange
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      const LinearGradient(
        colors: [Color(0xFF3182CE), Color(0xFF63B3ED)], // Blue
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      const LinearGradient(
        colors: [Color(0xFF38A169), Color(0xFF68D391)], // Green
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      const LinearGradient(
        colors: [Color(0xFFE53E3E), Color(0xFFF56565)], // Red
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ];

    return gradients[(widget.coupon.id + widget.index) % gradients.length];
  }

  Color _getPrimaryColor() {
    final colors = [
      const Color(0xFF6F3FCC), // Purple
      const Color(0xFF38B2AC), // Teal
      const Color(0xFFED8936), // Orange
      const Color(0xFF3182CE), // Blue
      const Color(0xFF38A169), // Green
      const Color(0xFFE53E3E), // Red
    ];

    return colors[(widget.coupon.id + widget.index) % colors.length];
  }

  void _onCouponTap(BuildContext context) async {
    try {
      // Show loading indicator with haptic feedback
      HapticFeedback.lightImpact();

      // First, check the coupon to get its details
      final couponService = GetIt.I<CouponService>();
      final couponCheck = await couponService.checkCoupon(widget.coupon.id);

      // Navigate to coupon redemption options page
      final result = await Navigator.of(context).push<bool>(
        MaterialPageRoute(
          builder: (context) =>
              CouponRedemptionOptionsPage(couponData: couponCheck),
        ),
      );

      // Show enhanced result feedback
      if (!mounted) return;

      if (result == true) {
        // Success - show modern snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Color(0xFF4CAF50),
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Coupon Claimed! 🎉',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          widget.coupon.title,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 13,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            backgroundColor: const Color(0xFF4CAF50),
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            duration: const Duration(seconds: 4),
          ),
        );
      } else if (result == false) {
        // Failed - show error with retry option
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.error_outline,
                      color: Color(0xFFE53E3E),
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Couldn\'t claim coupon. Please try again.',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            backgroundColor: const Color(0xFFE53E3E),
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            duration: const Duration(seconds: 4),
            action: SnackBarAction(
              label: 'RETRY',
              textColor: Colors.white,
              onPressed: () => _onCouponTap(context),
            ),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: const Color(0xFFE53E3E),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }
  }
}

/// Custom painter for beautiful coupon background patterns
class CouponPatternPainter extends CustomPainter {
  final Color color;
  final int index;

  CouponPatternPainter({required this.color, required this.index});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    switch (index % 3) {
      case 0:
        // Circular dots pattern
        for (double x = 0; x < size.width; x += 40) {
          for (double y = 0; y < size.height; y += 40) {
            canvas.drawCircle(Offset(x, y), 3, paint);
          }
        }
        break;
      case 1:
        // Diagonal lines pattern
        paint.style = PaintingStyle.stroke;
        paint.strokeWidth = 1;
        for (double i = -size.height; i < size.width; i += 20) {
          canvas.drawLine(
            Offset(i, 0),
            Offset(i + size.height, size.height),
            paint,
          );
        }
        break;
      case 2:
        // Grid pattern
        paint.style = PaintingStyle.stroke;
        paint.strokeWidth = 0.5;
        for (double x = 0; x < size.width; x += 30) {
          canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
        }
        for (double y = 0; y < size.height; y += 30) {
          canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
        }
        break;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
