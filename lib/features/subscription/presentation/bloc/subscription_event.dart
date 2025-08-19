part of 'subscription_bloc.dart';

/// Base class for all subscription events
abstract class SubscriptionEvent extends Equatable {
  const SubscriptionEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load all subscription plans
class LoadSubscriptionPlans extends SubscriptionEvent {
  const LoadSubscriptionPlans();
}

/// Event to load user's current subscription
class LoadUserSubscription extends SubscriptionEvent {
  const LoadUserSubscription();
}

/// Event to purchase subscription with currency
class PurchaseSubscriptionEvent extends SubscriptionEvent {
  final int planId;
  final bool autoRenew;

  const PurchaseSubscriptionEvent({
    required this.planId,
    this.autoRenew = false,
  });

  @override
  List<Object> get props => [planId, autoRenew];
}

/// Event to purchase subscription with points
class PurchaseSubscriptionWithPointsEvent extends SubscriptionEvent {
  final int planId;
  final bool autoRenew;

  const PurchaseSubscriptionWithPointsEvent({
    required this.planId,
    this.autoRenew = false,
  });

  @override
  List<Object> get props => [planId, autoRenew];
}

/// Event to create payment order for Razorpay
class CreatePaymentOrderEvent extends SubscriptionEvent {
  final int planId;
  final bool autoRenew;

  const CreatePaymentOrderEvent({required this.planId, this.autoRenew = false});

  @override
  List<Object> get props => [planId, autoRenew];
}

/// Event to verify payment after Razorpay payment
class VerifyPaymentEvent extends SubscriptionEvent {
  final int transactionId;
  final String razorpayOrderId;
  final String razorpayPaymentId;
  final String razorpaySignature;
  final bool autoRenew;

  const VerifyPaymentEvent({
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

/// Event to load payment history
class LoadPaymentHistory extends SubscriptionEvent {
  const LoadPaymentHistory();
}

/// Event to cancel subscription
class CancelSubscriptionEvent extends SubscriptionEvent {
  final int subscriptionId;

  const CancelSubscriptionEvent({required this.subscriptionId});

  @override
  List<Object> get props => [subscriptionId];
}

/// Event to refresh all subscription data
class RefreshSubscriptionData extends SubscriptionEvent {
  final bool includePaymentHistory;

  const RefreshSubscriptionData({this.includePaymentHistory = false});

  @override
  List<Object> get props => [includePaymentHistory];
}
