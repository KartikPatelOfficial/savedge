import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:savedge/features/coupons/data/models/coupon_gifting_models.dart';

/// A CRED-style wallet stacked card that shows multiple similar coupons
class StackedCouponCard extends StatefulWidget {
  const StackedCouponCard({
    super.key,
    required this.coupons,
    required this.onTap,
    required this.index,
  });

  final List<UserCouponDetailModel> coupons;
  final Function(UserCouponDetailModel) onTap;
  final int index;

  @override
  State<StackedCouponCard> createState() => _StackedCouponCardState();
}

class _StackedCouponCardState extends State<StackedCouponCard>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _expandController;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _expandController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _expandController,
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void dispose() {
    _expandController.dispose();
    super.dispose();
  }

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _expandController.forward();
      } else {
        _expandController.reverse();
      }
    });
    HapticFeedback.mediumImpact();
  }

  @override
  Widget build(BuildContext context) {
    final firstCoupon = widget.coupons.first;
    final count = widget.coupons.length;

    // Define colors based on coupon status
    Color primaryColor;
    Color backgroundColor;
    Color textColor;
    IconData statusIcon;

    if (firstCoupon.isActive) {
      primaryColor = const Color(0xFF10B981);
      backgroundColor = const Color(0xFF10B981).withOpacity(0.05);
      textColor = const Color(0xFF10B981);
      statusIcon = Icons.check_circle;
    } else if (firstCoupon.isUsed) {
      primaryColor = const Color(0xFF6366F1);
      backgroundColor = const Color(0xFF6366F1).withOpacity(0.05);
      textColor = const Color(0xFF6366F1);
      statusIcon = Icons.history;
    } else {
      primaryColor = const Color(0xFFEF4444);
      backgroundColor = const Color(0xFFEF4444).withOpacity(0.05);
      textColor = const Color(0xFFEF4444);
      statusIcon = Icons.schedule;
    }

    // Generate gradient colors based on index
    final gradients = [
      [const Color(0xFF6F3FCC), const Color(0xFF9F7AEA)],
      [const Color(0xFF38B2AC), const Color(0xFF4FD1C7)],
      [const Color(0xFFED8936), const Color(0xFFF56500)],
      [const Color(0xFF3182CE), const Color(0xFF63B3ED)],
      [const Color(0xFF38A169), const Color(0xFF68D391)],
      [const Color(0xFFE53E3E), const Color(0xFFF56565)],
    ];

    final gradientColors = gradients[widget.index % gradients.length];

    if (count == 1) {
      // Single coupon - no stacking needed
      return _buildCouponCard(
        firstCoupon,
        gradientColors,
        primaryColor,
        backgroundColor,
        textColor,
        statusIcon,
        1,
        false,
      );
    }

    return Column(
      children: [
        if (!_isExpanded)
          // Stacked view - CRED style
          _buildStackedView(
            gradientColors,
            primaryColor,
            backgroundColor,
            textColor,
            statusIcon,
            count,
          )
        else
          // Expanded view - show all cards
          _buildExpandedView(
            gradientColors,
            primaryColor,
            backgroundColor,
            textColor,
            statusIcon,
          ),
      ],
    );
  }

  Widget _buildStackedView(
    List<Color> gradientColors,
    Color primaryColor,
    Color backgroundColor,
    Color textColor,
    IconData statusIcon,
    int count,
  ) {
    final cardsToShow = count > 3 ? 3 : count;

    return GestureDetector(
      onTap: _toggleExpand,
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Background cards (stacked behind)
            for (int i = cardsToShow - 1; i > 0; i--)
              Positioned(
                top: -(i * 20.0),
                left: i * 12.0,
                right: i * 12.0,
                child: Transform.scale(
                  scale: 1 - (i * 0.03),
                  child: Opacity(
                    opacity: 0.5 + (i * 0.1),
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            gradientColors[0].withOpacity(0.9 - (i * 0.15)),
                            gradientColors[1].withOpacity(0.8 - (i * 0.15)),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 20,
                            offset: Offset(0, 8 + (i * 2.0)),
                            spreadRadius: -5,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

            // Front card
            _buildCouponCard(
              widget.coupons.first,
              gradientColors,
              primaryColor,
              backgroundColor,
              textColor,
              statusIcon,
              count,
              true,
            ),

            // Tap to expand indicator
            Positioned(
              bottom: 12,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.unfold_more,
                        size: 16,
                        color: gradientColors[0],
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Tap to expand $count coupons',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: gradientColors[0],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandedView(
    List<Color> gradientColors,
    Color primaryColor,
    Color backgroundColor,
    Color textColor,
    IconData statusIcon,
  ) {
    return Column(
      children: [
        // Collapse button
        GestureDetector(
          onTap: _toggleExpand,
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradientColors,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: gradientColors[0].withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.unfold_less,
                  size: 18,
                  color: Colors.white,
                ),
                const SizedBox(width: 8),
                Text(
                  'Collapse ${widget.coupons.length} coupons',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),

        // All coupons
        ...widget.coupons.asMap().entries.map((entry) {
          final index = entry.key;
          final coupon = entry.value;

          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: FadeTransition(
              opacity: _expandAnimation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, -0.3),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: _expandController,
                  curve: Interval(
                    index * 0.1,
                    0.5 + (index * 0.1),
                    curve: Curves.easeOutCubic,
                  ),
                )),
                child: _buildCouponCard(
                  coupon,
                  gradientColors,
                  primaryColor,
                  backgroundColor,
                  textColor,
                  statusIcon,
                  1,
                  false,
                ),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildCouponCard(
    UserCouponDetailModel coupon,
    List<Color> gradientColors,
    Color primaryColor,
    Color backgroundColor,
    Color textColor,
    IconData statusIcon,
    int displayCount,
    bool showStack,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => widget.onTap(coupon),
        borderRadius: BorderRadius.circular(20),
        child: Opacity(
          opacity: coupon.isUsed ? 0.7 : 1.0,
          child: ColorFiltered(
            colorFilter: coupon.isUsed
                ? const ColorFilter.matrix(<double>[
                    0.2126, 0.7152, 0.0722, 0, 0,
                    0.2126, 0.7152, 0.0722, 0, 0,
                    0.2126, 0.7152, 0.0722, 0, 0,
                    0, 0, 0, 1, 0,
                  ])
                : const ColorFilter.matrix(<double>[
                    1, 0, 0, 0, 0,
                    0, 1, 0, 0, 0,
                    0, 0, 1, 0, 0,
                    0, 0, 0, 1, 0,
                  ]),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 24,
                    offset: const Offset(0, 10),
                    spreadRadius: -5,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: coupon.isUsed
                          ? [Colors.grey.shade300, Colors.grey.shade400]
                          : gradientColors,
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Background pattern
                      Positioned(
                        right: -40,
                        top: -40,
                        child: Container(
                          width: 180,
                          height: 180,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.1),
                          ),
                        ),
                      ),

                      // Content
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header row
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        coupon.vendorName,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        coupon.title,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white.withOpacity(0.9),
                                          fontWeight: FontWeight.w500,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),

                                // Count badge or status
                                if (displayCount > 1 && showStack)
                                  Container(
                                    margin: const EdgeInsets.only(left: 12),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.25),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.3),
                                        width: 1.5,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.layers,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          '×$displayCount',
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                else if (!showStack)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: coupon.isActive
                                          ? Colors.white.withOpacity(0.25)
                                          : Colors.white.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          statusIcon,
                                          size: 14,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          coupon.statusDisplay,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),

                            const SizedBox(height: 24),

                            // Discount value
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.3),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Text(
                                    coupon.discountDisplay,
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                      decoration: coupon.isUsed
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                    ),
                                  ),
                                ),

                                const Spacer(),

                                // Expiry info
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Valid until',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.white.withOpacity(0.8),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      _formatDate(coupon.expiryDate),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            const SizedBox(height: 24),

                            // Bottom row
                            Row(
                              children: [
                                // Coupon code
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.3),
                                        width: 1,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.qr_code_rounded,
                                          size: 18,
                                          color: Colors.white.withOpacity(0.9),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            coupon.uniqueCode,
                                            style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                              letterSpacing: 0.8,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 12),

                                // Action button
                                Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.3),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // USED Overlay
                      if (coupon.isUsed)
                        Positioned.fill(
                          child: Center(
                            child: Transform.rotate(
                              angle: -0.2,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 32,
                                  vertical: 16,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.95),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 3,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 12,
                                      offset: const Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: const Text(
                                  'USED',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                    letterSpacing: 4.0,
                                  ),
                                ),
                              ),
                            ),
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
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = date.difference(now).inDays;

    if (difference < 0) {
      return 'Expired';
    } else if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Tomorrow';
    } else if (difference <= 7) {
      return '$difference days';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
