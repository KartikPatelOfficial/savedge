import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../data/models/coupon_gifting_models.dart';

class ElegantCouponCard extends StatefulWidget {
  const ElegantCouponCard({
    super.key,
    required this.coupon,
    this.onTap,
  });

  final UserCouponDetailModel coupon;
  final VoidCallback? onTap;

  @override
  State<ElegantCouponCard> createState() => _ElegantCouponCardState();
}

class _ElegantCouponCardState extends State<ElegantCouponCard> {

  @override
  Widget build(BuildContext context) {
    final isActive = _isActiveStatus();
    final theme = _getCardTheme();

    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isActive 
              ? theme['primary']!.withOpacity(0.3)
              : Colors.grey.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: widget.onTap ?? () => _handleTap(context),
          child: Row(
            children: [
              // Left section - Discount
              _buildDiscountSection(theme, isActive),
              
              // Divider
              Container(
                width: 1,
                height: 60,
                color: Colors.grey.withOpacity(0.2),
              ),
              
              // Right section - Details
              Expanded(
                child: _buildDetailsSection(isActive),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDiscountSection(Map<String, Color> theme, bool isActive) {
    return Container(
      width: 100,
      height: 120,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isActive ? theme['primary']!.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          bottomLeft: Radius.circular(12),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.coupon.discountDisplay,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: isActive ? theme['primary'] : Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            'OFF',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isActive ? theme['primary'] : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsSection(bool isActive) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Title and vendor
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.coupon.title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isActive ? Colors.black87 : Colors.grey[600],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                widget.coupon.vendorName,
                style: TextStyle(
                  fontSize: 12,
                  color: isActive ? Colors.grey[600] : Colors.grey[500],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                'ID: ${widget.coupon.id}',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey[500],
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          
          // Status and expiry
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatusChip(isActive),
              Text(
                _formatExpiryDate(),
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(bool isActive) {
    final status = widget.coupon.statusDisplay;
    Color chipColor;
    
    if (status == 'Active') {
      chipColor = Colors.green;
    } else if (status == 'Used') {
      chipColor = Colors.blue;
    } else if (status == 'Expired') {
      chipColor = Colors.red;
    } else {
      chipColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: chipColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: chipColor.withOpacity(0.3), width: 1),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: chipColor,
        ),
      ),
    );
  }

  String _formatExpiryDate() {
    final now = DateTime.now();
    final expiry = widget.coupon.expiryDate;
    final difference = expiry.difference(now).inDays;

    if (difference < 0) {
      return 'Expired';
    } else if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Tomorrow';
    } else if (difference <= 30) {
      return '${difference}d left';
    } else {
      return '${expiry.day}/${expiry.month}';
    }
  }

  // Helper methods
  bool _isActiveStatus() {
    return widget.coupon.status.toLowerCase() == 'active' && !_isExpired();
  }

  bool _isExpired() {
    return DateTime.now().isAfter(widget.coupon.expiryDate);
  }

  Map<String, Color> _getCardTheme() {
    if (widget.coupon.discountType.toLowerCase() == 'percentage') {
      return {
        'primary': const Color(0xFF2563EB),
        'secondary': const Color(0xFF1D4ED8),
      };
    } else {
      return {
        'primary': const Color(0xFF059669),
        'secondary': const Color(0xFF047857),
      };
    }
  }

  void _handleTap(BuildContext context) {
    if (_isActiveStatus()) {
      _showCouponDetails(context);
    } else {
      _showStatusInfo(context);
    }
  }

  void _showCouponDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Text(
                widget.coupon.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              
              // Coupon code
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Column(
                  children: [
                    Text(
                      'Coupon Code',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    SelectableText(
                      widget.coupon.uniqueCode,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2563EB),
                        letterSpacing: 2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: () {
                        Clipboard.setData(
                          ClipboardData(text: widget.coupon.uniqueCode),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Code copied!'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      icon: const Icon(Icons.copy_rounded, size: 16),
                      label: const Text('Copy Code'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2563EB),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              
              // Close button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Close'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showStatusInfo(BuildContext context) {
    String message;
    if (widget.coupon.status.toLowerCase() == 'used') {
      message = 'This coupon has been used.';
    } else {
      message = 'This coupon has expired.';
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(widget.coupon.statusDisplay),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}