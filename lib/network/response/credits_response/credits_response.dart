import 'package:json_annotation/json_annotation.dart';
import 'package:movixer/data/vos/credits_vos/cast_vo.dart';
import 'package:movixer/data/vos/credits_vos/crew_vo.dart';
part 'credits_response.g.dart';

@JsonSerializable()
class CreditsResponse {
  final int id;
  List<CastVO> cast;
  List<CrewVO> crew;

  CreditsResponse({required this.id, required this.cast, required this.crew});

  factory CreditsResponse.fromJson(Map<String, dynamic> json) =>
      _$CreditsResponseFromJson(json);
}
