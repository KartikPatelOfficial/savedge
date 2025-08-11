import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:savedge/core/injection/injection.dart';
import 'package:savedge/features/vendors/domain/entities/coupon.dart';
import 'package:savedge/features/vendors/presentation/bloc/coupons_bloc.dart';
import 'package:savedge/presentation/qr_scanner/qr_scanner_page.dart';

/// Widget for displaying vendor-specific offers/coupons
class VendorOffersSection extends StatelessWidget {
  const VendorOffersSection({
    super.key,
    required this.vendorId,
    required this.vendorName,
    this.title = 'Offer for you',
  });

  final int vendorId;
  final String vendorName;
  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CouponsBloc>()
        ..add(LoadVendorCoupons(vendorId: vendorId)),
      child: VendorOffersView(
        title: title,
        vendorId: vendorId,
        vendorName: vendorName,
      ),
    );
  }
}

class VendorOffersView extends StatelessWidget {
  const VendorOffersView({
    super.key, 
    required this.title,
    required this.vendorId,
    required this.vendorName,
  });

  final String title;
  final int vendorId;
  final String vendorName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          BlocBuilder<CouponsBloc, CouponsState>(
            builder: (context, state) {
              if (state is CouponsLoading) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is CouponsError) {
                return _buildErrorWidget(state.message);
              } else if (state is CouponsLoaded) {
                return _buildCouponsList(state.coupons);
              }
              return _buildEmptyState();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCouponsList(List<Coupon> coupons) {
    if (coupons.isEmpty) {
      return _buildEmptyState();
    }

    return Column(
      children: coupons.map((coupon) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: VendorOfferCard(
          coupon: coupon,
          vendorId: vendorId,
          vendorName: vendorName,
        ),
      )).toList(),
    );
  }

  Widget _buildErrorWidget(String message) {
    return Center(
      child: Column(
        children: [
          Icon(Icons.error_outline, size: 48, color: Colors.grey[400]),
          const SizedBox(height: 8),
          Text(
            'Failed to load offers',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: TextStyle(fontSize: 12, color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        children: [
          Icon(Icons.local_offer_outlined, size: 48, color: Colors.grey[400]),
          const SizedBox(height: 8),
          Text(
            'No offers available',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          const SizedBox(height: 4),
          Text(
            'Check back later for new deals!',
            style: TextStyle(fontSize: 12, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }
}

/// Individual vendor offer card widget using real coupon data
class VendorOfferCard extends StatelessWidget {
  const VendorOfferCard({
    super.key, 
    required this.coupon,
    required this.vendorId,
    required this.vendorName,
  });

  final Coupon coupon;
  final int vendorId;
  final String vendorName;

  @override
  Widget build(BuildContext context) {
    final color = _getCouponColor();

    return GestureDetector(
      onTap: () => _onCouponTap(context),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Get ${coupon.discountDisplay}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    coupon.minimumAmountDisplay.isNotEmpty
                        ? coupon.minimumAmountDisplay
                        : coupon.title,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    coupon.termsAndConditions ?? 'Limited time offer',
                    style: const TextStyle(color: Colors.white70, fontSize: 11),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Use Coupon',
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getCouponColor() {
    // Determine color based on discount type
    switch (coupon.discountType.toLowerCase()) {
      case 'percentage':
        return const Color(0xFF6F3FCC);
      case 'fixedamount':
        return const Color(0xFF4CAF50);
      default:
        final colors = [
          const Color(0xFF6F3FCC),
          const Color(0xFFFF9800),
          const Color(0xFFE91E63),
          const Color(0xFF4CAF50),
        ];
        return colors[coupon.id % colors.length];
    }
  }

  void _onCouponTap(BuildContext context) async {
    try {
      // Navigate to QR scanner page
      final result = await Navigator.of(context).push<bool>(
        MaterialPageRoute(
          builder: (context) => QRScannerPage(
            couponId: coupon.id,
            expectedVendorId: vendorId,
            expectedVendorName: vendorName,
          ),
        ),
      );

      // Show result message
      if (result == true) {
        // Success - coupon was claimed
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Coupon "${coupon.title}" claimed successfully!'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 3),
          ),
        );
      } else if (result == false) {
        // Failed to claim coupon
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to claim coupon "${coupon.title}"'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
      // If result is null, user just cancelled/went back
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }
}
