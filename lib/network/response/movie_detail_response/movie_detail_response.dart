import 'package:json_annotation/json_annotation.dart';
import 'package:movixer/data/vos/movie_detail_vos/genre_vo.dart';
import 'package:movixer/data/vos/movie_detail_vos/production_companies_vo.dart';
import 'package:movixer/data/vos/movie_detail_vos/production_countries_vo.dart';
import 'package:movixer/data/vos/movie_detail_vos/spoken_language_vo.dart';
import 'package:movixer/network/response/movie_detail_response/belongs_to_collection_response.dart';
part 'movie_detail_response.g.dart';

@JsonSerializable()
class MovieDetailResponse {
  final bool adult;
  @JsonKey(name: 'backdrop_path')
  String? backdropPath;
  @JsonKey(name: 'belongs_to_collection')
  final BelongsToCollectionResponse? belongsToCollection;
  final int budget;
  final List<MovieDetailGenreVO> genres;
  final String homepage;
  final int id;
  @JsonKey(name: 'imdb_id')
  final String imdbID;
  @JsonKey(name: 'original_language')
  final String? originalLanguage;
  @JsonKey(name: 'original_title')
  final String? originalTitle;
  final String? overview;
  final double popularity;
  @JsonKey(name: 'poster_path')
  String? posterPath;
  @JsonKey(name: 'production_companies')
  final List<ProductionCompanyVO> productionCompanies;
  @JsonKey(name: 'production_countries')
  final List<ProductionCountriesVO> productionCountries;
  @JsonKey(name: 'release_date')
  final String releaseDate;
  final int revenue;
  final int runtime;
  @JsonKey(name: 'spoken_languages')
  final List<SpokenLanguageVO> spokenLanguages;
  final String status;
  final String tagline;
  final String title;
  final bool video;
  @JsonKey(name: 'vote_average')
  final double voteAverage;
  @JsonKey(name: 'vote_count')
  final int voteCount;

  MovieDetailResponse(
      {required this.adult,
      required this.backdropPath,
      required this.belongsToCollection,
      required this.budget,
      required this.genres,
      required this.homepage,
      required this.id,
      required this.imdbID,
      required this.originalLanguage,
      required this.originalTitle,
      required this.overview,
      required this.popularity,
      required this.productionCompanies,
      required this.productionCountries,
      required this.releaseDate,
      required this.revenue,
      required this.runtime,
      required this.spokenLanguages,
      required this.status,
      required this.tagline,
      required this.title,
      required this.video,
      required this.voteAverage,
      required this.voteCount});

  factory MovieDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailResponseFromJson(json);
}
