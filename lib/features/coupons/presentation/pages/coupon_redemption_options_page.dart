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

/// Modern coupon claiming page with tile-based method selection
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

  late AnimationController _fadeController;
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
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..forward();
    _fadeAnimation =
        CurvedAnimation(parent: _fadeController, curve: Curves.easeOut);
    _loadUserProfile();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  Future<void> _loadUserProfile() async {
    try {
      setState(() => isLoadingProfile = true);

      final isAuthenticated = await _secureStorage.isAuthenticated();
      if (!isAuthenticated) {
        throw Exception('No authenticated user found');
      }

      final profile = await _authRepository.getCurrentUserProfile();

      FreeTrialStatusResponse? freeTrialStatus;
      try {
        freeTrialStatus = await _freeTrialRepository.getFreeTrialStatus();
      } catch (e) {
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
    final isReadyUse = widget.previewSource == CouponPreviewSource.wallet ||
        widget.userCoupon != null;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SafeArea(
          child: Column(
            children: [
              // ── Top bar ────────────────────────────────────────────────────
              _buildTopBar(context, isReadyUse),

              // ── Scrollable content ─────────────────────────────────────────
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),

                      // Coupon card preview (with Hero)
                      _buildModernCouponCard(),
                      const SizedBox(height: 16),

                      // Description
                      _buildDescriptionSection(),
                      const SizedBox(height: 28),

                      // Method selection or ready-to-use message
                      if (isReadyUse)
                        _buildReadyToUseSection()
                      else
                        _buildMethodSelectionSection(),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildStickyButton(isReadyUse),
    );
  }

  Widget _buildTopBar(BuildContext context, bool isReadyUse) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 15,
                color: Color(0xFF1A202C),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isReadyUse ? 'Use Coupon' : 'Get This Deal',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1A202C),
                  ),
                ),
                Text(
                  isReadyUse
                      ? 'Present at checkout to redeem'
                      : 'Choose how you\'d like to claim',
                  style: TextStyle(fontSize: 13, color: Colors.grey[500]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReadyToUseSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF10B981).withOpacity(0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF10B981).withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.check_circle_outline_rounded,
              color: Color(0xFF10B981),
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ready to redeem',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A202C),
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'Show this coupon at checkout',
                  style: TextStyle(fontSize: 13, color: Color(0xFF10B981)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMethodSelectionSection() {
    final hasUnused = widget.couponData.hasUnusedCoupons;
    final unusedCount = widget.couponData.unusedCoupons.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'How would you like to get this?',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: Color(0xFF1A202C),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Pick the best option for you',
          style: TextStyle(fontSize: 13, color: Colors.grey[500]),
        ),
        const SizedBox(height: 20),

        // Show "Use Existing" as a prominent full-width option if user has unused
        if (hasUnused) ...[
          _buildExistingCouponBanner(unusedCount),
          const SizedBox(height: 20),
          _buildOrDivider(),
          const SizedBox(height: 20),
        ],

        // 2-column tile grid for claim methods
        _buildMethodGrid(),
      ],
    );
  }

  Widget _buildExistingCouponBanner(int count) {
    final isSelected = selectedMethod == RedemptionMethod.existing;
    return GestureDetector(
      onTap: () => setState(() => selectedMethod = RedemptionMethod.existing),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF00BF63)
              : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF00BF63)
                : const Color(0xFFE2E8F0),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withOpacity(0.2)
                    : const Color(0xFF00BF63).withOpacity(0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                Icons.redeem_rounded,
                color: isSelected ? Colors.white : const Color(0xFF00BF63),
                size: 22,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Use Existing Coupon',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: isSelected ? Colors.white : const Color(0xFF1A202C),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '$count unused coupon${count > 1 ? 's' : ''} available',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? Colors.white.withOpacity(0.85)
                          : const Color(0xFF00BF63),
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle_rounded,
                  color: Colors.white, size: 22)
            else
              Icon(Icons.arrow_forward_ios_rounded,
                  size: 14, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }

  Widget _buildOrDivider() {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Text(
            'OR CLAIM NEW',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Colors.grey[400],
              letterSpacing: 0.8,
            ),
          ),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }

  Widget _buildMethodGrid() {
    final tiles = <Widget>[];

    // Online payment tile
    if (widget.couponData.cashPrice != null &&
        widget.couponData.cashPrice! > 0) {
      tiles.add(_buildMethodTile(
        method: RedemptionMethod.online,
        icon: Icons.credit_card_rounded,
        title: 'Pay Online',
        subtitle: '₹${widget.couponData.cashPrice!.toStringAsFixed(0)}',
        color: const Color(0xFF10B981),
        isEnabled: true,
      ));
    }

    // Membership / Free Trial tile
    if (widget.couponData.userMaxRedemptions != null &&
        widget.couponData.userMaxRedemptions! > 0) {
      if (isLoadingProfile) {
        tiles.add(_buildLoadingTile());
      } else if (_hasActiveSubscription()) {
        tiles.add(_buildMembershipTile());
      } else if (_hasActiveFreeTrial()) {
        tiles.add(_buildFreeTrialTile());
      }
    }

    if (tiles.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(
          children: [
            Icon(Icons.info_outline, size: 20, color: Colors.grey[400]),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'No claiming options available for this coupon',
                style: TextStyle(fontSize: 14, color: Colors.grey[500]),
              ),
            ),
          ],
        ),
      );
    }

    // Single tile: full width. Two tiles: side by side.
    if (tiles.length == 1) {
      return tiles.first;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: tiles[0]),
        const SizedBox(width: 14),
        Expanded(child: tiles[1]),
      ],
    );
  }

  Widget _buildMethodTile({
    required RedemptionMethod method,
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required bool isEnabled,
  }) {
    final isSelected = selectedMethod == method;

    return GestureDetector(
      onTap: isEnabled ? () => setState(() => selectedMethod = method) : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF6F3FCC)
              : isEnabled
                  ? Colors.white
                  : const Color(0xFFF7F8FA),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF6F3FCC)
                : const Color(0xFFE2E8F0),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.white.withOpacity(0.18)
                        : color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: isSelected ? Colors.white : color,
                    size: 20,
                  ),
                ),
                if (isSelected)
                  const Icon(Icons.check_circle_rounded,
                      color: Colors.white, size: 18),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: isSelected ? Colors.white : const Color(0xFF1A202C),
              ),
            ),
            const SizedBox(height: 3),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: isSelected ? Colors.white : color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMembershipTile() {
    final remainingClaims =
        widget.couponData.remainingSubscriptionClaims ??
        (widget.couponData.userMaxRedemptions! -
            widget.couponData.userUsedRedemptions);
    final isEnabled = remainingClaims > 0;
    final isSelected = selectedMethod == RedemptionMethod.membership;
    const color = Color(0xFF6F3FCC);

    return GestureDetector(
      onTap: isEnabled
          ? () => setState(() => selectedMethod = RedemptionMethod.membership)
          : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? color
              : isEnabled
                  ? Colors.white
                  : const Color(0xFFF7F8FA),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected ? color : const Color(0xFFE2E8F0),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.white.withOpacity(0.18)
                        : isEnabled
                            ? color.withOpacity(0.1)
                            : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.workspace_premium_rounded,
                    color: isSelected
                        ? Colors.white
                        : isEnabled
                            ? color
                            : Colors.grey,
                    size: 20,
                  ),
                ),
                if (isSelected)
                  const Icon(Icons.check_circle_rounded,
                      color: Colors.white, size: 18),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              'Membership',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: isSelected
                    ? Colors.white
                    : isEnabled
                        ? const Color(0xFF1A202C)
                        : Colors.grey,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              isEnabled ? 'FREE · $remainingClaims left' : 'No claims left',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: isSelected
                    ? Colors.white
                    : isEnabled
                        ? color
                        : Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFreeTrialTile() {
    final remainingClaims =
        widget.couponData.remainingSubscriptionClaims ??
        (widget.couponData.userMaxRedemptions! -
            widget.couponData.userUsedRedemptions);
    final isEnabled = remainingClaims > 0;
    final isSelected = selectedMethod == RedemptionMethod.freeTrial;
    const color = Color(0xFFFF6B35);
    final remainingDays = _freeTrialStatus?.remainingTime?.days ?? 0;

    return GestureDetector(
      onTap: isEnabled
          ? () => setState(() => selectedMethod = RedemptionMethod.freeTrial)
          : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? color
              : isEnabled
                  ? Colors.white
                  : const Color(0xFFF7F8FA),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected ? color : const Color(0xFFE2E8F0),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.white.withOpacity(0.18)
                        : isEnabled
                            ? color.withOpacity(0.1)
                            : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.celebration_rounded,
                    color: isSelected
                        ? Colors.white
                        : isEnabled
                            ? color
                            : Colors.grey,
                    size: 20,
                  ),
                ),
                if (isSelected)
                  const Icon(Icons.check_circle_rounded,
                      color: Colors.white, size: 18),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              'Free Trial',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: isSelected
                    ? Colors.white
                    : isEnabled
                        ? const Color(0xFF1A202C)
                        : Colors.grey,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              isEnabled
                  ? 'FREE · $remainingDays days left'
                  : 'No claims left',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: isSelected
                    ? Colors.white
                    : isEnabled
                        ? color
                        : Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingTile() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.workspace_premium_rounded,
                  color: Colors.grey,
                  size: 20,
                ),
              ),
              const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6F3FCC)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Text(
            'Checking...',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            'Loading membership',
            style: TextStyle(fontSize: 13, color: Colors.grey.shade400),
          ),
        ],
      ),
    );
  }

  Widget _buildStickyButton(bool isReadyUse) {
    final isEnabled =
        isReadyUse || (selectedMethod != null && !isProcessing);
    final accentColor = isReadyUse
        ? const Color(0xFF10B981)
        : selectedMethod == RedemptionMethod.existing
            ? const Color(0xFF00BF63)
            : selectedMethod == RedemptionMethod.membership
                ? const Color(0xFF6F3FCC)
                : selectedMethod == RedemptionMethod.freeTrial
                    ? const Color(0xFFFF6B35)
                    : const Color(0xFF6F3FCC);

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFF0F0F0))),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: isEnabled
                    ? isReadyUse
                        ? _handleUseExisting
                        : _handleClaim
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isEnabled ? accentColor : Colors.grey.shade200,
                  foregroundColor: Colors.white,
                  disabledForegroundColor: Colors.grey.shade400,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                child: isProcessing
                    ? const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                              strokeWidth: 2,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Processing...',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(_getButtonIcon(isReadyUse), size: 20),
                          const SizedBox(width: 8),
                          Text(
                            _getButtonText(isReadyUse),
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  IconData _getButtonIcon(bool isReadyUse) {
    if (isReadyUse) return Icons.redeem_rounded;
    switch (selectedMethod) {
      case RedemptionMethod.existing:
        return Icons.redeem_rounded;
      case RedemptionMethod.online:
        return Icons.credit_card_rounded;
      case RedemptionMethod.membership:
        return Icons.workspace_premium_rounded;
      case RedemptionMethod.freeTrial:
        return Icons.celebration_rounded;
      default:
        return Icons.arrow_forward_rounded;
    }
  }

  String _getButtonText(bool isReadyUse) {
    if (isReadyUse) return 'Use Coupon';
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

  // ─── Coupon preview card (unchanged) ─────────────────────────────────────

  Widget _buildModernCouponCard() {
    if (widget.previewContent != null) {
      final content = widget.previewContent!;
      if (content is Hero) {
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
        border: Border.all(color: const Color(0xFFE2E8F0)),
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
        border: Border.all(color: const Color(0xFFE2E8F0)),
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
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
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
        border: Border.all(color: const Color(0xFFE2E8F0)),
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

  // ─── Logic methods (unchanged from original) ──────────────────────────────

  bool _hasActiveSubscription() {
    if (isLoadingProfile || _userProfile == null) return false;
    final subscription = _userProfile!.subscriptionInfo;
    if (subscription == null) return false;
    return subscription.isCurrentlyActive;
  }

  bool _hasActiveFreeTrial() {
    if (isLoadingProfile || _freeTrialStatus == null) return false;
    return _freeTrialStatus!.status == FreeTrialStatus.active;
  }

  Future<void> _handleClaim() async {
    if (selectedMethod == null) return;

    setState(() => isProcessing = true);

    try {
      await Future.delayed(const Duration(milliseconds: 300));
      if (!mounted) return;

      bool result = false;

      if (selectedMethod == RedemptionMethod.existing) {
        if (widget.couponData.unusedCoupons.isNotEmpty) {
          final firstUnusedCoupon = widget.couponData.unusedCoupons.first;

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
            expiryDate:
                DateTime.tryParse(widget.couponData.validUntil) ??
                DateTime.now(),
            uniqueCode: firstUnusedCoupon.uniqueCode,
            qrCode: null,
            discountType: widget.couponData.discountType.toString(),
            discountValue: widget.couponData.discountValue,
            minCartValue: widget.couponData.minCartValue,
            imageUrl: null,
            isGifted: false,
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
