import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../features/coupons/domain/services/coupon_service.dart';
import '../../features/coupons/data/models/coupon_claim_models.dart';

/// Page showing coupon redemption options after QR code verification
class CouponRedemptionOptionsPage extends StatefulWidget {
  const CouponRedemptionOptionsPage({
    super.key,
    required this.couponData,
  });

  final CouponCheckResponse couponData;

  @override
  State<CouponRedemptionOptionsPage> createState() => _CouponRedemptionOptionsPageState();
}

class _CouponRedemptionOptionsPageState extends State<CouponRedemptionOptionsPage> {
  CouponService get _couponService => GetIt.I<CouponService>();
  bool isProcessing = false;
  RedemptionMethod? selectedMethod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        title: const Text('Claim Coupon'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Coupon Details Card
            _buildCouponDetailsCard(),
            const SizedBox(height: 24),
            
            // Redemption Options
            _buildRedemptionOptions(),
            const SizedBox(height: 32),
            
            // Claim Button
            _buildClaimButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildCouponDetailsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFF6F3FCC), const Color(0xFF8E24AA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6F3FCC).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.couponData.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  widget.couponData.discountDisplay,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            widget.couponData.description,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.store, color: Colors.white, size: 16),
              const SizedBox(width: 8),
              Text(
                widget.couponData.vendorName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          if (widget.couponData.minCartValue > 0) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.shopping_cart, color: Colors.white, size: 16),
                const SizedBox(width: 8),
                Text(
                  'Min order: ₹${widget.couponData.minCartValue.toStringAsFixed(0)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRedemptionOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Choose Redemption Method',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        
        // Points Option
        _buildRedemptionOption(
          method: RedemptionMethod.points,
          icon: Icons.stars,
          title: 'Use Points',
          subtitle: '${widget.couponData.pointsCost} points required',
          color: const Color(0xFFFF9800),
          isEnabled: true, // TODO: Check user's points balance
        ),
        
        const SizedBox(height: 12),
        
        // Razorpay Option
        _buildRedemptionOption(
          method: RedemptionMethod.razorpay,
          icon: Icons.payment,
          title: 'Buy with Payment',
          subtitle: 'Pay ₹${widget.couponData.pointsCost} to claim',
          color: const Color(0xFF4CAF50),
          isEnabled: true,
        ),
        
        const SizedBox(height: 12),
        
        // Membership Option
        if (widget.couponData.userMaxRedemptions != null)
          _buildMembershipOption(),
      ],
    );
  }

  Widget _buildRedemptionOption({
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
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isEnabled ? color.withOpacity(0.1) : Colors.grey[200],
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isEnabled ? color : Colors.grey[400],
                size: 24,
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
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isEnabled ? Colors.black87 : Colors.grey[500],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: isEnabled ? Colors.grey[600] : Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: color,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMembershipOption() {
    final usedRedemptions = widget.couponData.userUsedRedemptions;
    final maxRedemptions = widget.couponData.userMaxRedemptions!;
    final remainingRedemptions = maxRedemptions - usedRedemptions;
    
    final isEnabled = remainingRedemptions > 0;
    final isSelected = selectedMethod == RedemptionMethod.membership;
    final color = const Color(0xFF6F3FCC);
    
    return GestureDetector(
      onTap: isEnabled ? () => setState(() => selectedMethod = RedemptionMethod.membership) : null,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isEnabled ? color.withOpacity(0.1) : Colors.grey[200],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.card_membership,
                color: isEnabled ? color : Colors.grey[400],
                size: 24,
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
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isEnabled ? Colors.black87 : Colors.grey[500],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: isEnabled ? color.withOpacity(0.1) : Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '$remainingRedemptions/$maxRedemptions',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: isEnabled ? color : Colors.grey[500],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isEnabled 
                        ? 'Use your membership benefits' 
                        : 'No redemptions remaining',
                    style: TextStyle(
                      fontSize: 14,
                      color: isEnabled ? Colors.grey[600] : Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: color,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildClaimButton() {
    final isEnabled = selectedMethod != null && !isProcessing;
    
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: isEnabled ? _handleClaim : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6F3FCC),
          foregroundColor: Colors.white,
          disabledBackgroundColor: Colors.grey[300],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          elevation: isEnabled ? 8 : 0,
          shadowColor: const Color(0xFF6F3FCC).withOpacity(0.3),
        ),
        child: isProcessing
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeWidth: 2,
                ),
              )
            : Text(
                _getButtonText(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }

  String _getButtonText() {
    if (selectedMethod == null) return 'Select a redemption method';
    
    switch (selectedMethod!) {
      case RedemptionMethod.points:
        return 'Claim with Points';
      case RedemptionMethod.razorpay:
        return 'Buy & Claim';
      case RedemptionMethod.membership:
        return 'Claim with Membership';
    }
  }

  Future<void> _handleClaim() async {
    if (selectedMethod == null) return;

    setState(() => isProcessing = true);

    try {
      // TODO: Implement different claiming methods based on selectedMethod
      switch (selectedMethod!) {
        case RedemptionMethod.points:
          await _claimWithPoints();
          break;
        case RedemptionMethod.razorpay:
          await _claimWithRazorpay();
          break;
        case RedemptionMethod.membership:
          await _claimWithMembership();
          break;
      }
    } catch (e) {
      _showErrorDialog(e.toString());
    } finally {
      setState(() => isProcessing = false);
    }
  }

  Future<void> _claimWithPoints() async {
    // TODO: Check if user has enough points
    final result = await _couponService.claimCouponWithPoints(
      widget.couponData.couponId,
      widget.couponData.pointsCost,
    );
    if (result.success) {
      _showSuccessDialog('Coupon claimed successfully with points!');
    } else {
      throw Exception(result.message);
    }
  }

  Future<void> _claimWithRazorpay() async {
    // TODO: Integrate with Razorpay payment
    // For now, use the purchase API
    final result = await _couponService.purchaseCoupon(
      widget.couponData.couponId,
      widget.couponData.pointsCost.toDouble(), // Using pointsCost as price for now
    );
    if (result.success) {
      _showSuccessDialog('Coupon purchased and claimed successfully!');
    } else {
      throw Exception(result.message);
    }
  }

  Future<void> _claimWithMembership() async {
    final result = await _couponService.claimCouponWithMembership(
      widget.couponData.couponId,
    );
    if (result.success) {
      _showSuccessDialog('Coupon claimed with membership benefits!');
    } else {
      throw Exception(result.message);
    }
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 24),
            SizedBox(width: 8),
            Text('Success!'),
          ],
        ),
        content: Text(message),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(context).pop(true); // Return to vendor page with success
              Navigator.of(context).pop(true); // Also close QR scanner
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6F3FCC),
              foregroundColor: Colors.white,
            ),
            child: const Text('Great!'),
          ),
        ],
      ),
    );
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
}

enum RedemptionMethod {
  points,
  razorpay,
  membership,
}
