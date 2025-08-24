import 'package:equatable/equatable.dart';

import '../../data/models/coupon_gifting_models.dart';

abstract class GiftingState extends Equatable {
  const GiftingState();

  @override
  List<Object?> get props => [];
}

class GiftingInitial extends GiftingState {
  const GiftingInitial();
}

class GiftingLoading extends GiftingState {
  const GiftingLoading();
}

class ColleaguesLoaded extends GiftingState {
  const ColleaguesLoaded(this.colleagues);

  final List<ColleagueModel> colleagues;

  @override
  List<Object?> get props => [colleagues];
}

class GiftingSuccess extends GiftingState {
  const GiftingSuccess(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class GiftingError extends GiftingState {
  const GiftingError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class GiftHistoryLoaded extends GiftingState {
  const GiftHistoryLoaded(this.history);

  final GiftedCouponsHistoryResponseModel history;

  @override
  List<Object?> get props => [history];
}

class PointsHistoryLoaded extends GiftingState {
  const PointsHistoryLoaded(this.history);

  final List<PointsTransferHistoryModel> history;

  @override
  List<Object?> get props => [history];
}

class GiftingHistoryLoaded extends GiftingState {
  const GiftingHistoryLoaded({
    required this.giftedCoupons,
    required this.transferredPoints,
  });

  final List<dynamic> giftedCoupons;
  final List<dynamic> transferredPoints;

  @override
  List<Object?> get props => [giftedCoupons, transferredPoints];
}

class ReceivedGiftsLoaded extends GiftingState {
  const ReceivedGiftsLoaded({
    required this.receivedCoupons,
    required this.receivedPoints,
  });

  final List<dynamic> receivedCoupons;
  final List<dynamic> receivedPoints;

  @override
  List<Object?> get props => [receivedCoupons, receivedPoints];
}
