import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:savedge/core/constants/app_constants.dart';
import 'package:savedge/features/subscription/data/models/payment_models.dart';

/// Service for handling Razorpay native SDK payments
class RazorpayPaymentService {
  final Dio _dio;
  Razorpay? _razorpay;

  Completer<PaymentResult>? _paymentCompleter;

  RazorpayPaymentService(this._dio);

  Razorpay _getRazorpay() {
    _razorpay ??= Razorpay();
    _razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    return _razorpay!;
  }

  /// Creates a payment order on the backend
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
      debugPrint('Razorpay createPaymentOrder error: ${e.message}');
      throw Exception(e.response?.data?['message'] ?? 'Failed to create payment order');
    }
  }

  /// Opens Razorpay native checkout
  Future<PaymentResult> openCheckout({
    required String orderId,
    required int amount,
    required String keyId,
    String? userEmail,
    String? userName,
    String? userPhone,
    String? description,
  }) async {
    _paymentCompleter = Completer<PaymentResult>();

    final options = {
      'key': keyId,
      'amount': amount,
      'order_id': orderId,
      'name': 'SavEdge',
      'description': description ?? 'Subscription Payment',
      'timeout': 300, // 5 minutes
      'prefill': {
        if (userEmail != null) 'email': userEmail,
        if (userName != null) 'name': userName,
        if (userPhone != null) 'contact': userPhone,
      },
      'theme': {
        'color': '#059669',
      },
    };

    try {
      _getRazorpay().open(options);
    } catch (e) {
      _paymentCompleter?.complete(PaymentResult(
        success: false,
        message: 'Failed to open Razorpay checkout: $e',
      ));
    }

    return _paymentCompleter!.future;
  }

  /// Verifies the payment with the backend
  Future<VerifyPaymentResponse> verifyPayment({
    required int transactionId,
    required String razorpayOrderId,
    required String razorpayPaymentId,
    required String razorpaySignature,
    bool autoRenew = false,
  }) async {
    try {
      final response = await _dio.post(
        '${AppConstants.baseUrl}/api/subscriptions/verify-payment',
        data: {
          'transactionId': transactionId,
          'razorpayOrderId': razorpayOrderId,
          'razorpayPaymentId': razorpayPaymentId,
          'razorpaySignature': razorpaySignature,
          'autoRenew': autoRenew,
        },
      );

      if (response.statusCode == 200) {
        return VerifyPaymentResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to verify payment: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      debugPrint('Razorpay verifyPayment error: ${e.message}');
      throw Exception(e.response?.data?['message'] ?? 'Failed to verify payment');
    }
  }

  /// Creates a coupon payment order on the backend
  Future<Map<String, dynamic>> createCouponPaymentOrder({
    required int couponId,
  }) async {
    try {
      final response = await _dio.post(
        '${AppConstants.baseUrl}/api/coupons/create-payment-order',
        data: {'couponId': couponId},
      );

      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception('Failed to create coupon payment order');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data?['message'] ?? 'Failed to create coupon payment order');
    }
  }

  /// Verifies coupon payment with the backend
  Future<Map<String, dynamic>> verifyCouponPayment({
    required int transactionId,
    required String razorpayOrderId,
    required String razorpayPaymentId,
    required String razorpaySignature,
  }) async {
    try {
      final response = await _dio.post(
        '${AppConstants.baseUrl}/api/coupons/verify-payment',
        data: {
          'transactionId': transactionId,
          'razorpayPaymentId': razorpayPaymentId,
          'razorpayOrderId': razorpayOrderId,
          'razorpaySignature': razorpaySignature,
        },
      );

      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception('Failed to verify coupon payment');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data?['message'] ?? 'Failed to verify coupon payment');
    }
  }

  /// Checks the payment status (fallback)
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
      throw Exception(e.response?.data?['message'] ?? 'Failed to check payment status');
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
      throw Exception(e.response?.data?['message'] ?? 'Failed to purchase subscription');
    }
  }

  /// Complete subscription payment flow:
  /// 1. Create order on backend
  /// 2. Open Razorpay checkout
  /// 3. On success, verify payment with backend
  Future<PaymentResult> processSubscriptionPayment({
    required int planId,
    bool autoRenew = false,
    String? userEmail,
    String? userName,
    String? userPhone,
  }) async {
    try {
      // 1. Create payment order
      final orderResponse = await createPaymentOrder(
        planId: planId,
        autoRenew: autoRenew,
      );

      // 2. Open Razorpay checkout
      final checkoutResult = await openCheckout(
        orderId: orderResponse.orderId,
        amount: orderResponse.amount,
        keyId: orderResponse.razorpayKeyId,
        userEmail: userEmail,
        userName: userName,
        userPhone: userPhone,
        description: orderResponse.planDetails?.name ?? 'Subscription Payment',
      );

      if (!checkoutResult.success) {
        return checkoutResult;
      }

      // 3. Verify payment with backend
      final verifyResponse = await verifyPayment(
        transactionId: orderResponse.transactionId,
        razorpayOrderId: checkoutResult.razorpayOrderId!,
        razorpayPaymentId: checkoutResult.razorpayPaymentId!,
        razorpaySignature: checkoutResult.razorpaySignature!,
        autoRenew: autoRenew,
      );

      return PaymentResult(
        success: verifyResponse.success,
        message: verifyResponse.message,
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

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    _paymentCompleter?.complete(PaymentResult(
      success: true,
      message: 'Payment successful',
      razorpayPaymentId: response.paymentId,
      razorpayOrderId: response.orderId,
      razorpaySignature: response.signature,
    ));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    _paymentCompleter?.complete(PaymentResult(
      success: false,
      message: response.message ?? 'Payment failed',
    ));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    debugPrint('External wallet selected: ${response.walletName}');
  }

  void dispose() {
    _razorpay?.clear();
    _razorpay = null;
  }
}

/// Result of a payment operation
class PaymentResult {
  final bool success;
  final String message;
  final int? transactionId;
  final String? orderId;
  final String? razorpayPaymentId;
  final String? razorpayOrderId;
  final String? razorpaySignature;

  PaymentResult({
    required this.success,
    required this.message,
    this.transactionId,
    this.orderId,
    this.razorpayPaymentId,
    this.razorpayOrderId,
    this.razorpaySignature,
  });
}
