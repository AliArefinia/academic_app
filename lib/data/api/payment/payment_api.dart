import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'model/payment_model.dart';

part 'payment_api.g.dart';

@lazySingleton
@RestApi()
abstract class PaymentApi {
  @factoryMethod
  factory PaymentApi(Dio dio) = _PaymentApi;

  @POST('/api/pay')
  Future<PaymentApiResponse> createPayment(@Body() PaymentRequest request);

  @POST('/api/pay/verify')
  Future<PaymentVerifyResponse> verifyPayment(@Body() PaymentVerifyRequest request);

  @GET('/api/payments/track/{trackingCode}')
  Future<PaymentTrackingResponse> trackPayment(
      @Path('trackingCode') String trackingCode);
}
