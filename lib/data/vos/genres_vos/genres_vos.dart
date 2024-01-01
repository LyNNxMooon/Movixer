import 'package:json_annotation/json_annotation.dart';
part 'genres_vos.g.dart';

@JsonSerializable()
class GenresVO {
  final int id;
  final String name;

  GenresVO({required this.id, required this.name});

  factory GenresVO.fromJson(Map<String, dynamic> json) =>
      _$GenresVOFromJson(json);
}
