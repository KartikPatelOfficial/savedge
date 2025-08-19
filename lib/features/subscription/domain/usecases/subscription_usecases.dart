import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../shared/domain/entities/subscription.dart';
import '../repositories/subscription_repository.dart';

/// Use case for getting all subscription plans
class GetSubscriptionPlansUseCase
    implements UseCase<List<SubscriptionPlan>, NoParams> {
  final SubscriptionRepository repository;

  GetSubscriptionPlansUseCase(this.repository);

  @override
  Future<Either<Failure, List<SubscriptionPlan>>> call(NoParams params) async {
    return await repository.getSubscriptionPlans();
  }
}

/// Use case for getting user's current subscription
class GetUserSubscriptionUseCase
    implements UseCase<UserSubscription?, NoParams> {
  final SubscriptionRepository repository;

  GetUserSubscriptionUseCase(this.repository);

  @override
  Future<Either<Failure, UserSubscription?>> call(NoParams params) async {
    return await repository.getUserSubscription();
  }
}

/// Use case for purchasing subscription with currency
class PurchaseSubscriptionUseCase
    implements UseCase<bool, PurchaseSubscriptionParams> {
  final SubscriptionRepository repository;

  PurchaseSubscriptionUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(PurchaseSubscriptionParams params) async {
    return await repository.purchaseSubscription(
      planId: params.planId,
      autoRenew: params.autoRenew,
    );
  }
}

/// Use case for purchasing subscription with points
class PurchaseSubscriptionWithPointsUseCase
    implements UseCase<Map<String, dynamic>, PurchaseSubscriptionParams> {
  final SubscriptionRepository repository;

  PurchaseSubscriptionWithPointsUseCase(this.repository);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(
    PurchaseSubscriptionParams params,
  ) async {
    return await repository.purchaseSubscriptionWithPoints(
      planId: params.planId,
      autoRenew: params.autoRenew,
    );
  }
}

/// Use case for creating payment order
class CreatePaymentOrderUseCase
    implements UseCase<Map<String, dynamic>, PurchaseSubscriptionParams> {
  final SubscriptionRepository repository;

  CreatePaymentOrderUseCase(this.repository);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(
    PurchaseSubscriptionParams params,
  ) async {
    return await repository.createPaymentOrder(
      planId: params.planId,
      autoRenew: params.autoRenew,
    );
  }
}

/// Use case for verifying payment
class VerifyPaymentUseCase
    implements UseCase<Map<String, dynamic>, VerifyPaymentParams> {
  final SubscriptionRepository repository;

  VerifyPaymentUseCase(this.repository);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(
    VerifyPaymentParams params,
  ) async {
    return await repository.verifyPayment(
      transactionId: params.transactionId,
      razorpayOrderId: params.razorpayOrderId,
      razorpayPaymentId: params.razorpayPaymentId,
      razorpaySignature: params.razorpaySignature,
      autoRenew: params.autoRenew,
    );
  }
}

/// Use case for getting payment status
class GetPaymentStatusUseCase
    implements UseCase<PaymentTransaction, GetPaymentStatusParams> {
  final SubscriptionRepository repository;

  GetPaymentStatusUseCase(this.repository);

  @override
  Future<Either<Failure, PaymentTransaction>> call(
    GetPaymentStatusParams params,
  ) async {
    return await repository.getPaymentStatus(params.transactionId);
  }
}

/// Use case for getting payment history
class GetPaymentHistoryUseCase
    implements UseCase<List<PaymentTransaction>, NoParams> {
  final SubscriptionRepository repository;

  GetPaymentHistoryUseCase(this.repository);

  @override
  Future<Either<Failure, List<PaymentTransaction>>> call(
    NoParams params,
  ) async {
    return await repository.getPaymentHistory();
  }
}

/// Use case for canceling subscription
class CancelSubscriptionUseCase
    implements UseCase<bool, CancelSubscriptionParams> {
  final SubscriptionRepository repository;

  CancelSubscriptionUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(CancelSubscriptionParams params) async {
    return await repository.cancelSubscription(params.subscriptionId);
  }
}

/// Parameters for purchasing subscription
class PurchaseSubscriptionParams extends Equatable {
  final int planId;
  final bool autoRenew;

  const PurchaseSubscriptionParams({
    required this.planId,
    this.autoRenew = false,
  });

  @override
  List<Object> get props => [planId, autoRenew];
}

/// Parameters for verifying payment
class VerifyPaymentParams extends Equatable {
  final int transactionId;
  final String razorpayOrderId;
  final String razorpayPaymentId;
  final String razorpaySignature;
  final bool autoRenew;

  const VerifyPaymentParams({
    required this.transactionId,
    required this.razorpayOrderId,
    required this.razorpayPaymentId,
    required this.razorpaySignature,
    this.autoRenew = false,
  });

  @override
  List<Object> get props => [
    transactionId,
    razorpayOrderId,
    razorpayPaymentId,
    razorpaySignature,
    autoRenew,
  ];
}

/// Parameters for getting payment status
class GetPaymentStatusParams extends Equatable {
  final int transactionId;

  const GetPaymentStatusParams({required this.transactionId});

  @override
  List<Object> get props => [transactionId];
}

/// Parameters for canceling subscription
class CancelSubscriptionParams extends Equatable {
  final int subscriptionId;

  const CancelSubscriptionParams({required this.subscriptionId});

  @override
  List<Object> get props => [subscriptionId];
}
