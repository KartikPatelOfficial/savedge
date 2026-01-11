import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:savedge/core/network/network_client.dart';
import 'package:savedge/core/storage/secure_storage_service.dart';
import 'package:savedge/features/auth/domain/repositories/auth_repository.dart';

/// Service class to handle Pine Labs payment integration for coupon purchases
class CouponPaymentService {
  Timer? _statusPollingTimer;
  Function(CouponPaymentResult)? _onPaymentComplete;

  HttpClient get _httpClient => GetIt.I<HttpClient>();

  AuthRepository get _authRepository => GetIt.I<AuthRepository>();

  SecureStorageService get _secureStorage => GetIt.I<SecureStorageService>();

  /// Dispose resources
  void dispose() {
    _statusPollingTimer?.cancel();
  }

  /// Create payment order from backend for coupon purchase
  Future<Map<String, dynamic>> createPaymentOrder({
    required int couponId,
  }) async {
    try {
      final requestData = {'couponId': couponId};

      final response = await _httpClient.post(
        '/api/coupons/create-payment-order',
        data: requestData,
      );

      return response.data as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to create payment order for coupon: $e');
    }
  }

  /// Open payment URL in browser
  Future<bool> openPaymentUrl(String url) async {
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      return await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw Exception('Could not launch payment URL');
    }
  }

  /// Check payment status
  Future<Map<String, dynamic>> checkPaymentStatus(int transactionId) async {
    try {
      final response = await _httpClient.get(
        '/api/coupons/payment-status/$transactionId',
      );

      return response.data as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to check payment status: $e');
    }
  }

  /// Poll for payment status
  Stream<Map<String, dynamic>> pollPaymentStatus({
    required int transactionId,
    Duration interval = const Duration(seconds: 3),
    Duration timeout = const Duration(minutes: 5),
  }) async* {
    final startTime = DateTime.now();

    while (DateTime.now().difference(startTime) < timeout) {
      try {
        final status = await checkPaymentStatus(transactionId);
        yield status;

        final statusStr = status['status']?.toString() ?? '';
        // Stop polling if payment is complete or failed
        if (statusStr == 'Success' || statusStr == 'Failed') {
          break;
        }

        await Future.delayed(interval);
      } catch (e) {
        debugPrint('Error polling payment status: $e');
        await Future.delayed(interval);
      }
    }
  }

  /// Start payment flow - creates order and opens payment URL
  Future<CouponPaymentResult> startPayment({
    required int couponId,
  }) async {
    try {
      // Create payment order
      final paymentOrder = await createPaymentOrder(couponId: couponId);

      // Get redirect URL
      final redirectUrl = paymentOrder['redirectUrl'] as String?;
      if (redirectUrl == null || redirectUrl.isEmpty) {
        return CouponPaymentResult.failure(
          errorMessage: 'No payment URL received',
          errorCode: -1,
        );
      }

      // Open payment URL in browser
      final launched = await openPaymentUrl(redirectUrl);
      if (!launched) {
        return CouponPaymentResult.failure(
          errorMessage: 'Could not open payment page',
          errorCode: -2,
        );
      }

      // Return transaction info for status polling
      return CouponPaymentResult(
        success: true,
        transactionId: paymentOrder['transactionId'] as int?,
        orderId: paymentOrder['orderId'] as String?,
      );
    } catch (e) {
      return CouponPaymentResult.failure(
        errorMessage: e.toString(),
        errorCode: -3,
      );
    }
  }

  /// Verify payment with backend for coupon purchase (called after redirect return)
  Future<Map<String, dynamic>> verifyPayment({
    required int transactionId,
  }) async {
    try {
      final response = await _httpClient.get(
        '/api/coupons/payment-status/$transactionId',
      );

      return response.data as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to verify coupon payment: $e');
    }
  }

  /// Get user profile for payment prefill
  Future<Map<String, String>> _getUserInfoForPayment() async {
    try {
      final profile = await _authRepository.getUserProfileExtended();

      // Get phone number from user profile if available
      String phoneNumber = profile.phoneNumber ?? '';

      return {
        'name': '${profile.firstName ?? ''} ${profile.lastName ?? ''}'.trim(),
        'email': profile.email,
        'phone': phoneNumber,
      };
    } catch (e) {
      return {
        'name': 'User',
        'email': 'user@example.com',
        'phone': '+91999999999',
      };
    }
  }

  /// Complete flow: Create order, open payment page for coupon purchase
  Future<CouponPaymentResult> processCouponPayment({
    required int couponId,
    required BuildContext context,
    required Function(CouponPaymentResult) onComplete,
  }) async {
    try {
      _onPaymentComplete = onComplete;

      // Start payment flow
      final result = await startPayment(couponId: couponId);

      return result;
    } catch (e) {
      final result = CouponPaymentResult.failure(
        errorMessage: 'Failed to process coupon payment: $e',
        errorCode: -4,
      );
      onComplete(result);
      return result;
    }
  }
}

/// Payment result data class for coupons
class CouponPaymentResult {
  final bool success;
  final String? paymentId;
  final String? orderId;
  final int? transactionId;
  final String? errorMessage;
  final int? errorCode;
  final int? userCouponId;
  final String? uniqueCode;

  CouponPaymentResult({
    required this.success,
    this.paymentId,
    this.orderId,
    this.transactionId,
    this.errorMessage,
    this.errorCode,
    this.userCouponId,
    this.uniqueCode,
  });

  factory CouponPaymentResult.success({
    required String paymentId,
    required String orderId,
    required int userCouponId,
    required String uniqueCode,
  }) {
    return CouponPaymentResult(
      success: true,
      paymentId: paymentId,
      orderId: orderId,
      userCouponId: userCouponId,
      uniqueCode: uniqueCode,
    );
  }

  factory CouponPaymentResult.failure({
    required String errorMessage,
    required int errorCode,
    String? orderId,
  }) {
    return CouponPaymentResult(
      success: false,
      errorMessage: errorMessage,
      errorCode: errorCode,
      orderId: orderId,
    );
  }

  @override
  String toString() {
    if (success) {
      return 'CouponPaymentResult.success(paymentId: $paymentId, orderId: $orderId, userCouponId: $userCouponId)';
    } else {
      return 'CouponPaymentResult.failure(errorCode: $errorCode, errorMessage: $errorMessage)';
    }
  }
}
