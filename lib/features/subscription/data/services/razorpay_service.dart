import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter/material.dart';
import '../../../../shared/domain/entities/subscription.dart';

/// Service for handling Razorpay payment integration
class RazorpayService {
  late Razorpay _razorpay;

  // Callbacks
  Function(PaymentSuccessResponse)? _onSuccess;
  Function(PaymentFailureResponse)? _onError;
  Function(ExternalWalletResponse)? _onExternalWallet;

  RazorpayService() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  /// Initialize payment for a subscription plan
  void openCheckout({
    required String orderId,
    required int amount, // Amount in paise
    required String receipt,
    required SubscriptionPlan plan,
    required String userEmail,
    required String userPhone,
    required String userName,
    Function(PaymentSuccessResponse)? onSuccess,
    Function(PaymentFailureResponse)? onError,
    Function(ExternalWalletResponse)? onExternalWallet,
  }) {
    _onSuccess = onSuccess;
    _onError = onError;
    _onExternalWallet = onExternalWallet;

    var options = {
      'key': _getRazorpayKey(),
      'amount': amount, // Amount in paise
      'currency': 'INR',
      'name': 'SavEdge',
      'description': 'Subscription: ${plan.name}',
      'order_id': orderId,
      'receipt': receipt,
      'prefill': {'contact': userPhone, 'email': userEmail, 'name': userName},
      'external': {
        'wallets': ['paytm'],
      },
      'theme': {
        'color': '#2196F3', // Your app's primary color
      },
      'modal': {
        'ondismiss': () {
          debugPrint('Payment dismissed');
        },
      },
      'notes': {
        'plan_id': plan.id.toString(),
        'plan_name': plan.name,
        'duration': plan.durationText,
        'bonus_points': plan.bonusPoints.toString(),
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error opening Razorpay: $e');
      if (_onError != null) {
        _onError!(
          PaymentFailureResponse(-1, 'Failed to open payment gateway', null),
        );
      }
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    debugPrint('Payment Success: ${response.paymentId}');
    _onSuccess?.call(response);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    debugPrint('Payment Error: ${response.code} - ${response.message}');
    _onError?.call(response);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    debugPrint('External Wallet: ${response.walletName}');
    _onExternalWallet?.call(response);
  }

  /// Get Razorpay key based on environment
  String _getRazorpayKey() {
    // TODO: Replace with your actual Razorpay key
    // In production, use environment variables or secure storage
    const isProduction = bool.fromEnvironment('dart.vm.product');
    if (isProduction) {
      return 'rzp_live_YOUR_LIVE_KEY'; // Replace with live key
    } else {
      return 'rzp_test_YOUR_TEST_KEY'; // Replace with test key
    }
  }

  /// Dispose resources
  void dispose() {
    _razorpay.clear();
    _onSuccess = null;
    _onError = null;
    _onExternalWallet = null;
  }
}

/// Payment result data class
class PaymentResult {
  final bool success;
  final String? paymentId;
  final String? orderId;
  final String? signature;
  final String? errorMessage;
  final int? errorCode;

  PaymentResult({
    required this.success,
    this.paymentId,
    this.orderId,
    this.signature,
    this.errorMessage,
    this.errorCode,
  });

  factory PaymentResult.success({
    required String paymentId,
    required String orderId,
    required String signature,
  }) {
    return PaymentResult(
      success: true,
      paymentId: paymentId,
      orderId: orderId,
      signature: signature,
    );
  }

  factory PaymentResult.failure({
    required String errorMessage,
    required int errorCode,
    String? orderId,
  }) {
    return PaymentResult(
      success: false,
      errorMessage: errorMessage,
      errorCode: errorCode,
      orderId: orderId,
    );
  }

  @override
  String toString() {
    if (success) {
      return 'PaymentResult.success(paymentId: $paymentId, orderId: $orderId)';
    } else {
      return 'PaymentResult.failure(errorCode: $errorCode, errorMessage: $errorMessage)';
    }
  }
}
