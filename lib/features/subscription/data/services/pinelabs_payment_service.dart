import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:savedge/core/constants/app_constants.dart';
import 'package:savedge/features/subscription/data/models/payment_models.dart';

/// Service for handling PineLabs redirect-based payments
class PineLabsPaymentService {
  final Dio _dio;
  Timer? _statusPollingTimer;

  PineLabsPaymentService(this._dio);

  /// Creates a payment order and returns the redirect URL
  Future<CreatePaymentOrderResponse> createPaymentOrder({
    required int planId,
    bool autoRenew = false,
  }) async {
    try {
      final response = await _dio.post(
        '${AppConstants.baseUrl}/api/subscriptions/create-payment-order',
        data: {
          'planId': planId,
          'autoRenew': autoRenew,
        },
      );

      if (response.statusCode == 200) {
        return CreatePaymentOrderResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to create payment order: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      debugPrint('PineLabs createPaymentOrder error: ${e.message}');
      throw Exception(e.response?.data?['message'] ?? 'Failed to create payment order');
    }
  }

  /// Opens the payment URL in the default browser
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

  /// Checks the payment status
  Future<PaymentStatusResponse> checkPaymentStatus(int transactionId) async {
    try {
      final response = await _dio.get(
        '${AppConstants.baseUrl}/api/subscriptions/payment-status/$transactionId',
      );

      if (response.statusCode == 200) {
        return PaymentStatusResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to check payment status');
      }
    } on DioException catch (e) {
      debugPrint('PineLabs checkPaymentStatus error: ${e.message}');
      throw Exception(e.response?.data?['message'] ?? 'Failed to check payment status');
    }
  }

  /// Starts polling for payment status
  /// Returns a stream of payment status updates
  Stream<PaymentStatusResponse> pollPaymentStatus({
    required int transactionId,
    Duration interval = const Duration(seconds: 3),
    Duration timeout = const Duration(minutes: 5),
  }) async* {
    final startTime = DateTime.now();

    while (DateTime.now().difference(startTime) < timeout) {
      try {
        final status = await checkPaymentStatus(transactionId);
        yield status;

        // Stop polling if payment is complete or failed
        if (status.status == 'Success' || status.status == 'Failed') {
          break;
        }

        await Future.delayed(interval);
      } catch (e) {
        debugPrint('Error polling payment status: $e');
        await Future.delayed(interval);
      }
    }
  }

  /// Process a subscription payment (complete flow)
  Future<PaymentResult> processSubscriptionPayment({
    required int planId,
    bool autoRenew = false,
  }) async {
    try {
      // 1. Create payment order
      final orderResponse = await createPaymentOrder(
        planId: planId,
        autoRenew: autoRenew,
      );

      // 2. Open payment URL in browser
      final launched = await openPaymentUrl(orderResponse.redirectUrl);
      if (!launched) {
        return PaymentResult(
          success: false,
          message: 'Could not open payment page',
        );
      }

      // Return the transaction ID for status polling
      return PaymentResult(
        success: true,
        message: 'Payment page opened',
        transactionId: orderResponse.transactionId,
        orderId: orderResponse.orderId,
      );
    } catch (e) {
      return PaymentResult(
        success: false,
        message: e.toString(),
      );
    }
  }

  /// Purchase subscription with points
  Future<PurchaseSubscriptionResponse> purchaseWithPoints({
    required int planId,
    bool autoRenew = false,
  }) async {
    try {
      final response = await _dio.post(
        '${AppConstants.baseUrl}/api/subscriptions/purchase-with-points',
        data: {
          'planId': planId,
          'autoRenew': autoRenew,
        },
      );

      if (response.statusCode == 200) {
        return PurchaseSubscriptionResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to purchase subscription');
      }
    } on DioException catch (e) {
      debugPrint('PineLabs purchaseWithPoints error: ${e.message}');
      throw Exception(e.response?.data?['message'] ?? 'Failed to purchase subscription');
    }
  }

  void dispose() {
    _statusPollingTimer?.cancel();
  }
}

/// Result of a payment operation
class PaymentResult {
  final bool success;
  final String message;
  final int? transactionId;
  final String? orderId;

  PaymentResult({
    required this.success,
    required this.message,
    this.transactionId,
    this.orderId,
  });
}
