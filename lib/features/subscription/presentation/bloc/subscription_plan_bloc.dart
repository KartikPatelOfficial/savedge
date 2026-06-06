import 'package:equatable/equatable.dart';
import 'package:savedge/core/error/error_message_mapper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    print('🔍 SubscriptionPlanBloc: Starting to load subscription plans...');
    emit(const SubscriptionPlanLoading());

    try {
      print('📡 SubscriptionPlanBloc: Fetching plans from API...');
      final plans = await _subscriptionPlanRepository.getSubscriptionPlans();
      print('✅ SubscriptionPlanBloc: Received ${plans.length} plans from API');

      if (plans.isEmpty) {
        print('⚠️ SubscriptionPlanBloc: Plans list is empty');
        emit(const SubscriptionPlanError('No subscription plans available'));
      } else {
        print('📦 SubscriptionPlanBloc: Plans loaded successfully');
        for (var plan in plans) {
          print('  - Plan: ${plan.name}, Price: ${plan.price}, Image: ${plan.imageUrl ?? "no image"}');
        }
        emit(SubscriptionPlanLoaded(plans));
      }
    } catch (error, stackTrace) {
      print('❌ SubscriptionPlanBloc: Error loading subscription plans');
      print('   Error: $error');
      print('   Stack trace: $stackTrace');
      emit(SubscriptionPlanError(ErrorMessageMapper.map(error)));
    }
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
      emit(SubscriptionPlanError(ErrorMessageMapper.map(error)));
    }
  }
}
