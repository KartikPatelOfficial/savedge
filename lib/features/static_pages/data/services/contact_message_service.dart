import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/contact_message_models.dart';

part 'contact_message_service.g.dart';

@RestApi()
abstract class ContactMessageService {
  factory ContactMessageService(Dio dio, {String baseUrl}) =
      _ContactMessageService;

  @POST('/api/contact-messages')
  Future<ContactMessageResponse> submitContactMessage(
    @Body() SubmitContactMessageRequest request,
  );
}
