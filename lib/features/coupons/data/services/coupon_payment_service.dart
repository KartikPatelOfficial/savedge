import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:savedge/core/network/network_client.dart';
import 'package:savedge/core/storage/secure_storage_service.dart';
import 'package:savedge/features/auth/domain/repositories/auth_repository.dart';

/// Service class to handle Razorpay payment integration for coupon purchases
class CouponPaymentService {
  late Razorpay _razorpay;
  Function(PaymentSuccessResponse)? _onPaymentSuccess;
  Function(String)? _onPaymentError;

  HttpClient get _httpClient => GetIt.I<HttpClient>();

  AuthRepository get _authRepository => GetIt.I<AuthRepository>();

  SecureStorageService get _secureStorage => GetIt.I<SecureStorageService>();

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

  /// Start Razorpay payment for coupon
  Future<void> startPayment({
    required Map<String, dynamic> paymentOrder,
    required String customerName,
    required String customerEmail,
    required String customerPhone,
    required Function(PaymentSuccessResponse) onSuccess,
    required Function(String) onError,
  }) async {
    _onPaymentSuccess = onSuccess;
    _onPaymentError = onError;

    var options = {
      'key': _getRazorpayKey(paymentOrder),
      'amount': _convertToAmount(paymentOrder['amount']), // Amount in paise
      'currency': paymentOrder['currency'] ?? 'INR',
      'name': 'SavEdge',
      'order_id': paymentOrder['orderId'],
      'description':
          'Coupon Purchase: ${paymentOrder['couponDetails']?['title'] ?? 'Unknown'}',
      'prefill': {
        'contact': customerPhone,
        'email': customerEmail,
        'name': customerName,
      },
      'theme': {'color': '#2196F3'},
      'notes': {
        'coupon_id': paymentOrder['couponDetails']?['id']?.toString() ?? '',
        'coupon_title': paymentOrder['couponDetails']?['title'] ?? '',
        'vendor_name': paymentOrder['couponDetails']?['vendorName'] ?? '',
      },
    };

    print('Razorpay Coupon Payment Options:');
    print('Key: ${options['key']}');
    print('Amount: ${options['amount']}');
    print('Order ID: ${options['order_id']}');
    print('Coupon: ${options['description']}');

    try {
      print('Opening Razorpay payment gateway for coupon...');
      _razorpay.open(options);
    } catch (e) {
      print('Error opening Razorpay for coupon: $e');
      _onPaymentError?.call('Failed to open payment gateway: $e');
    }
  }

  /// Verify payment with backend for coupon purchase
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
        '/api/coupons/verify-payment',
        data: requestData,
      );

      return response.data as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to verify coupon payment: $e');
    }
  }

  /// Handle payment success
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print('Coupon Payment Success: ${response.paymentId}');
    _onPaymentSuccess?.call(response);
  }

  /// Handle payment error
  void _handlePaymentError(PaymentFailureResponse response) {
    print('Coupon Payment Error: ${response.code} - ${response.message}');
    _onPaymentError?.call('Payment failed: ${response.message}');
  }

  /// Handle external wallet
  void _handleExternalWallet(ExternalWalletResponse response) {
    print('Coupon Payment External Wallet: ${response.walletName}');
    _onPaymentError?.call('External wallet payments not supported');
  }

  /// Convert amount to paise for Razorpay (handles both int and double)
  int _convertToAmount(dynamic amount) {
    if (amount is int) {
      // If amount is already in paise, return as is
      return amount;
    } else if (amount is double) {
      // If amount is in rupees, convert to paise
      return (amount * 100).toInt();
    } else {
      throw Exception('Invalid amount type: ${amount.runtimeType}');
    }
  }

  /// Get Razorpay key from payment order or use default test key
  String _getRazorpayKey(Map<String, dynamic> paymentOrder) {
    // First try to get from payment order response
    if (paymentOrder.containsKey('razorpayKey') &&
        paymentOrder['razorpayKey'] != null) {
      return paymentOrder['razorpayKey'];
    }

    if (paymentOrder.containsKey('key') && paymentOrder['key'] != null) {
      return paymentOrder['key'];
    }

    // For testing purposes, use a test key
    // In production, this should come from the backend API response
    // Using Razorpay's standard test key for testing (this is publicly available)
    const testKey = 'rzp_test_j8PlmGsgdZV1YC'; // Razorpay's official test key
    print(
      'Warning: Using fallback test Razorpay key for coupon payment. Configure proper keys in backend.',
    );
    return testKey;
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

  /// Complete flow: Create order, start payment, verify payment for coupon purchase
  Future<Map<String, dynamic>> processCouponPayment({
    required int couponId,
    required BuildContext context,
    required Function(Map<String, dynamic>) onSuccess,
    required Function(String) onError,
  }) async {
    try {
      // Step 1: Get user info
      final userInfo = await _getUserInfoForPayment();

      // Step 2: Create payment order
      final paymentOrder = await createPaymentOrder(couponId: couponId);

      // Step 3: Start Razorpay payment
      await startPayment(
        paymentOrder: paymentOrder,
        customerName: userInfo['name']!,
        customerEmail: userInfo['email']!,
        customerPhone: userInfo['phone']!,
        onSuccess: (res) async {
          // Payment success callback - verification will be handled by caller
          // Return the paymentOrder for verification
        },
        onError: onError,
      );

      // Return payment order for use in verification
      return paymentOrder;
    } catch (e) {
      onError('Failed to process coupon payment: $e');
      rethrow;
    }
  }
}

/// Payment result data class for coupons
class CouponPaymentResult {
  final bool success;
  final String? paymentId;
  final String? orderId;
  final String? signature;
  final String? errorMessage;
  final int? errorCode;
  final int? userCouponId;
  final String? uniqueCode;

  CouponPaymentResult({
    required this.success,
    this.paymentId,
    this.orderId,
    this.signature,
    this.errorMessage,
    this.errorCode,
    this.userCouponId,
    this.uniqueCode,
  });

  factory CouponPaymentResult.success({
    required String paymentId,
    required String orderId,
    required String signature,
    required int userCouponId,
    required String uniqueCode,
  }) {
    return CouponPaymentResult(
      success: true,
      paymentId: paymentId,
      orderId: orderId,
      signature: signature,
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
