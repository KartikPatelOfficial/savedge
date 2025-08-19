import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../shared/domain/entities/subscription.dart';

/// Repository interface for subscription management
abstract class SubscriptionRepository {
  /// Get all available subscription plans
  Future<Either<Failure, List<SubscriptionPlan>>> getSubscriptionPlans();

  /// Get user's current active subscription
  Future<Either<Failure, UserSubscription?>> getUserSubscription();

  /// Purchase subscription with currency (simple flow)
  Future<Either<Failure, bool>> purchaseSubscription({
    required int planId,
    bool autoRenew = false,
  });

  /// Purchase subscription using points
  Future<Either<Failure, Map<String, dynamic>>> purchaseSubscriptionWithPoints({
    required int planId,
    bool autoRenew = false,
  });

  /// Create payment order for Razorpay integration
  Future<Either<Failure, Map<String, dynamic>>> createPaymentOrder({
    required int planId,
    bool autoRenew = false,
  });

  /// Verify payment after successful Razorpay payment
  Future<Either<Failure, Map<String, dynamic>>> verifyPayment({
    required int transactionId,
    required String razorpayOrderId,
    required String razorpayPaymentId,
    required String razorpaySignature,
    bool autoRenew = false,
  });

  /// Get payment transaction status
  Future<Either<Failure, PaymentTransaction>> getPaymentStatus(
    int transactionId,
  );

  /// Get payment history for user
  Future<Either<Failure, List<PaymentTransaction>>> getPaymentHistory();

  /// Cancel subscription
  Future<Either<Failure, bool>> cancelSubscription(int subscriptionId);
}
