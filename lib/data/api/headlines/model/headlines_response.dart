import 'package:json_annotation/json_annotation.dart';
import 'package:academic/data/model/chapter.dart';

part 'headlines_response.g.dart';

@JsonSerializable()
class HeadlinesResponse {
  final List<dynamic> data;

  HeadlinesResponse({required this.data});

  factory HeadlinesResponse.fromJson(Map<String, dynamic> json) =>
      _$HeadlinesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HeadlinesResponseToJson(this);
  
  List<Chapter> get chapters {
    return data.map((item) => Chapter.fromJson(item as Map<String, dynamic>)).toList();
  }
}

@JsonSerializable()
class HeadlineResponse {
  final Map<String, dynamic> data;

  HeadlineResponse({required this.data});

  factory HeadlineResponse.fromJson(Map<String, dynamic> json) =>
      _$HeadlineResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HeadlineResponseToJson(this);
  
  Chapter get chapter => Chapter.fromJson(data);
}
