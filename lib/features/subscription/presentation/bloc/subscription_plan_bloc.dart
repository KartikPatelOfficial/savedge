import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/subscription_plan.dart';
import '../../domain/repositories/subscription_plan_repository.dart';

// Events
abstract class SubscriptionPlanEvent extends Equatable {
  const SubscriptionPlanEvent();

  @override
  List<Object> get props => [];
}

class LoadSubscriptionPlans extends SubscriptionPlanEvent {
  const LoadSubscriptionPlans();
}

class RefreshSubscriptionPlans extends SubscriptionPlanEvent {
  const RefreshSubscriptionPlans();
}

// States
abstract class SubscriptionPlanState extends Equatable {
  const SubscriptionPlanState();

  @override
  List<Object> get props => [];
}

class SubscriptionPlanInitial extends SubscriptionPlanState {
  const SubscriptionPlanInitial();
}

class SubscriptionPlanLoading extends SubscriptionPlanState {
  const SubscriptionPlanLoading();
}

class SubscriptionPlanLoaded extends SubscriptionPlanState {
  const SubscriptionPlanLoaded(this.plans);

  final List<SubscriptionPlan> plans;

  @override
  List<Object> get props => [plans];
}

class SubscriptionPlanError extends SubscriptionPlanState {
  const SubscriptionPlanError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

// BLoC
class SubscriptionPlanBloc
    extends Bloc<SubscriptionPlanEvent, SubscriptionPlanState> {
  SubscriptionPlanBloc({
    required SubscriptionPlanRepository subscriptionPlanRepository,
  }) : _subscriptionPlanRepository = subscriptionPlanRepository,
       super(const SubscriptionPlanInitial()) {
    on<LoadSubscriptionPlans>(_onLoadSubscriptionPlans);
    on<RefreshSubscriptionPlans>(_onRefreshSubscriptionPlans);
  }

  final SubscriptionPlanRepository _subscriptionPlanRepository;

  Future<void> _onLoadSubscriptionPlans(
    LoadSubscriptionPlans event,
    Emitter<SubscriptionPlanState> emit,
  ) async {
    emit(const SubscriptionPlanLoading());

    try {
      final plans = await _subscriptionPlanRepository.getSubscriptionPlans();
      // If no plans from API, use sample data for testing
      if (plans.isEmpty) {
        final samplePlans = _getSamplePlans();
        emit(SubscriptionPlanLoaded(samplePlans));
      } else {
        emit(SubscriptionPlanLoaded(plans));
      }
    } catch (error) {
      // On error, show sample data for testing
      final samplePlans = _getSamplePlans();
      emit(SubscriptionPlanLoaded(samplePlans));
    }
  }

  List<SubscriptionPlan> _getSamplePlans() {
    return [
      SubscriptionPlan(
        id: 1,
        name: 'Premium Membership',
        description: 'Get exclusive access to all premium features',
        price: 499.0,
        durationMonths: 12,
        bonusPoints: 5000,
        maxCoupons: 50,
        imageUrl:
            'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        isActive: true,
      ),
      SubscriptionPlan(
        id: 2,
        name: 'Basic Plan',
        description: 'Essential features for regular users',
        price: 199.0,
        durationMonths: 6,
        bonusPoints: 2000,
        maxCoupons: 20,
        imageUrl:
            'https://images.unsplash.com/photo-1563013544-824ae1b704d3?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        isActive: true,
      ),
    ];
  }

  Future<void> _onRefreshSubscriptionPlans(
    RefreshSubscriptionPlans event,
    Emitter<SubscriptionPlanState> emit,
  ) async {
    // Don't show loading state on refresh to avoid UI flickering
    try {
      final plans = await _subscriptionPlanRepository.getSubscriptionPlans();
      emit(SubscriptionPlanLoaded(plans));
    } catch (error) {
      emit(SubscriptionPlanError(error.toString()));
    }
  }
}
