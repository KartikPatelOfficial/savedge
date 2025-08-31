import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/subscription_models.dart';

part 'subscription_remote_data_source.g.dart';

/// Remote data source for subscription management
@RestApi()
abstract class SubscriptionRemoteDataSource {
  factory SubscriptionRemoteDataSource(Dio dio, {String baseUrl}) =
      _SubscriptionRemoteDataSource;

  /// Get all available subscription plans
  @GET('/api/subscriptions')
  Future<List<SubscriptionPlanModel>> getSubscriptionPlans();

  /// Get user's current active subscription
  @GET('/api/user/subscription')
  Future<UserSubscriptionModel?> getUserSubscription();

  /// Purchase subscription with currency (simple flow)
  @POST('/api/user/subscription/purchase')
  Future<void> purchaseSubscription(
    @Body() PurchaseSubscriptionRequestModel request,
  );

  /// Purchase subscription using points
  @POST('/api/user/subscription/purchase-with-points')
  Future<PurchaseWithPointsResponseModel> purchaseSubscriptionWithPoints(
    @Body() PurchaseSubscriptionWithPointsRequestModel request,
  );

  /// Create payment order for Razorpay integration (subscriptions)
  @POST('/api/subscriptions/create-payment-order')
  Future<CreatePaymentOrderResponseModel> createPaymentOrder(
    @Body() CreatePaymentOrderRequestModel request,
  );

  /// Verify payment after successful Razorpay payment
  @POST('/api/subscriptions/verify-payment')
  Future<VerifyPaymentResponseModel> verifyPayment(
    @Body() VerifyPaymentRequestModel request,
  );

  /// Get payment transaction status
  @GET('/api/subscriptions/payment-status/{transactionId}')
  Future<PaymentTransactionModel> getPaymentStatus(
    @Path('transactionId') int transactionId,
  );

  /// Get payment history for user (endpoint may differ server-side)
  @GET('/api/razorpay/payment-history')
  Future<List<PaymentTransactionModel>> getPaymentHistory();

  /// Cancel subscription (admin endpoint)
  @DELETE('/api/user/subscription/{subscriptionId}')
  Future<void> cancelSubscription(
    @Path('subscriptionId') int subscriptionId,
  );
}
