import 'package:json_annotation/json_annotation.dart';
import 'package:movixer/data/vos/movie_video_vos/movie_video_vo.dart';
part 'movie_video_response.g.dart';

@JsonSerializable()
class MovieVideoResponse {
  final int id;
  final List<MovieVideoVO> results;

  MovieVideoResponse({required this.id, required this.results});

  factory MovieVideoResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieVideoResponseFromJson(json);
}
