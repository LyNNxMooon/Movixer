import 'package:dio/dio.dart';
import 'package:movixer/data/model/movixer_hive_model.dart';
import 'package:movixer/data/vos/actor_vos/actor_vo.dart';

import 'package:movixer/data/vos/genres_vos/genres_vos.dart';
import 'package:movixer/data/vos/movie_video_vos/movie_video_vo.dart';
import 'package:movixer/data/vos/movie_vos/movie_vo.dart';

import 'package:movixer/network/api/movixer_api.dart';
import 'package:movixer/network/api_constant/api_constant.dart';
import 'package:movixer/network/data_agent/movixer_data_agent.dart';
import 'package:movixer/network/response/actor_detail_response/actor_detail_response.dart';
import 'package:movixer/network/response/credits_response/credits_response.dart';
import 'package:movixer/network/response/movie_detail_response/movie_detail_response.dart';

class MovixerDataAgentImpl extends MovixerDataAgent {
  late MovixerApi _movixerApi;
  MovixerDataAgentImpl._() {
    _movixerApi = MovixerApi(Dio());
  }

  static final MovixerDataAgentImpl _singleton = MovixerDataAgentImpl._();

  factory MovixerDataAgentImpl() => _singleton;

  final MovixerHiveModel _movixerHiveModel = MovixerHiveModel();

  @override
  Future<List<GenresVO>> getGenresList() => _movixerApi
      .getAllGenres(kAPIValue)
      .asStream()
      .map((event) => event.genres)
      .first;

  @override
  Future<List<MovieVO>> getMoviesByGenres() => _movixerApi
      .getAllMoviesByGenres(_movixerHiveModel.getGenreID, kAPIValue)
      .asStream()
      .map((event) => event.results)
      .first;

  @override
  Future<List<MovieVO>> getSimilarMovies() => _movixerApi
      .getAllSimilarMovies(_movixerHiveModel.getMovieID, kAPIValue)
      .asStream()
      .map((event) => event.results)
      .first;

  @override
  Future<List<MovieVO>> getPopularMovies() => _movixerApi
      .getAllPopularMovies(kAPIValue)
      .asStream()
      .map((event) => event.results)
      .first;

  @override
  Future<List<ActorVO>> getActorList() => _movixerApi
      .getAllActors(kAPIValue)
      .asStream()
      .map((event) => event.results)
      .first;

  @override
  Future<List<MovieVO>> getMovieTopRated() => _movixerApi
      .getAllMoviesTopRated(kAPIValue)
      .asStream()
      .map((event) => event.results)
      .first;

  @override
  Future<MovieDetailResponse> getMovieDetail() =>
      _movixerApi.getMovieDetails(kAPIValue, _movixerHiveModel.getMovieID);

  @override
  Future<List<MovieVO>> getSearchMovies() => _movixerApi
      .getSearchedMovies(kAPIValue, _movixerHiveModel.getSearchQuery)
      .asStream()
      .map((event) => event.results)
      .first;

  @override
  Future<CreditsResponse> getCredits() =>
      _movixerApi.getCredits(kAPIValue, _movixerHiveModel.getMovieID);

  @override
  Future<ActorDetailResponse> getActorDetails() =>
      _movixerApi.getActorDetails(kAPIValue, _movixerHiveModel.getActorID);

  @override
  Future<List<MovieVideoVO>> getMovieVideos() => _movixerApi
      .getMovieVideos(_movixerHiveModel.getMovieID, kAPIValue)
      .asStream()
      .map((event) => event.results)
      .first;
}
