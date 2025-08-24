import 'package:equatable/equatable.dart';

import '../../data/models/coupon_gifting_models.dart';

abstract class GiftingEvent extends Equatable {
  const GiftingEvent();

  @override
  List<Object?> get props => [];
}

class LoadColleagues extends GiftingEvent {
  const LoadColleagues();
}

class GiftCoupon extends GiftingEvent {
  const GiftCoupon(this.request);

  final GiftCouponRequest request;

  @override
  List<Object?> get props => [request];
}

class TransferPoints extends GiftingEvent {
  const TransferPoints(this.request);

  final TransferPointsRequest request;

  @override
  List<Object?> get props => [request];
}

class LoadGiftHistory extends GiftingEvent {
  const LoadGiftHistory();
}

class LoadPointsHistory extends GiftingEvent {
  const LoadPointsHistory();
}

class LoadGiftingHistory extends GiftingEvent {
  const LoadGiftingHistory();
}

class LoadReceivedGifts extends GiftingEvent {
  const LoadReceivedGifts();
}
