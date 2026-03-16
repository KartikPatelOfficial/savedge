part of 'promotion_bloc.dart';

@freezed
abstract class PromotionEvent with _$PromotionEvent {
  const factory PromotionEvent.checkStatus() = _CheckStatus;

  const factory PromotionEvent.enroll() = _Enroll;
}
