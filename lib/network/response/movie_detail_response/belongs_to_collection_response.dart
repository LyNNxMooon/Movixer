import 'package:json_annotation/json_annotation.dart';
part 'belongs_to_collection_response.g.dart';

@JsonSerializable()
class BelongsToCollectionResponse {
  final int id;
  final String name;
  @JsonKey(name: 'poster_path')
  final String posterPath;
  @JsonKey(name: 'backdrop_path')
  final String backdropPath;

  BelongsToCollectionResponse(
      {required this.id,
      required this.name,
      required this.backdropPath,
      required this.posterPath});

  factory BelongsToCollectionResponse.fromJson(Map<String, dynamic> json) =>
      _$BelongsToCollectionResponseFromJson(json);
}
