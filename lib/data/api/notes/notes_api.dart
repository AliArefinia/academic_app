import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'notes_api.g.dart';

@lazySingleton
@RestApi()
abstract class NotesApi {
  @factoryMethod
  factory NotesApi(Dio dio) = _NotesApi;

  @POST('/api/headlines/{id}/add-note')
  @MultiPart()
  Future<dynamic> addNoteRaw(
    @Path('id') int headlineId,
    @Body() FormData formData,
  );

  @PUT('/api/notes/{id}')
  @MultiPart()
  Future<dynamic> updateNoteRaw(
    @Path('id') int id,
    @Body() FormData formData,
  );

  @DELETE('/api/notes/{id}')
  Future<void> deleteNote(@Path('id') int id);
}
