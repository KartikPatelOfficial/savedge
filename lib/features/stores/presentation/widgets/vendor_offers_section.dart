import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:savedge/core/injection/injection.dart';
import 'package:savedge/core/storage/secure_storage_service.dart';
import 'package:savedge/core/widgets/login_prompt.dart';
import 'package:savedge/features/coupons/data/services/coupon_service.dart';
import 'package:savedge/features/coupons/presentation/pages/coupon_redemption_options_page.dart';
import 'package:savedge/features/coupons/presentation/widgets/coupon_hero_tag.dart';
import 'package:savedge/features/vendors/domain/entities/coupon.dart';
import 'package:savedge/features/promotion/presentation/bloc/promotion_bloc.dart';
import 'package:savedge/features/vendors/presentation/bloc/coupons_bloc.dart';

/// Decide if a coupon can be claimed via membership/subscription.
bool _hasMembershipOption(Coupon coupon) {
  final max = coupon.maxRedemptions;

  // Any non-zero cap (including -1 for unlimited) counts as a membership path.
  if (max != null) {
    return max != 0;
  }

  // Some payloads only return remaining claims for subscription eligibility.
  return coupon.remainingClaims != null;
}

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
              color: const Color(0xFFEF4444).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(40),
              border: Border.all(
                color: const Color(0xFFEF4444).withValues(alpha: 0.2),
                width: 2,
              ),
            ),
            child: Icon(
              Icons.error_outline,
              size: 36,
              color: const Color(0xFFEF4444).withValues(alpha: 0.7),
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
              color: const Color(0xFF6F3FCC).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(40),
              border: Border.all(
                color: const Color(0xFF6F3FCC).withValues(alpha: 0.2),
                width: 2,
              ),
            ),
            child: Icon(
              Icons.local_offer_outlined,
              size: 36,
              color: const Color(0xFF6F3FCC).withValues(alpha: 0.7),
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

Widget _buildCouponsList(
  List<Coupon> coupons,
  String vendorUid,
  String vendorName,
) {
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

class VendorOffersBlocView extends StatefulWidget {
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
  State<VendorOffersBlocView> createState() => _VendorOffersBlocViewState();
}

class _VendorOffersBlocViewState extends State<VendorOffersBlocView> {
  bool membershipOnly = false;

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
                    color: const Color(0xFF6F3FCC).withValues(alpha: 0.1),
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
                  widget.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A202C),
                  ),
                ),
              ],
            ),
          ),

          // Filter chip section
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, top: 12),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => setState(() => membershipOnly = !membershipOnly),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: membershipOnly
                          ? const Color(0xFF6F3FCC)
                          : const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          membershipOnly ? Icons.star : Icons.star_border,
                          size: 16,
                          color: membershipOnly
                              ? Colors.white
                              : const Color(0xFF6B7280),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Membership Only',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: membershipOnly
                                ? Colors.white
                                : const Color(0xFF6B7280),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                if (membershipOnly)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6F3FCC).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Premium filters active',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF6F3FCC),
                      ),
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
                // Only show claimable (valid & active) coupons
                var visible = state.coupons.where((c) => c.isValid).toList();
                if (membershipOnly) {
                  // Include coupons that can be claimed via membership (subscription),
                  // even if they also have a cash option.
                  visible = visible
                      .where((c) => _hasMembershipOption(c))
                      .toList();
                }
                return _buildCouponsList(
                  visible,
                  widget.vendorUid,
                  widget.vendorName,
                );
              }
              return _buildEmptyState();
            },
          ),
        ],
      ),
    );
  }
}

class VendorOffersView extends StatefulWidget {
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
  State<VendorOffersView> createState() => _VendorOffersViewState();
}

class _VendorOffersViewState extends State<VendorOffersView> {
  bool membershipOnly = false;

  @override
  Widget build(BuildContext context) {
    // Filter claimable coupons (valid & active)
    var visible = widget.coupons.where((c) => c.isValid).toList();
    if (membershipOnly) {
      // Include coupons that can be claimed via membership (subscription),
      // even if both membership and cash purchase are available.
      visible = visible.where((c) => _hasMembershipOption(c)).toList();
    }

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
                    color: const Color(0xFF6F3FCC).withValues(alpha: 0.1),
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
                  widget.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A202C),
                  ),
                ),
              ],
            ),
          ),

          // Filter chip section
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, top: 12),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => setState(() => membershipOnly = !membershipOnly),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: membershipOnly
                          ? const Color(0xFF6F3FCC)
                          : const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          membershipOnly ? Icons.star : Icons.star_border,
                          size: 16,
                          color: membershipOnly
                              ? Colors.white
                              : const Color(0xFF6B7280),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Membership Only',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: membershipOnly
                                ? Colors.white
                                : const Color(0xFF6B7280),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          visible.isNotEmpty
              ? _buildCouponsList(visible, widget.vendorUid, widget.vendorName)
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

  String get _heroTag =>
      couponHeroTag(couponId: widget.coupon.id, source: 'vendor');

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
    final accentColor = _getPrimaryColor();
    final hasCash =
        widget.coupon.cashPrice != null && widget.coupon.cashPrice! > 0;
    final hasMembership = _hasMembershipOption(widget.coupon);
    final staticPreview = _buildStaticCard(
      accentColor,
      hasCash: hasCash,
      hasMembership: hasMembership,
    );

    return GestureDetector(
      onTapDown: (_) {
        _animationController.forward();
        HapticFeedback.lightImpact();
      },
      onTapUp: (_) {
        _animationController.reverse();
        _onCouponTap(context, staticPreview);
      },
      onTapCancel: () {
        _animationController.reverse();
      },

      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) => Transform.scale(
          scale: _scaleAnimation.value,
          child: Hero(
            tag: _heroTag,
            child: Material(
              color: Colors.transparent,
              child: _buildCouponShell(
                accentColor: accentColor,
                hasCash: hasCash,
                hasMembership: hasMembership,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStaticCard(
    Color accentColor, {
    required bool hasCash,
    required bool hasMembership,
  }) {
    return Material(
      color: Colors.transparent,
      child: _buildCouponShell(
        accentColor: accentColor,
        hasCash: hasCash,
        hasMembership: hasMembership,
      ),
    );
  }

  Color _getPrimaryColor() {
    // Primary accent to match gradient sequence above
    final colors = [
      const Color(0xFFED8936), // Amber/Orange
      const Color(0xFF6F3FCC), // Purple
      const Color(0xFF3182CE), // Blue
      const Color(0xFF38A169), // Green
      const Color(0xFF38B2AC), // Teal
      const Color(0xFFE53E3E), // Red
    ];

    return colors[widget.index % colors.length];
  }

  /// Builds the full coupon card with clip, content, dashed divider, and border.
  Widget _buildCouponShell({
    required Color accentColor,
    required bool hasCash,
    required bool hasMembership,
  }) {
    return Stack(
      children: [
        // Clipped card content
        ClipPath(
          clipper: const _VendorCouponShapeClipper(),
          child: Container(
            color: Colors.white,
            child: Stack(
              children: [
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildDiscountStub(accentColor),
                      Expanded(
                        child: _buildDetailsPanel(
                          accentColor,
                          hasCash: hasCash,
                          hasMembership: hasMembership,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildDashedDivider(accentColor),
              ],
            ),
          ),
        ),
        // Border that follows the coupon shape (including notch arcs)
        Positioned.fill(
          child: IgnorePointer(
            child: CustomPaint(
              painter: _CouponBorderPainter(color: accentColor),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDiscountStub(Color accentColor) {
    return Container(
      width: 110,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          bottomLeft: Radius.circular(16),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _discountValueText(),
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w800,
                color: accentColor,
                height: 1.0,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: accentColor.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                _discountLabelText(),
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: accentColor,
                  letterSpacing: 1.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsPanel(
    Color accentColor, {
    required bool hasCash,
    required bool hasMembership,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.vendorName,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A202C),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.coupon.title,
                      style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (widget.coupon.description.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      _buildDescriptionPreview(accentColor),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 8),
              _buildClaimTypePill(accentColor, hasCash, hasMembership),
            ],
          ),
          if (widget.coupon.minimumAmountDisplay.isNotEmpty)
            Text(
              widget.coupon.minimumAmountDisplay,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Color(0xFF10B981),
              ),
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildValidityRow(),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _buildClaimChips(
                      accentColor,
                      hasCash,
                      hasMembership,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionPreview(Color accentColor) {
    return Text(
      widget.coupon.description,
      style: const TextStyle(
        fontSize: 12,
        color: Color(0xFF6B7280),
        height: 1.4,
      ),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildClaimTypePill(
    Color accentColor,
    bool hasCash,
    bool hasMembership,
  ) {
    String text;
    if (hasCash && hasMembership) {
      text = 'Cash or Membership';
    } else if (hasMembership) {
      text = 'Membership';
    } else {
      text = 'Cash purchase';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accentColor.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            hasMembership ? Icons.star : Icons.currency_rupee,
            size: 14,
            color: accentColor,
          ),
        ],
      ),
    );
  }

  Widget _buildValidityRow() {
    final color = _validityColor();
    return Row(
      children: [
        const Text(
          'Valid until: ',
          style: TextStyle(fontSize: 10, color: Color(0xFF9CA3AF)),
        ),
        Text(
          _formatExpiryDate(),
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildClaimChips(Color accentColor, bool hasCash, bool hasMembership) {
    // Check if promotion is active + enrolled
    bool hasActivePromotion = false;
    try {
      final promotionBloc = getIt<PromotionBloc>();
      hasActivePromotion = promotionBloc.state.maybeWhen(
        active: (status) => status.isEnrolled,
        orElse: () => false,
      );
    } catch (_) {}

    if (hasActivePromotion) {
      return Wrap(
        spacing: 8,
        runSpacing: 8,
        alignment: WrapAlignment.end,
        runAlignment: WrapAlignment.end,
        children: [
          _claimChip(
            const Color(0xFFFF6B35),
            icon: Icons.celebration_rounded,
            label: 'FREE',
          ),
        ],
      );
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.end,
      runAlignment: WrapAlignment.end,
      children: [
        if (hasCash)
          _claimChip(
            accentColor,
            icon: Icons.currency_rupee,
            label: 'buy at ₹${widget.coupon.cashPrice!.toInt()}',
          ),
        if (hasMembership)
          _claimChip(
            Colors.blueGrey,
            icon: Icons.star_rounded,
            label: _membershipAvailabilityText(),
          ),
      ],
    );
  }

  Widget _claimChip(
    Color color, {
    required IconData icon,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashedDivider(Color accentColor) {
    return Positioned(
      left: 106,
      top: 0,
      bottom: 0,
      child: SizedBox(
        width: 12,
        child: CustomPaint(painter: _DashedDividerPainter(accentColor)),
      ),
    );
  }

  String _membershipAvailabilityText() {
    final total = widget.coupon.maxRedemptions;
    final remaining = widget.coupon.remainingClaims;
    if (remaining != null && total != null) {
      return '$remaining left / $total total';
    }
    if (remaining != null && total == null) {
      return '$remaining left';
    }
    if (total != null) {
      return '$total available';
    }
    return 'Membership available';
  }

  String _discountValueText() {
    switch (widget.coupon.discountType.toLowerCase()) {
      case 'percentage':
        return '${widget.coupon.discountValue.toInt()}%';
      case 'freeitem':
        return 'FREE';
      case 'fixedamount':
        return '₹${widget.coupon.discountValue.toInt()}';
      default:
        return '${widget.coupon.discountValue.toInt()}%';
    }
  }

  String _discountLabelText() {
    switch (widget.coupon.discountType.toLowerCase()) {
      case 'freeitem':
        return 'ITEM';
      default:
        return 'OFF';
    }
  }

  String _formatExpiryDate() {
    return DateFormat('dd MMM yyyy').format(widget.coupon.validTo);
  }

  Color _validityColor() {
    final daysLeft = widget.coupon.validTo.difference(DateTime.now()).inDays;
    if (daysLeft < 0) return const Color(0xFFEF4444);
    if (daysLeft <= 7) return const Color(0xFFF59E0B);
    return const Color(0xFF10B981);
  }

  void _onCouponTap(BuildContext context, Widget staticPreview) async {
    try {
      // Show loading indicator with haptic feedback
      HapticFeedback.lightImpact();

      // Check if user is authenticated - coupon redemption requires login
      final secureStorage = getIt<SecureStorageService>();
      final isAuthenticated = await secureStorage.isAuthenticated();
      if (!isAuthenticated) {
        if (!mounted) return;
        LoginPrompt.show(
          context,
          message: 'Sign in to view coupon details and redeem offers.',
        );
        return;
      }

      // First, check the coupon to get its details
      final couponService = GetIt.I<CouponService>();
      final couponCheck = await couponService.checkCoupon(widget.coupon.id);

      // Navigate to coupon redemption options page
      final result = await Navigator.of(context).push<bool>(
        MaterialPageRoute(
          builder: (context) => CouponRedemptionOptionsPage(
            couponData: couponCheck,
            heroTag: _heroTag,
            previewSource: CouponPreviewSource.vendor,
            previewContent: staticPreview,
          ),
        ),
      );

      // Show enhanced result feedback
      if (!mounted) return;

      if (result == true) {
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
                            color: Colors.white.withValues(alpha: 0.9),
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
              onPressed: () => _onCouponTap(
                context,
                _buildStaticCard(
                  _getPrimaryColor(),
                  hasCash:
                      widget.coupon.cashPrice != null &&
                      widget.coupon.cashPrice! > 0,
                  hasMembership: _hasMembershipOption(widget.coupon),
                ),
              ),
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

/// Clips the vendor offer card into a coupon shape: rounded rectangle with
/// semicircle notches at the divider (x = 112).
class _VendorCouponShapeClipper extends CustomClipper<Path> {
  const _VendorCouponShapeClipper();

  static const double _notchRadius = 10.0;
  static const double _notchX = 112.0;
  static const double _cornerRadius = 16.0;

  @override
  Path getClip(Size size) {
    final path = Path()
      ..addRRect(
        RRect.fromLTRBR(
          0, 0, size.width, size.height,
          const Radius.circular(_cornerRadius),
        ),
      );

    final topNotch = Path()
      ..addOval(Rect.fromCircle(
        center: Offset(_notchX, 0),
        radius: _notchRadius,
      ));

    final bottomNotch = Path()
      ..addOval(Rect.fromCircle(
        center: Offset(_notchX, size.height),
        radius: _notchRadius,
      ));

    return Path.combine(
      PathOperation.difference,
      Path.combine(PathOperation.difference, path, topNotch),
      bottomNotch,
    );
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

/// Paints a dashed vertical line between the two notches.
class _DashedDividerPainter extends CustomPainter {
  const _DashedDividerPainter(this.accentColor);

  final Color accentColor;

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = accentColor.withValues(alpha: 0.4)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    const dashHeight = 4.0;
    const dashSpace = 4.0;
    double startY = 12;
    final endY = size.height - 12;

    while (startY < endY) {
      final nextY = (startY + dashHeight).clamp(0.0, endY);
      canvas.drawLine(
        Offset(size.width / 2, startY),
        Offset(size.width / 2, nextY),
        linePaint,
      );
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant _DashedDividerPainter oldDelegate) =>
      oldDelegate.accentColor != accentColor;
}

/// Strokes the coupon shape border (rounded rect with semicircle notch arcs).
class _CouponBorderPainter extends CustomPainter {
  const _CouponBorderPainter({required this.color});

  final Color color;

  static const double _notchRadius = 10.0;
  static const double _notchX = 112.0;
  static const double _cornerRadius = 16.0;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // Build the same path as the clipper
    final path = Path();

    // Start with a full rounded rectangle
    path.addRRect(
      RRect.fromLTRBR(
        0, 0, size.width, size.height,
        const Radius.circular(_cornerRadius),
      ),
    );

    // Subtract notches
    final topNotch = Path()
      ..addOval(Rect.fromCircle(
        center: Offset(_notchX, 0),
        radius: _notchRadius,
      ));
    final bottomNotch = Path()
      ..addOval(Rect.fromCircle(
        center: Offset(_notchX, size.height),
        radius: _notchRadius,
      ));

    final clipped = Path.combine(
      PathOperation.difference,
      Path.combine(PathOperation.difference, path, topNotch),
      bottomNotch,
    );

    canvas.drawPath(clipped, paint);
  }

  @override
  bool shouldRepaint(covariant _CouponBorderPainter oldDelegate) =>
      oldDelegate.color != color;
}
