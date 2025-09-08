import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../shared/domain/entities/points.dart';
import '../../domain/usecases/get_user_points_usecase.dart';

part 'points_event.dart';
part 'points_state.dart';

/// BLoC for managing user points
class PointsBloc extends Bloc<PointsEvent, PointsState> {
  final GetUserPointsUseCase getUserPointsUseCase;
  final GetPointsLedgerUseCase getPointsLedgerUseCase;
  final GetPointsExpiringUseCase getPointsExpiringUseCase;
  final GetExpiredPointsCountUseCase getExpiredPointsCountUseCase;

  PointsBloc({
    required this.getUserPointsUseCase,
    required this.getPointsLedgerUseCase,
    required this.getPointsExpiringUseCase,
    required this.getExpiredPointsCountUseCase,
  }) : super(PointsInitial()) {
    on<LoadUserPoints>(_onLoadUserPoints);
    on<LoadPointsLedger>(_onLoadPointsLedger);
    on<LoadPointsExpiring>(_onLoadPointsExpiring);
    on<LoadExpiredPointsCount>(_onLoadExpiredPointsCount);
    on<RefreshPoints>(_onRefreshPoints);
  }

  Future<void> _onLoadUserPoints(
    LoadUserPoints event,
    Emitter<PointsState> emit,
  ) async {
    emit(PointsLoading());

    final result = await getUserPointsUseCase(NoParams());
    
    await result.fold(
      (failure) async {
        emit(PointsError(message: failure.message ?? 'Unknown error'));
      },
      (points) async {
        // Also load transactions on initial load for better UX
        final ledgerResult = await getPointsLedgerUseCase(NoParams());
        
        List<PointTransaction>? transactions;
        String? ledgerError;
        
        ledgerResult.fold(
          (failure) => ledgerError = failure.message,
          (trans) => transactions = trans,
        );
        
        emit(PointsLoaded(
          points: points,
          transactions: transactions,
          ledgerError: ledgerError,
        ));
      },
    );
  }

  Future<void> _onLoadPointsLedger(
    LoadPointsLedger event,
    Emitter<PointsState> emit,
  ) async {
    if (state is! PointsLoaded) return;

    final currentState = state as PointsLoaded;
    emit(currentState.copyWith(isLoadingLedger: true));

    final result = await getPointsLedgerUseCase(NoParams());
    result.fold(
      (failure) => emit(
        currentState.copyWith(
          isLoadingLedger: false,
          ledgerError: failure.message,
        ),
      ),
      (transactions) => emit(
        currentState.copyWith(
          isLoadingLedger: false,
          transactions: transactions,
          ledgerError: null,
        ),
      ),
    );
  }

  Future<void> _onLoadPointsExpiring(
    LoadPointsExpiring event,
    Emitter<PointsState> emit,
  ) async {
    if (state is! PointsLoaded) return;

    final currentState = state as PointsLoaded;
    emit(currentState.copyWith(isLoadingExpiring: true));

    final result = await getPointsExpiringUseCase(
      GetPointsExpiringParams(days: event.days),
    );
    result.fold(
      (failure) => emit(
        currentState.copyWith(
          isLoadingExpiring: false,
          expiringError: failure.message,
        ),
      ),
      (data) => emit(
        currentState.copyWith(
          isLoadingExpiring: false,
          expiringPointsData: data,
          expiringError: null,
        ),
      ),
    );
  }

  Future<void> _onLoadExpiredPointsCount(
    LoadExpiredPointsCount event,
    Emitter<PointsState> emit,
  ) async {
    if (state is! PointsLoaded) return;

    final currentState = state as PointsLoaded;
    emit(currentState.copyWith(isLoadingExpiredCount: true));

    final result = await getExpiredPointsCountUseCase(NoParams());
    result.fold(
      (failure) => emit(
        currentState.copyWith(
          isLoadingExpiredCount: false,
          expiredCountError: failure.message,
        ),
      ),
      (count) => emit(
        currentState.copyWith(
          isLoadingExpiredCount: false,
          expiredPointsCount: count,
          expiredCountError: null,
        ),
      ),
    );
  }

  Future<void> _onRefreshPoints(
    RefreshPoints event,
    Emitter<PointsState> emit,
  ) async {
    // Store current state if it's loaded
    final currentState = state is PointsLoaded ? state as PointsLoaded : null;
    
    // If we have a current state, show loading while preserving data
    if (currentState != null) {
      emit(currentState.copyWith(isRefreshing: true));
    } else {
      emit(PointsLoading());
    }

    // Refresh user points
    final pointsResult = await getUserPointsUseCase(NoParams());
    
    await pointsResult.fold(
      (failure) async {
        emit(PointsError(message: failure.message ?? 'Unknown error'));
      },
      (points) async {
        // Load transactions
        final ledgerResult = await getPointsLedgerUseCase(NoParams());
        
        List<PointTransaction>? transactions;
        String? ledgerError;
        
        ledgerResult.fold(
          (failure) => ledgerError = failure.message,
          (trans) => transactions = trans,
        );
        
        emit(PointsLoaded(
          points: points,
          transactions: transactions,
          ledgerError: ledgerError,
          isRefreshing: false,
        ));
      },
    );
  }
}
