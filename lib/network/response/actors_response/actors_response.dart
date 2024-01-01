import 'package:json_annotation/json_annotation.dart';
import 'package:movixer/data/vos/actor_vos/actor_vo.dart';
part 'actors_response.g.dart';

@JsonSerializable()
class ActorsResponse {
  final int page;
  final List<ActorVO> results;
  @JsonKey(name: 'total_pages')
  final int totalPages;
  @JsonKey(name: 'total_results')
  final int totalResults;

  ActorsResponse(
      {required this.page,
      required this.results,
      required this.totalPages,
      required this.totalResults});

  factory ActorsResponse.fromJson(Map<String, dynamic> json) =>
      _$ActorsResponseFromJson(json);
}
