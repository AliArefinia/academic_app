import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'model/person_model.dart';

part 'people_api.g.dart';

class PeopleListResponse {
  final List<PersonModel> data;
  PeopleListResponse({required this.data});
  factory PeopleListResponse.fromJson(Map<String, dynamic> json) {
    final list = json['data'] ?? json['authors'] ?? json['speakers'] ?? json['publishers'] ?? json['translators'] ?? [];
    return PeopleListResponse(
      data: (list as List)
          .map((e) => PersonModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

@RestApi()
abstract class PeopleApi {
  factory PeopleApi(Dio dio) = _PeopleApi;

  @GET('/api/authors')
  Future<PeopleListResponse> getAuthors();

  @GET('/api/speakers')
  Future<PeopleListResponse> getSpeakers();

  @GET('/api/publishers')
  Future<PeopleListResponse> getPublishers();

  @GET('/api/translators')
  Future<PeopleListResponse> getTranslators();
} 