import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../../core/network/network_client.dart';
import '../../../auth/domain/repositories/auth_repository.dart';

/// Service class to handle Razorpay payment integration for subscriptions
class RazorpayPaymentService {
  late Razorpay _razorpay;
  VoidCallback? _onPaymentSuccess;
  Function(String)? _onPaymentError;
  
  HttpClient get _httpClient => GetIt.I<HttpClient>();
  AuthRepository get _authRepository => GetIt.I<AuthRepository>();

  /// Initialize Razorpay
  void initialize() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  /// Dispose Razorpay instance
  void dispose() {
    _razorpay.clear();
  }

  /// Create payment order from backend
  Future<Map<String, dynamic>> createPaymentOrder({
    required int planId,
    required double amount,
    String currency = 'INR',
  }) async {
    try {
      final requestData = {
        'planId': planId,
        'amount': amount,
        'currency': currency,
      };

      final response = await _httpClient.post(
        '/api/subscriptions/create-payment-order',
        data: requestData,
      );

      return response.data as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to create payment order: $e');
    }
  }

  /// Start Razorpay payment
  Future<void> startPayment({
    required Map<String, dynamic> paymentOrder,
    required String customerName,
    required String customerEmail,
    required String customerPhone,
    required VoidCallback onSuccess,
    required Function(String) onError,
  }) async {
    _onPaymentSuccess = onSuccess;
    _onPaymentError = onError;

    var options = {
      'key': paymentOrder['key'],
      'amount': ((paymentOrder['amount'] as double) * 100).toInt(), // Amount in paise
      'name': 'SavEdge',
      'order_id': paymentOrder['razorpayOrderId'],
      'description': 'Subscription Plan Purchase',
      'prefill': {
        'contact': customerPhone,
        'email': customerEmail,
        'name': customerName,
      },
      'theme': {
        'color': '#2196F3',
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      _onPaymentError?.call('Failed to open payment gateway: $e');
    }
  }

  /// Verify payment with backend
  Future<Map<String, dynamic>> verifyPayment({
    required String razorpayPaymentId,
    required String razorpayOrderId,
    required String razorpaySignature,
    required int transactionId,
  }) async {
    try {
      final requestData = {
        'razorpayPaymentId': razorpayPaymentId,
        'razorpayOrderId': razorpayOrderId,
        'razorpaySignature': razorpaySignature,
        'transactionId': transactionId,
      };

      final response = await _httpClient.post(
        '/api/subscriptions/verify-payment',
        data: requestData,
      );

      return response.data as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to verify payment: $e');
    }
  }

  /// Purchase subscription using points
  Future<Map<String, dynamic>> purchaseWithPoints({
    required int planId,
    bool autoRenew = false,
  }) async {
    try {
      final requestData = {
        'planId': planId,
        'autoRenew': autoRenew,
        'paymentMethod': 'points',
      };

      final response = await _httpClient.post(
        '/api/user/subscription/purchase',
        data: requestData,
      );

      return response.data as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to purchase subscription with points: $e');
    }
  }

  /// Handle payment success
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print('Payment Success: ${response.paymentId}');
    _onPaymentSuccess?.call();
  }

  /// Handle payment error
  void _handlePaymentError(PaymentFailureResponse response) {
    print('Payment Error: ${response.code} - ${response.message}');
    _onPaymentError?.call('Payment failed: ${response.message}');
  }

  /// Handle external wallet
  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External Wallet: ${response.walletName}');
    _onPaymentError?.call('External wallet payments not supported');
  }

  /// Get user profile for payment prefill
  Future<Map<String, String>> _getUserInfoForPayment() async {
    try {
      final profile = await _authRepository.getUserProfileExtended();
      return {
        'name': '${profile.firstName ?? ''} ${profile.lastName ?? ''}'.trim(),
        'email': profile.email,
        'phone': '', // Add phone if available in profile
      };
    } catch (e) {
      return {
        'name': 'User',
        'email': 'user@example.com',
        'phone': '+91999999999',
      };
    }
  }

  /// Complete flow: Create order, start payment, verify payment
  Future<void> processSubscriptionPayment({
    required int planId,
    required double amount,
    required BuildContext context,
    required VoidCallback onSuccess,
    required Function(String) onError,
  }) async {
    try {
      // Step 1: Get user info
      final userInfo = await _getUserInfoForPayment();
      
      // Step 2: Create payment order
      final paymentOrder = await createPaymentOrder(
        planId: planId,
        amount: amount,
      );

      // Step 3: Start Razorpay payment
      await startPayment(
        paymentOrder: paymentOrder,
        customerName: userInfo['name']!,
        customerEmail: userInfo['email']!,
        customerPhone: userInfo['phone']!,
        onSuccess: () async {
          // This will be called by _handlePaymentSuccess
          // Additional verification will be handled by the UI
        },
        onError: onError,
      );
    } catch (e) {
      onError('Failed to process payment: $e');
    }
  }
}
