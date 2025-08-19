import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../shared/domain/entities/subscription.dart';
import '../../domain/usecases/subscription_usecases.dart';
import '../../data/repositories/subscription_repository_impl.dart';

part 'subscription_event.dart';
part 'subscription_state.dart';

/// BLoC for managing subscriptions
class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  final GetSubscriptionPlansUseCase getSubscriptionPlansUseCase;
  final GetUserSubscriptionUseCase getUserSubscriptionUseCase;
  final PurchaseSubscriptionUseCase purchaseSubscriptionUseCase;
  final PurchaseSubscriptionWithPointsUseCase
  purchaseSubscriptionWithPointsUseCase;
  final CreatePaymentOrderUseCase createPaymentOrderUseCase;
  final VerifyPaymentUseCase verifyPaymentUseCase;
  final GetPaymentHistoryUseCase getPaymentHistoryUseCase;
  final CancelSubscriptionUseCase cancelSubscriptionUseCase;

  SubscriptionBloc({
    required this.getSubscriptionPlansUseCase,
    required this.getUserSubscriptionUseCase,
    required this.purchaseSubscriptionUseCase,
    required this.purchaseSubscriptionWithPointsUseCase,
    required this.createPaymentOrderUseCase,
    required this.verifyPaymentUseCase,
    required this.getPaymentHistoryUseCase,
    required this.cancelSubscriptionUseCase,
  }) : super(SubscriptionInitial()) {
    on<LoadSubscriptionPlans>(_onLoadSubscriptionPlans);
    on<LoadUserSubscription>(_onLoadUserSubscription);
    on<PurchaseSubscriptionEvent>(_onPurchaseSubscription);
    on<PurchaseSubscriptionWithPointsEvent>(_onPurchaseSubscriptionWithPoints);
    on<CreatePaymentOrderEvent>(_onCreatePaymentOrder);
    on<VerifyPaymentEvent>(_onVerifyPayment);
    on<LoadPaymentHistory>(_onLoadPaymentHistory);
    on<CancelSubscriptionEvent>(_onCancelSubscription);
    on<RefreshSubscriptionData>(_onRefreshSubscriptionData);
  }

  Future<void> _onLoadSubscriptionPlans(
    LoadSubscriptionPlans event,
    Emitter<SubscriptionState> emit,
  ) async {
    if (state is! SubscriptionLoaded) {
      emit(SubscriptionLoading());
    }

    final result = await getSubscriptionPlansUseCase(NoParams());
    result.fold(
      (failure) =>
          emit(SubscriptionError(message: failure.message ?? 'Unknown error')),
      (plans) {
        if (state is SubscriptionLoaded) {
          final currentState = state as SubscriptionLoaded;
          emit(currentState.copyWith(plans: plans));
        } else {
          emit(SubscriptionLoaded(plans: plans));
        }
      },
    );
  }

  Future<void> _onLoadUserSubscription(
    LoadUserSubscription event,
    Emitter<SubscriptionState> emit,
  ) async {
    if (state is SubscriptionLoaded) {
      final currentState = state as SubscriptionLoaded;
      emit(currentState.copyWith(isLoadingUserSubscription: true));
    }

    final result = await getUserSubscriptionUseCase(NoParams());
    result.fold(
      (failure) {
        if (state is SubscriptionLoaded) {
          final currentState = state as SubscriptionLoaded;
          emit(
            currentState.copyWith(
              isLoadingUserSubscription: false,
              userSubscriptionError: failure.message,
            ),
          );
        } else {
          emit(SubscriptionError(message: failure.message ?? 'Unknown error'));
        }
      },
      (userSubscription) {
        if (state is SubscriptionLoaded) {
          final currentState = state as SubscriptionLoaded;
          emit(
            currentState.copyWith(
              isLoadingUserSubscription: false,
              userSubscription: userSubscription,
              userSubscriptionError: null,
            ),
          );
        } else {
          emit(
            SubscriptionLoaded(
              plans: const [],
              userSubscription: userSubscription,
            ),
          );
        }
      },
    );
  }

  Future<void> _onPurchaseSubscription(
    PurchaseSubscriptionEvent event,
    Emitter<SubscriptionState> emit,
  ) async {
    if (state is! SubscriptionLoaded) return;

    final currentState = state as SubscriptionLoaded;
    emit(currentState.copyWith(isPurchasing: true, purchaseError: null));

    final result = await purchaseSubscriptionUseCase(
      PurchaseSubscriptionParams(
        planId: event.planId,
        autoRenew: event.autoRenew,
      ),
    );

    result.fold(
      (failure) => emit(
        currentState.copyWith(
          isPurchasing: false,
          purchaseError: failure.message,
        ),
      ),
      (success) {
        emit(currentState.copyWith(isPurchasing: false, purchaseSuccess: true));
        // Refresh user subscription data
        add(LoadUserSubscription());
      },
    );
  }

  Future<void> _onPurchaseSubscriptionWithPoints(
    PurchaseSubscriptionWithPointsEvent event,
    Emitter<SubscriptionState> emit,
  ) async {
    if (state is! SubscriptionLoaded) return;

    final currentState = state as SubscriptionLoaded;
    emit(currentState.copyWith(isPurchasing: true, purchaseError: null));

    final result = await purchaseSubscriptionWithPointsUseCase(
      PurchaseSubscriptionParams(
        planId: event.planId,
        autoRenew: event.autoRenew,
      ),
    );

    result.fold(
      (failure) {
        String errorMessage = failure.message ?? 'Unknown error';
        if (failure is InsufficientPointsFailure) {
          errorMessage = 'Insufficient points for this subscription';
        } else if (failure is ExistingSubscriptionFailure) {
          errorMessage = 'You already have an active subscription';
        }

        emit(
          currentState.copyWith(
            isPurchasing: false,
            purchaseError: errorMessage,
          ),
        );
      },
      (result) {
        emit(
          currentState.copyWith(
            isPurchasing: false,
            purchaseSuccess: true,
            purchaseResult: result,
          ),
        );
        // Refresh user subscription data
        add(LoadUserSubscription());
      },
    );
  }

  Future<void> _onCreatePaymentOrder(
    CreatePaymentOrderEvent event,
    Emitter<SubscriptionState> emit,
  ) async {
    if (state is! SubscriptionLoaded) return;

    final currentState = state as SubscriptionLoaded;
    emit(
      currentState.copyWith(
        isCreatingPaymentOrder: true,
        paymentOrderError: null,
      ),
    );

    final result = await createPaymentOrderUseCase(
      PurchaseSubscriptionParams(
        planId: event.planId,
        autoRenew: event.autoRenew,
      ),
    );

    result.fold(
      (failure) => emit(
        currentState.copyWith(
          isCreatingPaymentOrder: false,
          paymentOrderError: failure.message,
        ),
      ),
      (orderData) => emit(
        currentState.copyWith(
          isCreatingPaymentOrder: false,
          paymentOrderData: orderData,
        ),
      ),
    );
  }

  Future<void> _onVerifyPayment(
    VerifyPaymentEvent event,
    Emitter<SubscriptionState> emit,
  ) async {
    if (state is! SubscriptionLoaded) return;

    final currentState = state as SubscriptionLoaded;
    emit(
      currentState.copyWith(isVerifyingPayment: true, verificationError: null),
    );

    final result = await verifyPaymentUseCase(
      VerifyPaymentParams(
        transactionId: event.transactionId,
        razorpayOrderId: event.razorpayOrderId,
        razorpayPaymentId: event.razorpayPaymentId,
        razorpaySignature: event.razorpaySignature,
        autoRenew: event.autoRenew,
      ),
    );

    result.fold(
      (failure) => emit(
        currentState.copyWith(
          isVerifyingPayment: false,
          verificationError: failure.message,
        ),
      ),
      (verificationResult) {
        emit(
          currentState.copyWith(
            isVerifyingPayment: false,
            verificationSuccess: true,
            verificationResult: verificationResult,
          ),
        );
        // Refresh user subscription data
        add(LoadUserSubscription());
      },
    );
  }

  Future<void> _onLoadPaymentHistory(
    LoadPaymentHistory event,
    Emitter<SubscriptionState> emit,
  ) async {
    if (state is! SubscriptionLoaded) return;

    final currentState = state as SubscriptionLoaded;
    emit(currentState.copyWith(isLoadingPaymentHistory: true));

    final result = await getPaymentHistoryUseCase(NoParams());
    result.fold(
      (failure) => emit(
        currentState.copyWith(
          isLoadingPaymentHistory: false,
          paymentHistoryError: failure.message,
        ),
      ),
      (payments) => emit(
        currentState.copyWith(
          isLoadingPaymentHistory: false,
          paymentHistory: payments,
          paymentHistoryError: null,
        ),
      ),
    );
  }

  Future<void> _onCancelSubscription(
    CancelSubscriptionEvent event,
    Emitter<SubscriptionState> emit,
  ) async {
    if (state is! SubscriptionLoaded) return;

    final currentState = state as SubscriptionLoaded;
    emit(currentState.copyWith(isCancelling: true, cancellationError: null));

    final result = await cancelSubscriptionUseCase(
      CancelSubscriptionParams(subscriptionId: event.subscriptionId),
    );

    result.fold(
      (failure) => emit(
        currentState.copyWith(
          isCancelling: false,
          cancellationError: failure.message,
        ),
      ),
      (success) {
        emit(
          currentState.copyWith(isCancelling: false, cancellationSuccess: true),
        );
        // Refresh user subscription data
        add(LoadUserSubscription());
      },
    );
  }

  Future<void> _onRefreshSubscriptionData(
    RefreshSubscriptionData event,
    Emitter<SubscriptionState> emit,
  ) async {
    add(LoadSubscriptionPlans());
    add(LoadUserSubscription());
    if (event.includePaymentHistory) {
      add(LoadPaymentHistory());
    }
  }
}
