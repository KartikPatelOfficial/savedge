import 'package:equatable/equatable.dart';
import 'package:savedge/features/coupons/data/models/user_coupon_model.dart';

/// States for user coupons
abstract class UserCouponsState extends Equatable {
  const UserCouponsState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class UserCouponsInitial extends UserCouponsState {}

/// Loading state
class UserCouponsLoading extends UserCouponsState {}

/// Loaded state
class UserCouponsLoaded extends UserCouponsState {
  const UserCouponsLoaded({
    required this.coupons,
    required this.totalCount,
    required this.activeCount,
    required this.usedCount,
    required this.expiredCount,
    this.hasReachedMax = false,
  });

  final List<UserCouponModel> coupons;
  final int totalCount;
  final int activeCount;
  final int usedCount;
  final int expiredCount;
  final bool hasReachedMax;

  UserCouponsLoaded copyWith({
    List<UserCouponModel>? coupons,
    int? totalCount,
    int? activeCount,
    int? usedCount,
    int? expiredCount,
    bool? hasReachedMax,
  }) {
    return UserCouponsLoaded(
      coupons: coupons ?? this.coupons,
      totalCount: totalCount ?? this.totalCount,
      activeCount: activeCount ?? this.activeCount,
      usedCount: usedCount ?? this.usedCount,
      expiredCount: expiredCount ?? this.expiredCount,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [
    coupons,
    totalCount,
    activeCount,
    usedCount,
    expiredCount,
    hasReachedMax,
  ];
}

/// Error state
class UserCouponsError extends UserCouponsState {
  const UserCouponsError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
