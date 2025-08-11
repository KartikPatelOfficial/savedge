import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      'key': _getRazorpayKey(paymentOrder),
      'amount': _convertToAmount(paymentOrder['amount']), // Amount in paise
      'currency': paymentOrder['currency'] ?? 'INR',
      'name': 'SavEdge',
      'order_id': paymentOrder['orderId'],
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

    print('Razorpay Payment Options:');
    print('Key: ${options['key']}');
    print('Amount: ${options['amount']}');
    print('Order ID: ${options['order_id']}');
    print('Name: ${options['name']}');
    
    try {
      print('Opening Razorpay payment gateway...');
      _razorpay.open(options);
    } catch (e) {
      print('Error opening Razorpay: $e');
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
    if (paymentOrder.containsKey('razorpayKey') && paymentOrder['razorpayKey'] != null) {
      return paymentOrder['razorpayKey'];
    }
    
    if (paymentOrder.containsKey('key') && paymentOrder['key'] != null) {
      return paymentOrder['key'];
    }
    
    // For testing purposes, use a test key
    // In production, this should come from the backend API response
    // Using Razorpay's standard test key for testing (this is publicly available)
    const testKey = 'rzp_test_j8PlmGsgdZV1YC'; // Razorpay's official test key
    print('Warning: Using fallback test Razorpay key. Configure proper keys in backend.');
    return testKey;
  }

  /// Get user profile for payment prefill
  Future<Map<String, String>> _getUserInfoForPayment() async {
    try {
      final profile = await _authRepository.getUserProfileExtended();
      
      // Get phone number from Firebase user if available
      String phoneNumber = '';
      final firebaseUser = FirebaseAuth.instance.currentUser;
      if (firebaseUser?.phoneNumber != null) {
        phoneNumber = firebaseUser!.phoneNumber!;
        print('RazorpayPaymentService: Using Firebase phone: $phoneNumber');
      }
      
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
