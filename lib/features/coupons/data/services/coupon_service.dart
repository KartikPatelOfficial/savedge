import 'package:get_it/get_it.dart';

import 'package:savedge/core/network/network_client.dart';
import 'package:savedge/features/coupons/data/models/coupon_claim_models.dart';
import 'package:savedge/features/coupons/data/models/user_coupon_model.dart';

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

  /// Get user's claimed coupons
  Future<UserCouponsResponse> getUserCoupons({
    int? pageNumber,
    int? pageSize,
    String? status, // 'active', 'used', 'expired'
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (pageNumber != null) queryParams['pageNumber'] = pageNumber;
      if (pageSize != null) queryParams['pageSize'] = pageSize;
      if (status != null) queryParams['status'] = status;

      final response = await _httpClient.get(
        '/api/user/coupons',
        queryParameters: queryParams,
      );

      // Handle direct array response
      final List<dynamic> couponsData;
      if (response.data is List) {
        couponsData = response.data as List<dynamic>;
      } else if (response.data is Map && (response.data as Map).containsKey('data')) {
        couponsData = (response.data as Map)['data'] as List<dynamic>;
      } else {
        couponsData = [];
      }

      final coupons = couponsData
          .map((coupon) => UserCouponModel.fromJson(coupon as Map<String, dynamic>))
          .toList();

      // Calculate statistics
      final totalCount = coupons.length;
      final activeCount = coupons.where((c) => c.isValid).length;
      final usedCount = coupons.where((c) => c.isUsed).length;
      final expiredCount = coupons.where((c) => c.isExpired && !c.isUsed).length;

      return UserCouponsResponse(
        success: true,
        message: 'Coupons loaded successfully',
        coupons: coupons,
        totalCount: totalCount,
        activeCount: activeCount,
        usedCount: usedCount,
        expiredCount: expiredCount,
      );
    } catch (e) {
      throw Exception('Failed to get user coupons: $e');
    }
  }
}