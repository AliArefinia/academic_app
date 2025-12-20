import 'package:injectable/injectable.dart';
import 'package:academic/data/api/study_tour_request/study_tour_request_api.dart';
import 'package:academic/data/api/study_tour_request/model/study_tour_request_model.dart';

abstract class IStudyTourRequestRepository {
  Future<StudyTourRequestResponse> submitRequest({
    required int categoryId,
    required String title,
    required String description,
  });
  
  Future<StudyTourRequestListResponse> getMyStudyTourRequests();
}

@Injectable(as: IStudyTourRequestRepository)
class StudyTourRequestRepository implements IStudyTourRequestRepository {
  final StudyTourRequestApi _api;

  StudyTourRequestRepository(this._api);

  @override
  Future<StudyTourRequestResponse> submitRequest({
    required int categoryId,
    required String title,
    required String description,
  }) async {
    final request = StudyTourRequestModel(
      categoryId: categoryId,
      title: title,
      description: description,
    );
    
    return await _api.submitRequest(request);
  }

  @override
  Future<StudyTourRequestListResponse> getMyStudyTourRequests() async {
    return await _api.getMyStudyTourRequests();
  }
}
