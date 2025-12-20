import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:academic/core/api_constants.dart';
import 'model/study_tour_request_model.dart';

part 'study_tour_request_api.g.dart';

@lazySingleton
@RestApi()
abstract class StudyTourRequestApi {
  @factoryMethod
  factory StudyTourRequestApi(Dio dio) = _StudyTourRequestApi;

  @POST(AppUrls.studyTourRequest)
  Future<StudyTourRequestResponse> submitRequest(@Body() StudyTourRequestModel request);

  @GET(AppUrls.myStudyTourRequests)
  Future<StudyTourRequestListResponse> getMyStudyTourRequests();
}
