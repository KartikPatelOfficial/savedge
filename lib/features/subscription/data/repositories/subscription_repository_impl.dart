import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../shared/domain/entities/subscription.dart';
import '../../domain/repositories/subscription_repository.dart';
import '../datasources/subscription_remote_data_source.dart';
import '../models/subscription_models.dart';

/// Implementation of SubscriptionRepository
class SubscriptionRepositoryImpl implements SubscriptionRepository {
  final SubscriptionRemoteDataSource remoteDataSource;

  SubscriptionRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<SubscriptionPlan>>> getSubscriptionPlans() async {
    try {
      final result = await remoteDataSource.getSubscriptionPlans();
      final plans = result.map((model) => model.toDomain()).toList();
      return Right(plans);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(
        ServerFailure('Failed to get subscription plans: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, UserSubscription?>> getUserSubscription() async {
    try {
      final result = await remoteDataSource.getUserSubscription();
      if (result == null) return const Right(null);
      return Right(result.toDomain());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(
        ServerFailure('Failed to get user subscription: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> purchaseSubscription({
    required int planId,
    bool autoRenew = false,
  }) async {
    try {
      final request = PurchaseSubscriptionRequestModel(
        planId: planId,
        autoRenew: autoRenew,
      );

      await remoteDataSource.purchaseSubscription(request);
      return const Right(true);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(
        ServerFailure('Failed to purchase subscription: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> purchaseSubscriptionWithPoints({
    required int planId,
    bool autoRenew = false,
  }) async {
    try {
      final request = PurchaseSubscriptionWithPointsRequestModel(
        planId: planId,
        autoRenew: autoRenew,
      );

      final result = await remoteDataSource.purchaseSubscriptionWithPoints(
        request,
      );
      return Right({
        'message': result.message,
        'pointsSpent': result.pointsSpent,
        'bonusPoints': result.bonusPoints,
        'newBalance': result.newBalance,
        'subscriptionId': result.subscriptionId,
      });
    } on ServerException catch (e) {
      // Handle specific error cases
      if (e.message.contains('Insufficient points')) {
        return Left(InsufficientPointsFailure(e.message));
      } else if (e.message.contains('already have an active subscription')) {
        return Left(ExistingSubscriptionFailure(e.message));
      }
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(
        ServerFailure(
          'Failed to purchase subscription with points: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> createPaymentOrder({
    required int planId,
    bool autoRenew = false,
  }) async {
    try {
      final request = CreatePaymentOrderRequestModel(
        planId: planId,
        autoRenew: autoRenew,
      );

      final result = await remoteDataSource.createPaymentOrder(request);
      return Right({
        'orderId': result.orderId,
        'amount': result.amount,
        'currency': result.currency,
        'receipt': result.receipt,
        'transactionId': result.transactionId,
        'planDetails': result.planDetails.toDomain(),
      });
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(
        ServerFailure('Failed to create payment order: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> verifyPayment({
    required int transactionId,
    required String razorpayOrderId,
    required String razorpayPaymentId,
    required String razorpaySignature,
    bool autoRenew = false,
  }) async {
    try {
      final request = VerifyPaymentRequestModel(
        transactionId: transactionId,
        razorpayOrderId: razorpayOrderId,
        razorpayPaymentId: razorpayPaymentId,
        razorpaySignature: razorpaySignature,
        autoRenew: autoRenew,
      );

      final result = await remoteDataSource.verifyPayment(request);
      return Right({
        'success': result.success,
        'message': result.message,
        'subscriptionId': result.subscriptionId,
        'subscription': result.subscription.toDomain(),
        'bonusPointsAwarded': result.bonusPointsAwarded,
      });
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to verify payment: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, PaymentTransaction>> getPaymentStatus(
    int transactionId,
  ) async {
    try {
      final result = await remoteDataSource.getPaymentStatus(transactionId);
      return Right(result.toDomain());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(
        ServerFailure('Failed to get payment status: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, List<PaymentTransaction>>> getPaymentHistory() async {
    try {
      final result = await remoteDataSource.getPaymentHistory();
      final transactions = result.map((model) => model.toDomain()).toList();
      return Right(transactions);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(
        ServerFailure('Failed to get payment history: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> cancelSubscription(int subscriptionId) async {
    try {
      await remoteDataSource.cancelSubscription(subscriptionId);
      return const Right(true);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(
        ServerFailure('Failed to cancel subscription: ${e.toString()}'),
      );
    }
  }
}

/// Custom failure types for subscription-specific errors
class InsufficientPointsFailure extends Failure {
  const InsufficientPointsFailure(String message) : super(message);
}

class ExistingSubscriptionFailure extends Failure {
  const ExistingSubscriptionFailure(String message) : super(message);
}
