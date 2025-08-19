import 'package:equatable/equatable.dart';

import '../../data/models/coupon_gifting_models.dart';

abstract class CouponManagerState extends Equatable {
  const CouponManagerState();

  @override
  List<Object?> get props => [];
}

class CouponManagerInitial extends CouponManagerState {
  const CouponManagerInitial();
}

class CouponManagerLoading extends CouponManagerState {
  const CouponManagerLoading();
}

class CouponManagerLoaded extends CouponManagerState {
  const CouponManagerLoaded(this.couponsData);

  final UserCouponsResponseModel couponsData;

  @override
  List<Object?> get props => [couponsData];
}

class CouponManagerError extends CouponManagerState {
  const CouponManagerError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
