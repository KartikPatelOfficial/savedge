import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../data/models/coupon_gifting_models.dart';

class ModernCouponCard extends StatefulWidget {
  const ModernCouponCard({
    super.key,
    required this.coupon,
    this.isGridView = false,
    this.onTap,
    this.onGift,
  });

  final UserCouponDetailModel coupon;
  final bool isGridView;
  final VoidCallback? onTap;
  final VoidCallback? onGift;

  @override
  State<ModernCouponCard> createState() => _ModernCouponCardState();
}

class _ModernCouponCardState extends State<ModernCouponCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _shadowAnimation;
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
    _shadowAnimation = Tween<double>(begin: 1.0, end: 0.5).animate(
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
    return widget.isGridView ? _buildGridCard() : _buildListCard();
  }

  Widget _buildGridCard() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(
                    0.08 * _shadowAnimation.value,
                  ),
                  blurRadius: 20 * _shadowAnimation.value,
                  offset: Offset(0, 8 * _shadowAnimation.value),
                ),
              ],
            ),
            child: Material(
              borderRadius: BorderRadius.circular(20),
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                onTap: widget.onTap ?? () => _handleCardTap(context),
                onTapDown: (_) {
                  setState(() => _isPressed = true);
                  _animationController.forward();
                },
                onTapUp: (_) {
                  setState(() => _isPressed = false);
                  _animationController.reverse();
                },
                onTapCancel: () {
                  setState(() => _isPressed = false);
                  _animationController.reverse();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCardHeader(),
                      Expanded(child: _buildCardContent()),
                      _buildCardFooter(),
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

  Widget _buildListCard() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(
                    0.06 * _shadowAnimation.value,
                  ),
                  blurRadius: 15 * _shadowAnimation.value,
                  offset: Offset(0, 4 * _shadowAnimation.value),
                ),
              ],
            ),
            child: Material(
              borderRadius: BorderRadius.circular(20),
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                onTap: widget.onTap ?? () => _handleCardTap(context),
                onTapDown: (_) {
                  setState(() => _isPressed = true);
                  _animationController.forward();
                },
                onTapUp: (_) {
                  setState(() => _isPressed = false);
                  _animationController.reverse();
                },
                onTapCancel: () {
                  setState(() => _isPressed = false);
                  _animationController.reverse();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      _buildListCardLeft(),
                      Expanded(child: _buildListCardRight()),
                      _buildListCardActions(),
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

  Widget _buildCardHeader() {
    final gradient = _getCouponGradient();
    final badge = _getCouponBadge();

    return Container(
      height: 120,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Stack(
        children: [
          // Decorative elements
          Positioned(
            top: -20,
            right: -20,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          Positioned(
            bottom: -10,
            left: -10,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          // Badge
          if (badge != null)
            Positioned(
              top: 12,
              left: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      badge['icon'] as IconData,
                      size: 12,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      badge['text'] as String,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          // Discount value
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getDiscountDisplay(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _getCouponTypeText(),
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardContent() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.coupon.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
              height: 1.3,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: const Color(0xFF6F3FCC).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(
                  Icons.store_outlined,
                  size: 14,
                  color: Color(0xFF6F3FCC),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  widget.coupon.vendorName,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const Spacer(),
          _buildExpiryInfo(),
        ],
      ),
    );
  }

  Widget _buildCardFooter() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          _buildStatusChip(),
          const Spacer(),
          if (_canUse())
            Icon(Icons.touch_app_rounded, size: 18, color: Colors.grey[600]),
        ],
      ),
    );
  }

  Widget _buildListCardLeft() {
    final gradient = _getCouponGradient();

    return Container(
      width: 100,
      height: 140,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
      ),
      child: Stack(
        children: [
          // Decorative circle
          Positioned(
            top: -10,
            right: -10,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          // Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.local_offer_rounded,
                  color: Colors.white,
                  size: 28,
                ),
                const SizedBox(height: 8),
                Text(
                  _getDiscountDisplay(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  _getCouponTypeText(),
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListCardRight() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.coupon.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
              height: 1.2,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: const Color(0xFF6F3FCC).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Icon(
                  Icons.store_outlined,
                  size: 12,
                  color: Color(0xFF6F3FCC),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  widget.coupon.vendorName,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            widget.coupon.description!,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
              height: 1.3,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          Row(
            children: [_buildStatusChip(), const Spacer(), _buildExpiryInfo()],
          ),
        ],
      ),
    );
  }

  Widget _buildListCardActions() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          if (widget.onGift != null && _canGift())
            Container(
              width: 40,
              height: 40,
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFEF4444).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                onPressed: widget.onGift,
                icon: const Icon(
                  Icons.card_giftcard_rounded,
                  size: 20,
                  color: Color(0xFFEF4444),
                ),
              ),
            ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF6F3FCC).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: () => _showCouponCode(context),
              icon: const Icon(
                Icons.qr_code_rounded,
                size: 20,
                color: Color(0xFF6F3FCC),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip() {
    final status = _getStatus();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: status['color'].withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: status['color'].withOpacity(0.3), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(status['icon'], size: 12, color: status['color']),
          const SizedBox(width: 4),
          Text(
            status['text'],
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: status['color'],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpiryInfo() {
    final expiryText = _getExpiryText();
    final isExpiringSoon = _isExpiringSoon();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.schedule_rounded,
          size: 14,
          color: isExpiringSoon ? const Color(0xFFEF4444) : Colors.grey[500],
        ),
        const SizedBox(width: 4),
        Text(
          expiryText,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isExpiringSoon ? const Color(0xFFEF4444) : Colors.grey[600],
          ),
        ),
      ],
    );
  }

  LinearGradient _getCouponGradient() {
    if (!_canUse()) {
      return LinearGradient(colors: [Colors.grey[400]!, Colors.grey[500]!]);
    }

    switch (widget.coupon.discountType.toLowerCase()) {
      case 'percentage':
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
        );
      case 'fixedamount':
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF10B981), Color(0xFF059669)],
        );
      default:
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFF6B6B), Color(0xFFEE5A24)],
        );
    }
  }

  Map<String, dynamic>? _getCouponBadge() {
    if (widget.coupon.isGifted) {
      return {'text': 'GIFT', 'icon': Icons.card_giftcard_rounded};
    }

    if (_isExpiringSoon()) {
      return {'text': 'EXPIRING', 'icon': Icons.schedule_rounded};
    }

    if (widget.coupon.discountValue >= 50) {
      return {'text': 'HOT DEAL', 'icon': Icons.local_fire_department_rounded};
    }

    return null;
  }

  Map<String, dynamic> _getStatus() {
    if (widget.coupon.status.toLowerCase() == 'used') {
      return {
        'text': 'Used',
        'color': const Color(0xFF10B981),
        'icon': Icons.check_circle_rounded,
      };
    }

    if (_isExpired()) {
      return {
        'text': 'Expired',
        'color': const Color(0xFFEF4444),
        'icon': Icons.schedule_rounded,
      };
    }

    return {
      'text': 'Active',
      'color': const Color(0xFF6F3FCC),
      'icon': Icons.local_offer_rounded,
    };
  }

  String _getDiscountDisplay() {
    if (widget.coupon.discountType.toLowerCase() == 'percentage') {
      return '${widget.coupon.discountValue.toInt()}% OFF';
    }
    return '₹${widget.coupon.discountValue.toInt()} OFF';
  }

  String _getCouponTypeText() {
    if (widget.coupon.isGifted) return 'GIFT COUPON';
    if (widget.coupon.discountType.toLowerCase() == 'percentage') {
      return 'PERCENTAGE OFF';
    }
    return 'FLAT DISCOUNT';
  }

  String _getExpiryText() {
    final now = DateTime.now();
    final expiry = widget.coupon.expiryDate;
    final difference = expiry.difference(now).inDays;

    if (difference < 0) {
      return 'Expired';
    } else if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Tomorrow';
    } else if (difference <= 7) {
      return '$difference days left';
    } else {
      return '${expiry.day}/${expiry.month}/${expiry.year}';
    }
  }

  bool _isExpired() {
    return DateTime.now().isAfter(widget.coupon.expiryDate);
  }

  bool _isExpiringSoon() {
    final difference = widget.coupon.expiryDate
        .difference(DateTime.now())
        .inDays;
    return difference <= 7 && difference > 0;
  }

  bool _canUse() {
    return widget.coupon.status.toLowerCase() == 'active' && !_isExpired();
  }

  bool _canGift() {
    return _canUse() && !widget.coupon.isGifted;
  }

  void _handleCardTap(BuildContext context) {
    if (_canUse()) {
      // Navigate to coupon usage page
      _showCouponCode(context);
    } else {
      _showCouponInfo(context);
    }
  }

  void _showCouponCode(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  gradient: _getCouponGradient(),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.qr_code_rounded,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Coupon Code',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.coupon.uniqueCode,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF6F3FCC),
                          letterSpacing: 2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Clipboard.setData(
                          ClipboardData(text: widget.coupon.uniqueCode),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Code copied to clipboard!'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      icon: const Icon(Icons.copy_rounded),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6F3FCC),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Got it',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCouponInfo(BuildContext context) {
    final status = _getStatus();
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: status['color'].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(status['icon'], color: status['color'], size: 40),
              ),
              const SizedBox(height: 24),
              Text(
                status['text'],
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                widget.coupon.status.toLowerCase() == 'used'
                    ? 'This coupon has been used successfully.'
                    : 'This coupon has expired and cannot be used.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  color: Color(0xFF64748B),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6F3FCC),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Got it',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
