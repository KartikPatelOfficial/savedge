part of 'points_bloc.dart';

/// Base class for all points events
abstract class PointsEvent extends Equatable {
  const PointsEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load user's points balance and expiry
class LoadUserPoints extends PointsEvent {
  const LoadUserPoints();
}

/// Event to load user's points transaction ledger
class LoadPointsLedger extends PointsEvent {
  const LoadPointsLedger();
}

/// Event to load points expiring in specified days
class LoadPointsExpiring extends PointsEvent {
  final int days;

  const LoadPointsExpiring({required this.days});

  @override
  List<Object> get props => [days];
}

/// Event to load expired points count
class LoadExpiredPointsCount extends PointsEvent {
  const LoadExpiredPointsCount();
}

/// Event to refresh all points data
class RefreshPoints extends PointsEvent {
  const RefreshPoints();
}
