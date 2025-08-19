part of 'subscription_bloc.dart';

/// Base class for all subscription states
abstract class SubscriptionState extends Equatable {
  const SubscriptionState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class SubscriptionInitial extends SubscriptionState {
  const SubscriptionInitial();
}

/// Loading state
class SubscriptionLoading extends SubscriptionState {
  const SubscriptionLoading();
}

/// Loaded state with subscription data
class SubscriptionLoaded extends SubscriptionState {
  final List<SubscriptionPlan> plans;
  final UserSubscription? userSubscription;
  final List<PaymentTransaction>? paymentHistory;

  // Loading states
  final bool isLoadingUserSubscription;
  final bool isPurchasing;
  final bool isCreatingPaymentOrder;
  final bool isVerifyingPayment;
  final bool isLoadingPaymentHistory;
  final bool isCancelling;

  // Success states
  final bool purchaseSuccess;
  final bool verificationSuccess;
  final bool cancellationSuccess;

  // Data from operations
  final Map<String, dynamic>? purchaseResult;
  final Map<String, dynamic>? paymentOrderData;
  final Map<String, dynamic>? verificationResult;

  // Error states
  final String? userSubscriptionError;
  final String? purchaseError;
  final String? paymentOrderError;
  final String? verificationError;
  final String? paymentHistoryError;
  final String? cancellationError;

  const SubscriptionLoaded({
    required this.plans,
    this.userSubscription,
    this.paymentHistory,
    this.isLoadingUserSubscription = false,
    this.isPurchasing = false,
    this.isCreatingPaymentOrder = false,
    this.isVerifyingPayment = false,
    this.isLoadingPaymentHistory = false,
    this.isCancelling = false,
    this.purchaseSuccess = false,
    this.verificationSuccess = false,
    this.cancellationSuccess = false,
    this.purchaseResult,
    this.paymentOrderData,
    this.verificationResult,
    this.userSubscriptionError,
    this.purchaseError,
    this.paymentOrderError,
    this.verificationError,
    this.paymentHistoryError,
    this.cancellationError,
  });

  /// Helper getters
  bool get hasUserSubscription => userSubscription != null;
  bool get hasActiveSubscription =>
      userSubscription?.isCurrentlyActive ?? false;
  bool get hasPaymentHistory =>
      paymentHistory != null && paymentHistory!.isNotEmpty;

  /// Get plan by ID
  SubscriptionPlan? getPlanById(int planId) {
    try {
      return plans.firstWhere((plan) => plan.id == planId);
    } catch (e) {
      return null;
    }
  }

  /// Get current subscription plan
  SubscriptionPlan? get currentSubscriptionPlan {
    if (userSubscription == null) return null;
    return getPlanById(userSubscription!.planId);
  }

  /// Check if user can purchase a plan (no active subscription)
  bool get canPurchaseSubscription => !hasActiveSubscription;

  /// Get successful payment transactions
  List<PaymentTransaction> get successfulPayments {
    if (paymentHistory == null) return [];
    return paymentHistory!.where((p) => p.isSuccessful).toList();
  }

  /// Get failed payment transactions
  List<PaymentTransaction> get failedPayments {
    if (paymentHistory == null) return [];
    return paymentHistory!.where((p) => p.isFailed).toList();
  }

  /// Get pending payment transactions
  List<PaymentTransaction> get pendingPayments {
    if (paymentHistory == null) return [];
    return paymentHistory!.where((p) => p.isPending).toList();
  }

  SubscriptionLoaded copyWith({
    List<SubscriptionPlan>? plans,
    UserSubscription? userSubscription,
    List<PaymentTransaction>? paymentHistory,
    bool? isLoadingUserSubscription,
    bool? isPurchasing,
    bool? isCreatingPaymentOrder,
    bool? isVerifyingPayment,
    bool? isLoadingPaymentHistory,
    bool? isCancelling,
    bool? purchaseSuccess,
    bool? verificationSuccess,
    bool? cancellationSuccess,
    Map<String, dynamic>? purchaseResult,
    Map<String, dynamic>? paymentOrderData,
    Map<String, dynamic>? verificationResult,
    String? userSubscriptionError,
    String? purchaseError,
    String? paymentOrderError,
    String? verificationError,
    String? paymentHistoryError,
    String? cancellationError,
  }) {
    return SubscriptionLoaded(
      plans: plans ?? this.plans,
      userSubscription: userSubscription ?? this.userSubscription,
      paymentHistory: paymentHistory ?? this.paymentHistory,
      isLoadingUserSubscription:
          isLoadingUserSubscription ?? this.isLoadingUserSubscription,
      isPurchasing: isPurchasing ?? this.isPurchasing,
      isCreatingPaymentOrder:
          isCreatingPaymentOrder ?? this.isCreatingPaymentOrder,
      isVerifyingPayment: isVerifyingPayment ?? this.isVerifyingPayment,
      isLoadingPaymentHistory:
          isLoadingPaymentHistory ?? this.isLoadingPaymentHistory,
      isCancelling: isCancelling ?? this.isCancelling,
      purchaseSuccess: purchaseSuccess ?? this.purchaseSuccess,
      verificationSuccess: verificationSuccess ?? this.verificationSuccess,
      cancellationSuccess: cancellationSuccess ?? this.cancellationSuccess,
      purchaseResult: purchaseResult ?? this.purchaseResult,
      paymentOrderData: paymentOrderData ?? this.paymentOrderData,
      verificationResult: verificationResult ?? this.verificationResult,
      userSubscriptionError: userSubscriptionError,
      purchaseError: purchaseError,
      paymentOrderError: paymentOrderError,
      verificationError: verificationError,
      paymentHistoryError: paymentHistoryError,
      cancellationError: cancellationError,
    );
  }

  @override
  List<Object?> get props => [
    plans,
    userSubscription,
    paymentHistory,
    isLoadingUserSubscription,
    isPurchasing,
    isCreatingPaymentOrder,
    isVerifyingPayment,
    isLoadingPaymentHistory,
    isCancelling,
    purchaseSuccess,
    verificationSuccess,
    cancellationSuccess,
    purchaseResult,
    paymentOrderData,
    verificationResult,
    userSubscriptionError,
    purchaseError,
    paymentOrderError,
    verificationError,
    paymentHistoryError,
    cancellationError,
  ];
}

/// Error state
class SubscriptionError extends SubscriptionState {
  final String message;

  const SubscriptionError({required this.message});

  @override
  List<Object> get props => [message];
}
