import 'package:equatable/equatable.dart';

abstract class CouponManagerEvent extends Equatable {
  const CouponManagerEvent();

  @override
  List<Object?> get props => [];
}

class LoadAllCoupons extends CouponManagerEvent {
  const LoadAllCoupons();
}

class RefreshAllCoupons extends CouponManagerEvent {
  const RefreshAllCoupons();
}

class LoadCouponsByCategory extends CouponManagerEvent {
  const LoadCouponsByCategory(this.category);

  final String category;

  @override
  List<Object?> get props => [category];
}
