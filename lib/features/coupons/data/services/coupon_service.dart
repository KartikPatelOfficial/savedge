import 'package:get_it/get_it.dart';
import 'package:savedge/core/network/network_client.dart';
import 'package:savedge/features/coupons/data/models/coupon_claim_models.dart';
import 'package:savedge/features/coupons/data/models/coupon_redemption_models.dart';
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

  /// Redeem a user's coupon by user coupon ID
  Future<void> redeemMyCoupon(int userCouponId) async {
    try {
      final response = await _httpClient.post(
        '/api/user/coupons/redeem',
        data: {'userCouponId': userCouponId},
      );

      // Check if response indicates success
      if (response.statusCode != 200) {
        throw Exception('Failed to redeem coupon');
      }
    } catch (e) {
      throw Exception('Failed to redeem coupon: $e');
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

      // Handle the new structured response format
      final List<dynamic> allCouponsData = [];
      int totalCount = 0;
      int activeCount = 0;
      int usedCount = 0;
      int giftedCount = 0;

      if (response.data is Map<String, dynamic>) {
        final data = response.data as Map<String, dynamic>;

        // Combine all coupon types into one list
        if (data.containsKey('purchasedCoupons') &&
            data['purchasedCoupons'] is List) {
          allCouponsData.addAll(data['purchasedCoupons'] as List<dynamic>);
        }
        if (data.containsKey('usedCoupons') && data['usedCoupons'] is List) {
          allCouponsData.addAll(data['usedCoupons'] as List<dynamic>);
        }
        if (data.containsKey('giftedReceivedCoupons') &&
            data['giftedReceivedCoupons'] is List) {
          allCouponsData.addAll(data['giftedReceivedCoupons'] as List<dynamic>);
        }
        if (data.containsKey('giftedSentCoupons') &&
            data['giftedSentCoupons'] is List) {
          allCouponsData.addAll(data['giftedSentCoupons'] as List<dynamic>);
        }

        // Use counts from API if available
        totalCount = data['totalCount'] as int? ?? allCouponsData.length;
        activeCount = data['activeCount'] as int? ?? 0;
        usedCount = data['usedCount'] as int? ?? 0;
        giftedCount = data['giftedCount'] as int? ?? 0;
      } else if (response.data is List) {
        // Fallback for old direct array response
        allCouponsData.addAll(response.data as List<dynamic>);
      }

      final coupons = allCouponsData
          .map(
            (coupon) =>
                UserCouponModel.fromJson(coupon as Map<String, dynamic>),
          )
          .toList();

      // Calculate expired count if not provided
      final expiredCount = coupons
          .where((c) => c.isExpired && !c.isUsed)
          .length;

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


  /// Claim a coupon from subscription
  Future<ClaimCouponResponse> claimCouponFromSubscription(int couponId) async {
    try {
      final request = ClaimFromSubscriptionRequest(couponId: couponId);

      final response = await _httpClient.post(
        '/api/user/coupons/claim/subscription',
        data: request.toJson(),
      );

      return ClaimCouponResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
    } catch (e) {
      // Extract more meaningful error messages from DioException
      String errorMessage = 'Failed to claim coupon from subscription';

      if (e.toString().contains('Bad Request')) {
        if (e.toString().contains('No active subscription')) {
          errorMessage = 'You need an active subscription to claim this coupon';
        } else if (e.toString().contains('not included in')) {
          errorMessage =
              'This coupon is not included in your subscription plan';
        } else if (e.toString().contains('exceeded')) {
          errorMessage =
              'You have reached the limit for this coupon in your subscription';
        } else if (e.toString().contains('one per user')) {
          errorMessage = 'You can only claim this coupon once';
        } else {
          errorMessage = 'Unable to claim coupon: ${e.toString()}';
        }
      }

      throw Exception(errorMessage);
    }
  }

  /// Purchase a coupon with payment
  Future<ClaimCouponResponse> purchaseCouponWithPayment(int couponId) async {
    try {
      final request = {'couponId': couponId, 'paymentMethod': 'razorpay'};

      final response = await _httpClient.post(
        '/api/user/coupons/purchase',
        data: request,
      );

      return ClaimCouponResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
    } catch (e) {
      throw Exception('Failed to purchase coupon: $e');
    }
  }
}
