import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_message_models.freezed.dart';
part 'contact_message_models.g.dart';

@freezed
abstract class SubmitContactMessageRequest with _$SubmitContactMessageRequest {
  const factory SubmitContactMessageRequest({
    required String fullName,
    required String email,
    String? subject,
    required String message,
    String? source,
  }) = _SubmitContactMessageRequest;

  factory SubmitContactMessageRequest.fromJson(Map<String, dynamic> json) =>
      _$SubmitContactMessageRequestFromJson(json);
}

@freezed
abstract class ContactMessageResponse with _$ContactMessageResponse {
  const factory ContactMessageResponse({required int id}) =
      _ContactMessageResponse;

  factory ContactMessageResponse.fromJson(Map<String, dynamic> json) =>
      _$ContactMessageResponseFromJson(json);
}
