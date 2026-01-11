import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:savedge/core/storage/secure_storage_service.dart';
import 'package:savedge/features/auth/data/models/user_profile_models.dart';
import 'package:savedge/features/auth/domain/repositories/auth_repository.dart';
import 'package:savedge/features/coupons/data/models/coupon_claim_models.dart';
import 'package:savedge/features/coupons/data/models/coupon_gifting_models.dart';
import 'package:savedge/features/coupons/presentation/widgets/coupon_hero_tag.dart';
import 'package:savedge/features/free_trial/data/models/free_trial_models.dart';
import 'package:savedge/features/free_trial/data/repositories/free_trial_repository.dart';
import 'package:savedge/features/user_profile/presentation/widgets/subscription_status_card.dart';

import 'coupon_confirmation_page.dart';

/// Modern coupon claiming page with beautiful UI and smooth animations
class CouponRedemptionOptionsPage extends StatefulWidget {
  const CouponRedemptionOptionsPage({
    super.key,
    required this.couponData,
    this.heroTag,
    this.previewSource = CouponPreviewSource.vendor,
    this.previewContent,
    this.userCoupon,
  });

  final CouponCheckResponse couponData;
  final String? heroTag;
  final CouponPreviewSource previewSource;
  final Widget? previewContent;
  final UserCouponDetailModel? userCoupon;

  @override
  State<CouponRedemptionOptionsPage> createState() =>
      _CouponRedemptionOptionsPageState();
}

class _CouponRedemptionOptionsPageState
    extends State<CouponRedemptionOptionsPage>
    with TickerProviderStateMixin {
  bool isProcessing = false;
  bool isLoadingProfile = true;
  RedemptionMethod? selectedMethod;
  UserProfileResponse3? _userProfile;
  String? _profileError;
  FreeTrialStatusResponse? _freeTrialStatus;

  late AnimationController _slideController;
  late AnimationController _fadeController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late final String _heroTag;

  AuthRepository get _authRepository => GetIt.I<AuthRepository>();

  SecureStorageService get _secureStorage => GetIt.I<SecureStorageService>();

  FreeTrialRepository get _freeTrialRepository =>
      GetIt.I<FreeTrialRepository>();

  @override
  void initState() {
    super.initState();
    _heroTag =
        widget.heroTag ?? couponHeroTag(couponId: widget.couponData.couponId);
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeOut));

    // Start animations and load user profile
    _slideController.forward();
    _fadeController.forward();
    _loadUserProfile();
  }

  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  Future<void> _loadUserProfile() async {
    try {
      setState(() => isLoadingProfile = true);

      // Check if user is authenticated
      final isAuthenticated = await _secureStorage.isAuthenticated();
      if (!isAuthenticated) {
        throw Exception('No authenticated user found');
      }

      // Get user profile to check subscription status
      final profile = await _authRepository.getCurrentUserProfile();

      // Get free trial status
      FreeTrialStatusResponse? freeTrialStatus;
      try {
        freeTrialStatus = await _freeTrialRepository.getFreeTrialStatus();
      } catch (e) {
        // Free trial status is optional, don't fail if it errors
        print('Failed to load free trial status: $e');
      }

      setState(() {
        _userProfile = profile;
        _freeTrialStatus = freeTrialStatus;
        isLoadingProfile = false;
      });
    } catch (e) {
      setState(() {
        _profileError = e.toString();
        isLoadingProfile = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFD),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black87),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 100, 20, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                _buildHeader(),
                const SizedBox(height: 24),

                // Coupon Card
                _buildModernCouponCard(),
                const SizedBox(height: 12),

                // Full description
                _buildDescriptionSection(),
                const SizedBox(height: 32),

                // Redemption Options
                _buildRedemptionOptions(),
                const SizedBox(height: 32),

                // Claim Button
                _buildModernClaimButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final isReadyUse = widget.previewSource == CouponPreviewSource.wallet ||
        widget.userCoupon != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isReadyUse ? 'Ready to use' : 'Claim Your',
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w300,
            color: Colors.black87,
          ),
        ),
        Text(
          isReadyUse ? 'Show at checkout' : 'Amazing Deal! 🎉',
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w800,
            color: Color(0xFF6F3FCC),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          isReadyUse
              ? 'Present this coupon to redeem'
              : 'Choose how you\'d like to get this coupon',
          style: TextStyle(fontSize: 16, color: Colors.grey[600], height: 1.4),
        ),
      ],
    );
  }

  Widget _buildModernCouponCard() {
    if (widget.previewContent != null) {
      final content = widget.previewContent!;

      if (content is Hero) {
        // Already wrapped at the source; reuse to avoid nested heroes.
        return content;
      }

      return Hero(
        tag: _heroTag,
        child: IgnorePointer(child: content),
      );
    }

    return Hero(
      tag: _heroTag,
      child: Material(
        color: Colors.transparent,
        child: widget.previewSource == CouponPreviewSource.wallet
            ? _buildWalletStylePreview()
            : _buildVendorStylePreview(),
      ),
    );
  }

  Widget _buildVendorStylePreview() {
    final accentColor = _vendorAccentColor();
    final expiryDate = DateTime.tryParse(widget.couponData.validUntil);
    final splitDiscount = _splitDiscountText(widget.couponData.discountDisplay);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildVendorStub(accentColor, splitDiscount.$1),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.couponData.vendorName,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black87,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      widget.couponData.title,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[700],
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: accentColor.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  splitDiscount.$2,
                                  style: TextStyle(
                                    color: accentColor,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.couponData.description,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF6B7280),
                              height: 1.35,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time_rounded,
                                size: 14,
                                color: Colors.grey[600],
                              ),
                              const SizedBox(width: 6),
                              Text(
                                expiryDate != null
                                    ? _formatDate(expiryDate)
                                    : 'Valid until: -',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: _validityColor(expiryDate),
                                ),
                              ),
                              const Spacer(),
                              if (widget.couponData.cashPrice != null &&
                                  widget.couponData.cashPrice! > 0)
                                _infoChip(
                                  icon: Icons.currency_rupee,
                                  label:
                                      'Rs${widget.couponData.cashPrice!.toStringAsFixed(0)}',
                                  color: const Color(0xFF10B981),
                                ),
                              if (widget.couponData.userMaxRedemptions !=
                                  null) ...[
                                const SizedBox(width: 8),
                                _infoChip(
                                  icon: Icons.workspace_premium,
                                  label: 'Membership',
                                  color: const Color(0xFF6366F1),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 98,
              top: 0,
              bottom: 0,
              child: SizedBox(
                width: 12,
                child: CustomPaint(painter: _InlineCutoutPainter()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWalletStylePreview() {
    final color = _walletColor();
    final expiryDate = DateTime.tryParse(widget.couponData.validUntil);
    final splitDiscount = _splitDiscountText(widget.couponData.discountDisplay);

    return Container(
      height: 165,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Row(
              children: [
                Container(
                  width: 100,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        splitDiscount.$1,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          height: 1.0,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          splitDiscount.$2,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: color.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.local_offer,
                                color: color,
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.couponData.vendorName,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF111827),
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    widget.couponData.title,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: Color(0xFF6B7280),
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            widget.couponData.description,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF4B5563),
                              height: 1.3,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Valid until: ',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Color(0xFF9CA3AF),
                                  ),
                                ),
                                Text(
                                  expiryDate != null
                                      ? _formatDate(expiryDate)
                                      : '-',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: _validityColor(expiryDate),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF7F8FA),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                        color: const Color(0xFFE5E7EB),
                                        width: 1,
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.qr_code_2,
                                      size: 14,
                                      color: Color(0xFF6B7280),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      widget.couponData.discountDisplay,
                                      style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'monospace',
                                        color: Color(0xFF111827),
                                        letterSpacing: 0.5,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 12,
                                    color: Colors.grey[500],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              left: 95,
              top: 0,
              bottom: 0,
              child: SizedBox(
                width: 10,
                child: CustomPaint(painter: _InlineCutoutPainter()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _vendorAccentColor() {
    final colors = [
      const Color(0xFF6F3FCC),
      const Color(0xFF2196F3),
      const Color(0xFF4CAF50),
      const Color(0xFFFF9800),
      const Color(0xFFE91E63),
      const Color(0xFF00BCD4),
      const Color(0xFFFF5722),
      const Color(0xFF9C27B0),
    ];
    return colors[widget.couponData.couponId % colors.length];
  }

  Color _walletColor() => _vendorAccentColor();

  (String, String) _splitDiscountText(String display) {
    final parts = display.split(' ');
    if (parts.length >= 2) {
      final value = parts.take(parts.length - 1).join(' ');
      final label = parts.last.toUpperCase();
      return (value, label);
    }
    return (display, 'OFF');
  }

  String _formatDate(DateTime date) =>
      '${date.day.toString().padLeft(2, '0')} ${_monthAbbrev(date.month)} ${date.year}';

  String _monthAbbrev(int month) {
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
    return months[(month - 1).clamp(0, months.length - 1)];
  }

  Color _validityColor(DateTime? expiry) {
    if (expiry == null) return const Color(0xFF10B981);
    final daysLeft = expiry.difference(DateTime.now()).inDays;
    if (daysLeft < 0) return const Color(0xFFEF4444);
    if (daysLeft <= 7) return const Color(0xFFF59E0B);
    return const Color(0xFF10B981);
  }

  Widget _buildVendorStub(Color color, String value) {
    return Container(
      width: 110,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color.withOpacity(0.85)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          bottomLeft: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              height: 1.0,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.25),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'OFF',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoChip({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
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

  Widget _buildDescriptionSection() {
    final rawDescription =
        (widget.userCoupon?.description ?? widget.couponData.description).trim();
    final description =
        rawDescription.isEmpty ? widget.couponData.title : rawDescription;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        description,
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xFF374151),
          height: 1.5,
        ),
      ),
    );
  }

  Widget _buildRedemptionOptions() {
    if (widget.previewSource == CouponPreviewSource.wallet ||
        widget.userCoupon != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'This coupon is ready to use.',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Show it at checkout to redeem.',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF6B7280),
            ),
          ),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: 24,
              decoration: BoxDecoration(
                color: const Color(0xFF6F3FCC),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              widget.couponData.hasUnusedCoupons
                  ? 'You Have ${widget.couponData.unusedCoupons.length} Unused Coupon${widget.couponData.unusedCoupons.length > 1 ? 's' : ''}'
                  : 'Choose Your Method',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        if (widget.couponData.hasUnusedCoupons) ...[
          const SizedBox(height: 12),
          Text(
            'You can redeem one of your existing unused coupons or claim a new one.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              height: 1.4,
            ),
          ),
        ],
        const SizedBox(height: 20),

        // Show "Use Existing" option if user has unused coupons
        if (widget.couponData.hasUnusedCoupons) ...[
          _buildModernRedemptionOption(
            method: RedemptionMethod.existing,
            icon: Icons.redeem,
            title: 'Use Existing Coupon',
            subtitle: '${widget.couponData.unusedCoupons.length} available',
            description: 'Redeem one of your unused coupons',
            color: const Color(0xFF00BF63),
            gradient: const LinearGradient(
              colors: [Color(0xFF00BF63), Color(0xFF00A047)],
            ),
            isEnabled: true,
          ),
          const SizedBox(height: 16),

          // Divider with "OR" text
          Row(
            children: [
              const Expanded(child: Divider()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'OR CLAIM NEW',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[500],
                  ),
                ),
              ),
              const Expanded(child: Divider()),
            ],
          ),
          const SizedBox(height: 16),
        ],

        // Online Payment Option (only show if cash price is set)
        if (widget.couponData.cashPrice != null &&
            widget.couponData.cashPrice! > 0)
          _buildModernRedemptionOption(
            method: RedemptionMethod.online,
            icon: Icons.credit_card,
            title: 'Pay & Claim',
            subtitle: '₹${widget.couponData.cashPrice}',
            description: 'Instant purchase with card/UPI',
            color: const Color(0xFF00C851),
            gradient: const LinearGradient(
              colors: [Color(0xFF00C851), Color(0xFF00A047)],
            ),
            isEnabled: true, // Can always use payment to claim new coupons
          ),

        const SizedBox(height: 16),

        // Subscription/Membership Option - Show only if user has active subscription and redemption allowance
        if (widget.couponData.userMaxRedemptions != null &&
            widget.couponData.userMaxRedemptions! > 0) ...[
          if (isLoadingProfile)
            _buildLoadingMembershipOption()
          else if (_hasActiveSubscription())
            _buildModernMembershipOption()
          else if (_hasActiveFreeTrial())
            _buildModernFreeTrialOption(),
        ],
      ],
    );
  }

  Widget _buildModernRedemptionOption({
    required RedemptionMethod method,
    required IconData icon,
    required String title,
    required String subtitle,
    required String description,
    required Color color,
    required LinearGradient gradient,
    required bool isEnabled,
  }) {
    final isSelected = selectedMethod == method;

    return GestureDetector(
      onTap: isEnabled ? () => setState(() => selectedMethod = method) : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? color : Colors.grey[200]!,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? color.withOpacity(0.2)
                  : Colors.black.withOpacity(0.05),
              blurRadius: isSelected ? 20 : 10,
              offset: Offset(0, isSelected ? 8 : 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                gradient: isEnabled ? gradient : null,
                color: !isEnabled ? Colors.grey[200] : null,
                borderRadius: BorderRadius.circular(16),
                boxShadow: isEnabled
                    ? [
                        BoxShadow(
                          color: color.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: Icon(
                icon,
                color: isEnabled ? Colors.white : Colors.grey[400],
                size: 26,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: isEnabled ? Colors.black87 : Colors.grey[500],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isEnabled ? color : Colors.grey[400],
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isSelected ? color : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? color : Colors.grey[300]!,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Icon(Icons.check, color: Colors.white, size: 16)
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernMembershipOption() {
    // API provides userUsedRedemptions as total subscription claims (used + unused)
    // We intentionally base remaining claims on claimed count, not used count
    // Prefer server-computed remaining claims if available
    final remainingClaims =
        widget.couponData.remainingSubscriptionClaims ??
        (widget.couponData.userMaxRedemptions! -
            widget.couponData.userUsedRedemptions);

    final isEnabled = remainingClaims > 0;
    final isSelected = selectedMethod == RedemptionMethod.membership;
    final color = const Color(0xFF6F3FCC);
    final gradient = const LinearGradient(
      colors: [Color(0xFF6F3FCC), Color(0xFF8E44AD)],
    );

    return GestureDetector(
      onTap: isEnabled
          ? () => setState(() => selectedMethod = RedemptionMethod.membership)
          : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? color : Colors.grey[200]!,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? color.withOpacity(0.2)
                  : Colors.black.withOpacity(0.05),
              blurRadius: isSelected ? 20 : 10,
              offset: Offset(0, isSelected ? 8 : 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                gradient: isEnabled ? gradient : null,
                color: !isEnabled ? Colors.grey[200] : null,
                borderRadius: BorderRadius.circular(16),
                boxShadow: isEnabled
                    ? [
                        BoxShadow(
                          color: color.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: Icon(
                Icons.workspace_premium,
                color: isEnabled ? Colors.white : Colors.grey[400],
                size: 26,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Membership',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: isEnabled ? Colors.black87 : Colors.grey[500],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          gradient: isEnabled ? gradient : null,
                          color: !isEnabled ? Colors.grey[200] : null,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '$remainingClaims left',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: isEnabled ? Colors.white : Colors.grey[500],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'FREE',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isEnabled ? color : Colors.grey[400],
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    isEnabled
                        ? 'Use your premium membership'
                        : 'No claims remaining',
                    style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isSelected ? color : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? color : Colors.grey[300]!,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Icon(Icons.check, color: Colors.white, size: 16)
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernFreeTrialOption() {
    final remainingClaims =
        widget.couponData.remainingSubscriptionClaims ??
        (widget.couponData.userMaxRedemptions! -
            widget.couponData.userUsedRedemptions);

    final isEnabled = remainingClaims > 0;
    final isSelected = selectedMethod == RedemptionMethod.freeTrial;
    final color = const Color(0xFFFF6B35); // Orange color for free trial
    final gradient = const LinearGradient(
      colors: [Color(0xFFFF6B35), Color(0xFFF7931E)],
    );

    // Get remaining days from free trial status
    final remainingDays = _freeTrialStatus?.remainingTime?.days ?? 0;

    return GestureDetector(
      onTap: isEnabled
          ? () => setState(() => selectedMethod = RedemptionMethod.freeTrial)
          : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? color : Colors.grey[200]!,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? color.withOpacity(0.2)
                  : Colors.black.withOpacity(0.05),
              blurRadius: isSelected ? 20 : 10,
              offset: Offset(0, isSelected ? 8 : 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                gradient: isEnabled ? gradient : null,
                color: !isEnabled ? Colors.grey[200] : null,
                borderRadius: BorderRadius.circular(16),
                boxShadow: isEnabled
                    ? [
                        BoxShadow(
                          color: color.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: Icon(
                Icons.celebration,
                color: isEnabled ? Colors.white : Colors.grey[400],
                size: 26,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Free Trial',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: isEnabled ? Colors.black87 : Colors.grey[500],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          gradient: isEnabled ? gradient : null,
                          color: !isEnabled ? Colors.grey[200] : null,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '$remainingDays days left',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: isEnabled ? Colors.white : Colors.grey[500],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        'FREE',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isEnabled ? color : Colors.grey[400],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '$remainingClaims left',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: color,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    isEnabled
                        ? 'Try SavEdge with your 5-day trial'
                        : 'No claims remaining',
                    style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isSelected ? color : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? color : Colors.grey[300]!,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Icon(Icons.check, color: Colors.white, size: 16)
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernClaimButton() {
    final isReadyUse =
        widget.previewSource == CouponPreviewSource.wallet ||
            widget.userCoupon != null;
    final isEnabled = isReadyUse || (selectedMethod != null && !isProcessing);

    return Container(
      width: double.infinity,
      height: 64,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: isEnabled
            ? [
                BoxShadow(
                  color: const Color(0xFF6F3FCC).withOpacity(0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ]
            : null,
      ),
      child: ElevatedButton(
        onPressed: isEnabled
            ? isReadyUse
                ? _handleUseExisting
                : _handleClaim
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled
              ? const Color(0xFF6F3FCC)
              : Colors.grey[300],
          foregroundColor: Colors.white,
          disabledForegroundColor: Colors.grey[500],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
        ),
        child: isProcessing
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      strokeWidth: 2,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Processing...',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isReadyUse
                        ? Icons.redeem
                        : selectedMethod == RedemptionMethod.existing
                            ? Icons.redeem
                            : selectedMethod == RedemptionMethod.membership
                                ? Icons.workspace_premium
                                : Icons.credit_card,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _getButtonText(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  String _getButtonText() {
    final isReadyUse =
        widget.previewSource == CouponPreviewSource.wallet ||
            widget.userCoupon != null;
    if (isReadyUse) {
      return 'Use Coupon';
    }

    if (selectedMethod == null) return 'Select a Method';

    switch (selectedMethod!) {
      case RedemptionMethod.existing:
        return 'Use Existing Coupon';
      case RedemptionMethod.online:
        return 'Pay & Get Coupon';
      case RedemptionMethod.membership:
        return 'Claim for FREE';
      case RedemptionMethod.freeTrial:
        return 'Claim with Free Trial';
    }
  }

  /// Check if user has an active subscription
  bool _hasActiveSubscription() {
    if (isLoadingProfile || _userProfile == null) {
      return false; // Don't show membership option while loading or if no profile
    }

    final subscription = _userProfile!.subscriptionInfo;
    if (subscription == null) {
      return false; // No subscription
    }

    // Use the extension method from subscription_status_card.dart
    return subscription.isCurrentlyActive;
  }

  /// Check if user has an active free trial
  bool _hasActiveFreeTrial() {
    if (isLoadingProfile || _freeTrialStatus == null) {
      return false;
    }

    return _freeTrialStatus!.status == FreeTrialStatus.active;
  }

  /// Build loading state for membership option
  Widget _buildLoadingMembershipOption() {
    const color = Color(0xFF6F3FCC);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[200]!, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.workspace_premium,
              color: Colors.grey,
              size: 26,
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Checking Membership...',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Please wait',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleClaim() async {
    if (selectedMethod == null) return;

    setState(() => isProcessing = true);

    try {
      // Navigate to confirmation page instead of directly claiming
      await Future.delayed(const Duration(milliseconds: 300));

      if (!mounted) return;

      bool result = false;

      if (selectedMethod == RedemptionMethod.existing) {
        // For existing coupons, use the "use" confirmation type
        if (widget.couponData.unusedCoupons.isNotEmpty) {
          final firstUnusedCoupon = widget.couponData.unusedCoupons.first;

          // Create UserCouponDetailModel from unused coupon data
          final userCoupon = UserCouponDetailModel(
            id: firstUnusedCoupon.id,
            couponId: widget.couponData.couponId,
            title: widget.couponData.title,
            description: widget.couponData.description,
            vendorId: widget.couponData.vendorId,
            vendorUserId: widget.couponData.vendorUserId,
            vendorName: widget.couponData.vendorName,
            status: firstUnusedCoupon.status,
            acquiredDate:
                DateTime.tryParse(firstUnusedCoupon.purchasedDate) ??
                DateTime.now(),
            redeemedDate: null,
            // Unused coupons don't have redemption date
            expiryDate:
                DateTime.tryParse(widget.couponData.validUntil) ??
                DateTime.now(),
            uniqueCode: firstUnusedCoupon.uniqueCode,
            qrCode: null,
            // QR code may not be in unused coupon data
            discountType: widget.couponData.discountType.toString(),
            discountValue: widget.couponData.discountValue,
            minCartValue: widget.couponData.minCartValue,
            imageUrl: null,
            // Image URLs are no longer supported in the new system
            isGifted: false,
            // Assuming unused coupons are not gifted
            giftedFromUserId: null,
            giftedToUserId: null,
            giftedDate: null,
            giftMessage: null,
          );

          result =
              await Navigator.of(context).push<bool>(
                MaterialPageRoute(
                  builder: (context) => CouponConfirmationPage(
                    userCoupon: userCoupon,
                    confirmationType: CouponConfirmationType.use,
                  ),
                ),
              ) ??
              false;
        } else {
          throw Exception('No unused coupons available');
        }
      } else {
        // For new claims, use the "claim" confirmation type
        result =
            await Navigator.of(context).push<bool>(
              MaterialPageRoute(
                builder: (context) => CouponConfirmationPage(
                  claimCoupon: widget.couponData,
                  redemptionMethod: _getRedemptionMethodString(),
                  confirmationType: CouponConfirmationType.claim,
                ),
              ),
            ) ??
            false;
      }

      if (result && mounted) {
        // If confirmation was successful, navigate back to previous screens
        Navigator.of(context).pop(true); // Return to QR scanner
      }
    } catch (e) {
      _showErrorDialog(e.toString());
    } finally {
      if (mounted) {
        setState(() => isProcessing = false);
      }
    }
  }

  String _getRedemptionMethodString() {
    switch (selectedMethod!) {
      case RedemptionMethod.existing:
        return 'existing';
      case RedemptionMethod.online:
        return 'online';
      case RedemptionMethod.membership:
        return 'membership';
      case RedemptionMethod.freeTrial:
        return 'freeTrial';
    }
  }

  // Helper method for safe date parsing
  DateTime? _parseDateTime(dynamic dateValue) {
    if (dateValue == null) return null;
    if (dateValue is DateTime) return dateValue;
    return DateTime.tryParse(dateValue.toString());
  }

  // These methods are no longer needed as we navigate to confirmation page
  // The actual claiming happens in the confirmation page

  // Success dialog no longer needed - handled by confirmation page

  void _showErrorDialog(String error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.error, color: Colors.red, size: 24),
            SizedBox(width: 8),
            Text('Error'),
          ],
        ),
        content: Text(error.replaceAll('Exception: ', '')),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _handleUseExisting() async {
    try {
      setState(() => isProcessing = true);

      final result = await Navigator.of(context).push<bool>(
        MaterialPageRoute(
          builder: (_) => CouponConfirmationPage(
            userCoupon: widget.userCoupon,
            confirmationType: CouponConfirmationType.use,
          ),
        ),
      );

      if (result == true && mounted) {
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      _showErrorDialog(e.toString());
    } finally {
      if (mounted) {
        setState(() => isProcessing = false);
      }
    }
  }
}

enum RedemptionMethod { existing, online, membership, freeTrial }

enum CouponPreviewSource { vendor, wallet }

class _InlineCutoutPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFF5F5F5)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(size.width / 2, 0), 8, paint);
    canvas.drawCircle(Offset(size.width / 2, size.height), 8, paint);

    final linePaint = Paint()
      ..color = const Color(0xFFE5E7EB)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    const dashHeight = 4.0;
    const dashSpace = 4.0;
    double startY = 8;
    while (startY < size.height - 8) {
      canvas.drawLine(
        Offset(size.width / 2, startY),
        Offset(size.width / 2, startY + dashHeight),
        linePaint,
      );
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
