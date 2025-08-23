import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:savedge/features/coupons/data/services/coupon_service.dart';
import 'package:savedge/features/coupons/data/models/coupon_claim_models.dart';
import 'package:savedge/features/coupons/data/models/coupon_gifting_models.dart';
import 'coupon_confirmation_page.dart';

/// Modern coupon claiming page with beautiful UI and smooth animations
class CouponRedemptionOptionsPage extends StatefulWidget {
  const CouponRedemptionOptionsPage({super.key, required this.couponData});

  final CouponCheckResponse couponData;

  @override
  State<CouponRedemptionOptionsPage> createState() =>
      _CouponRedemptionOptionsPageState();
}

class _CouponRedemptionOptionsPageState
    extends State<CouponRedemptionOptionsPage> with TickerProviderStateMixin {
  CouponService get _couponService => GetIt.I<CouponService>();
  bool isProcessing = false;
  RedemptionMethod? selectedMethod;
  
  late AnimationController _slideController;
  late AnimationController _fadeController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    ));

    // Start animations
    _slideController.forward();
    _fadeController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
    super.dispose();
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Claim Your',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w300,
            color: Colors.black87,
          ),
        ),
        const Text(
          'Amazing Deal! 🎉',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w800,
            color: Color(0xFF6F3FCC),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Choose how you\'d like to get this coupon',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildModernCouponCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6F3FCC).withOpacity(0.2),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Main gradient card
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF667eea),
                  Color(0xFF764ba2),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.couponData.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.store_outlined,
                                      color: Colors.white,
                                      size: 14,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      widget.couponData.vendorName,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
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
                      child: Text(
                        widget.couponData.discountDisplay,
                        style: const TextStyle(
                          color: Color(0xFF6F3FCC),
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  widget.couponData.description,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    height: 1.5,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                if (widget.couponData.minCartValue > 0) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.white,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Minimum order: ₹${widget.couponData.minCartValue.toStringAsFixed(0)}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          // Decorative elements
          Positioned(
            right: -30,
            top: -30,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),
          Positioned(
            left: -20,
            bottom: -20,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRedemptionOptions() {
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

        // Points Option
        _buildModernRedemptionOption(
          method: RedemptionMethod.points,
          icon: Icons.auto_awesome,
          title: 'Use SavPoints',
          subtitle: '${widget.couponData.pointsCost} points',
          description: 'Redeem from your earned points',
          color: const Color(0xFFFF6B35),
          gradient: const LinearGradient(
            colors: [Color(0xFFFF6B35), Color(0xFFF7931E)],
          ),
          isEnabled: true, // Can always use points to claim new coupons
        ),

        const SizedBox(height: 16),

        // Razorpay Option
        _buildModernRedemptionOption(
          method: RedemptionMethod.razorpay,
          icon: Icons.credit_card,
          title: 'Pay & Claim',
          subtitle: '₹${widget.couponData.pointsCost}',
          description: 'Instant purchase with card/UPI',
          color: const Color(0xFF00C851),
          gradient: const LinearGradient(
            colors: [Color(0xFF00C851), Color(0xFF00A047)],
          ),
          isEnabled: true, // Can always use payment to claim new coupons
        ),

        const SizedBox(height: 16),

        // Subscription/Membership Option - Show if user has active subscription allowance
        if (widget.couponData.userMaxRedemptions != null && widget.couponData.userMaxRedemptions! > 0)
          _buildModernMembershipOption(),
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
      onTap: isEnabled 
          ? () => setState(() => selectedMethod = method) 
          : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected 
                ? color 
                : Colors.grey[200]!,
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
                boxShadow: isEnabled ? [
                  BoxShadow(
                    color: color.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ] : null,
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
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
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
                  ? const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernMembershipOption() {
    final usedRedemptions = widget.couponData.userUsedRedemptions;
    final maxRedemptions = widget.couponData.userMaxRedemptions!;
    final remainingRedemptions = maxRedemptions - usedRedemptions;

    final isEnabled = remainingRedemptions > 0;
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
                boxShadow: isEnabled ? [
                  BoxShadow(
                    color: color.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ] : null,
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
                          '$remainingRedemptions left',
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
                        : 'No redemptions remaining',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
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
                  ? const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernClaimButton() {
    final isEnabled = selectedMethod != null && !isProcessing;

    return Container(
      width: double.infinity,
      height: 64,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: isEnabled ? [
          BoxShadow(
            color: const Color(0xFF6F3FCC).withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ] : null,
      ),
      child: ElevatedButton(
        onPressed: isEnabled ? _handleClaim : null,
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
                    selectedMethod == RedemptionMethod.existing
                        ? Icons.redeem
                        : selectedMethod == RedemptionMethod.points 
                            ? Icons.auto_awesome
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
    if (selectedMethod == null) return 'Select a Method';

    switch (selectedMethod!) {
      case RedemptionMethod.existing:
        return 'Use Existing Coupon';
      case RedemptionMethod.points:
        return 'Claim with SavPoints';
      case RedemptionMethod.razorpay:
        return 'Pay & Get Coupon';
      case RedemptionMethod.membership:
        return 'Claim for FREE';
    }
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
            vendorName: widget.couponData.vendorName,
            status: firstUnusedCoupon.status,
            acquiredDate: DateTime.tryParse(firstUnusedCoupon.acquiredDate) ?? DateTime.now(),
            redeemedDate: null, // Unused coupons don't have redemption date
            expiryDate: DateTime.tryParse(widget.couponData.expiryDate) ?? DateTime.now(),
            uniqueCode: firstUnusedCoupon.uniqueCode,
            qrCode: null, // QR code may not be in unused coupon data
            discountType: widget.couponData.discountType.toString(),
            discountValue: widget.couponData.discountValue,
            minCartValue: widget.couponData.minCartValue,
            imageUrl: widget.couponData.imageUrl,
            isGifted: false, // Assuming unused coupons are not gifted
            giftedFromUserId: null,
            giftedToUserId: null,
            giftedDate: null,
            giftMessage: null,
          );
          
          result = await Navigator.of(context).push<bool>(
            MaterialPageRoute(
              builder: (context) => CouponConfirmationPage(
                userCoupon: userCoupon,
                confirmationType: CouponConfirmationType.use,
              ),
            ),
          ) ?? false;
        } else {
          throw Exception('No unused coupons available');
        }
      } else {
        // For new claims, use the "claim" confirmation type
        result = await Navigator.of(context).push<bool>(
          MaterialPageRoute(
            builder: (context) => CouponConfirmationPage(
              claimCoupon: widget.couponData,
              redemptionMethod: _getRedemptionMethodString(),
              confirmationType: CouponConfirmationType.claim,
            ),
          ),
        ) ?? false;
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
      case RedemptionMethod.points:
        return 'points';
      case RedemptionMethod.razorpay:
        return 'razorpay';
      case RedemptionMethod.membership:
        return 'membership';
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
}

enum RedemptionMethod { existing, points, razorpay, membership }
