import 'package:equatable/equatable.dart';

/// Events for user coupons
abstract class UserCouponsEvent extends Equatable {
  const UserCouponsEvent();

  @override
  List<Object?> get props => [];
}

/// Load user coupons
class LoadUserCoupons extends UserCouponsEvent {
  const LoadUserCoupons({this.pageNumber = 1, this.pageSize = 20, this.status});

  final int pageNumber;
  final int pageSize;
  final String? status;

  @override
  List<Object?> get props => [pageNumber, pageSize, status];
}

/// Refresh user coupons
class RefreshUserCoupons extends UserCouponsEvent {
  const RefreshUserCoupons({this.status});

  final String? status;

  @override
  List<Object?> get props => [status];
}
