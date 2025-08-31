import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../data/models/coupon_gifting_models.dart';
import '../pages/coupon_confirmation_page.dart';

class ModernCouponCard extends StatefulWidget {
  const ModernCouponCard({super.key, required this.coupon, this.onTap});

  final UserCouponDetailModel coupon;
  final VoidCallback? onTap;

  @override
  State<ModernCouponCard> createState() => _ModernCouponCardState();
}

class _ModernCouponCardState extends State<ModernCouponCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

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
    final isActive = _isActiveStatus();
    final theme = _getCardTheme();

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: isActive
                      ? theme['primary']!.withOpacity(0.15)
                      : Colors.black.withOpacity(0.08),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTapDown: (_) => _animationController.forward(),
                onTapUp: (_) => _animationController.reverse(),
                onTapCancel: () => _animationController.reverse(),
                onTap: () {
                  HapticFeedback.lightImpact();
                  if (widget.onTap != null) {
                    widget.onTap!();
                  } else {
                    _handleTap(context);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: isActive
                          ? [Colors.white, theme['primary']!.withOpacity(0.02)]
                          : [Colors.grey[50]!, Colors.grey[100]!],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isActive
                          ? theme['primary']!.withOpacity(0.3)
                          : Colors.grey.withOpacity(0.2),
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      // Left section - Discount with modern design
                      _buildModernDiscountSection(theme, isActive),

                      // Vertical divider
                      Container(
                        width: 2,
                        height: 80,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.grey.withOpacity(0.3),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),

                      // Right section - Details with enhanced layout
                      Expanded(
                        child: _buildModernDetailsSection(isActive, theme),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildModernDiscountSection(Map<String, Color> theme, bool isActive) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Discount value with modern styling
          Text(
            widget.coupon.discountDisplay,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          Text(
            'OFF',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 6),
          // Status indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              _getStatusDisplay(),
              style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernDetailsSection(bool isActive, Map<String, Color> theme) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title and vendor with enhanced styling
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Source tag (Purchased / Membership / Gifted)
                _buildSourceTag(),
                const SizedBox(height: 6),
                Text(
                  widget.coupon.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: isActive
                        ? const Color(0xFF1A202C)
                        : Colors.grey[600],
                    letterSpacing: -0.2,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.store_outlined,
                      size: 14,
                      color: isActive ? theme['primary'] : Colors.grey[500],
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        widget.coupon.vendorName,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: isActive ? theme['primary'] : Colors.grey[500],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Bottom section with expiry and ID
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Expiry date with icon
              Row(
                children: [
                  Icon(Icons.schedule, size: 14, color: _getExpiryColor()),
                  const SizedBox(width: 4),
                  Text(
                    _getExpiryDisplay(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: _getExpiryColor(),
                    ),
                  ),
                ],
              ),

              // Action button or status
              _buildActionButton(isActive, theme),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSourceTag() {
    // Determine tag text and colors
    String? text;
    Color bg = const Color(0xFFE5E7EB); // default gray-200
    Color fg = const Color(0xFF374151); // gray-700

    if (widget.coupon.isGifted) {
      text = 'Gifted';
      bg = const Color(0xFFEDE9FE); // violet-100
      fg = const Color(0xFF6D28D9); // violet-700
    } else if (widget.coupon.source == 'Subscription') {
      text = 'Membership';
      bg = const Color(0xFFEFF6FF); // blue-100
      fg = const Color(0xFF2563EB); // blue-600
    } else if (widget.coupon.source == 'Purchased') {
      text = 'Purchased';
      bg = const Color(0xFFECFDF5); // emerald-50
      fg = const Color(0xFF059669); // emerald-600
    }

    if (text == null) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: fg,
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  Widget _buildActionButton(bool isActive, Map<String, Color> theme) {
    if (!isActive) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          _getStatusDisplay().toUpperCase(),
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: Colors.grey[600],
            letterSpacing: 0.5,
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [theme['primary']!, theme['primary']!.withOpacity(0.8)],
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: theme['primary']!.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Text(
        'USE NOW',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  bool _isActiveStatus() {
    return widget.coupon.isActive;
  }

  String _getStatusDisplay() {
    return widget.coupon.statusDisplay.toUpperCase();
  }

  void _handleTap(BuildContext context) {
    if (widget.coupon.isActive) {
      // Navigate to coupon confirmation/redemption page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CouponConfirmationPage(
            userCoupon: widget.coupon,
            confirmationType: CouponConfirmationType.use,
          ),
        ),
      );
    } else {
      // Show a message for inactive coupons
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'This coupon is ${widget.coupon.statusDisplay.toLowerCase()}',
          ),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  Color _getExpiryColor() {
    final now = DateTime.now();
    final expiry = widget.coupon.expiryDate;
    final daysUntilExpiry = expiry.difference(now).inDays;

    if (now.isAfter(expiry)) {
      return const Color(0xFFEF4444); // Red for expired
    } else if (daysUntilExpiry <= 3) {
      return const Color(0xFFF59E0B); // Orange for expiring soon
    } else {
      return const Color(0xFF6B7280); // Gray for normal
    }
  }

  String _getExpiryDisplay() {
    final now = DateTime.now();
    final expiry = widget.coupon.expiryDate;

    if (now.isAfter(expiry)) {
      return 'Expired';
    }

    final daysUntilExpiry = expiry.difference(now).inDays;

    if (daysUntilExpiry == 0) {
      return 'Expires today';
    } else if (daysUntilExpiry == 1) {
      return 'Expires tomorrow';
    } else if (daysUntilExpiry <= 7) {
      return 'Expires in $daysUntilExpiry days';
    } else {
      return 'Expires ${_formatDate(expiry)}';
    }
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${date.day} ${months[date.month - 1]}';
  }

  Map<String, Color> _getCardTheme() {
    if (widget.coupon.isExpired) {
      return {
        'primary': const Color(0xFFEF4444),
        'background': const Color(0xFFFEF2F2),
      };
    }

    if (widget.coupon.isUsed) {
      return {
        'primary': const Color(0xFF6366F1),
        'background': const Color(0xFFF8FAFC),
      };
    }

    if (widget.coupon.isActive) {
      return {
        'primary': const Color(0xFF6F3FCC),
        'background': const Color(0xFFF3F4F6),
      };
    }

    // Default for other statuses
    return {
      'primary': const Color(0xFF6B7280),
      'background': const Color(0xFFF9FAFB),
    };
  }
}
