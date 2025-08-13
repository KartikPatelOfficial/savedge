import 'package:get_it/get_it.dart';

import 'package:savedge/core/network/network_client.dart';
import 'package:savedge/features/coupons/data/models/coupon_claim_models.dart';

/// Service class to handle coupon-related API calls
class CouponService {
  HttpClient get _httpClient => GetIt.I<HttpClient>();

  /// Check if a coupon can be redeemed
  Future<CouponCheckResponse> checkCoupon(int couponId) async {
    try {
      final response = await _httpClient.get('/api/coupons/$couponId/check');
      return CouponCheckResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
    } catch (e) {
      throw Exception('Failed to check coupon: $e');
    }
  }

  /// Claim a coupon for the current user
  Future<CouponClaimResponse> claimCoupon(int couponId) async {
    try {
      final requestData = {'couponId': couponId};

      final response = await _httpClient.post(
        '/api/user/coupons/claim',
        data: requestData,
      );

      return CouponClaimResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
    } catch (e) {
      throw Exception('Failed to claim coupon: $e');
    }
  }

  /// Claim a coupon using points
  Future<CouponClaimResponse> claimCouponWithPoints(
    int couponId,
    int pointsCost,
  ) async {
    try {
      final requestData = {
        'couponId': couponId,
        'paymentMethod': 'points',
        'pointsCost': pointsCost,
      };

      final response = await _httpClient.post(
        '/api/user/coupons/claim',
        data: requestData,
      );

      return CouponClaimResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
    } catch (e) {
      throw Exception('Failed to claim coupon with points: $e');
    }
  }

  /// Purchase and claim a coupon with payment
  Future<CouponClaimResponse> purchaseCoupon(
    int couponId,
    double amount,
  ) async {
    try {
      final requestData = {'couponId': couponId, 'amount': amount};

      final response = await _httpClient.post(
        '/api/user/coupons/purchase',
        data: requestData,
      );

      return CouponClaimResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
    } catch (e) {
      throw Exception('Failed to purchase coupon: $e');
    }
  }

  /// Claim a coupon using membership benefits
  Future<CouponClaimResponse> claimCouponWithMembership(int couponId) async {
    try {
      final requestData = {'couponId': couponId, 'paymentMethod': 'membership'};

      final response = await _httpClient.post(
        '/api/user/coupons/claim',
        data: requestData,
      );

      return CouponClaimResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
    } catch (e) {
      throw Exception('Failed to claim coupon with membership: $e');
    }
  }
}