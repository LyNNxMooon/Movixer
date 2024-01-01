import 'dart:async';

import 'package:movixer/data/vos/actor_vos/actor_vo.dart';
import 'package:movixer/data/vos/genres_vos/genres_vos.dart';
import 'package:movixer/data/vos/movie_video_vos/movie_video_vo.dart';
import 'package:movixer/data/vos/movie_vos/movie_vo.dart';
import 'package:movixer/network/data_agent/movixer_data_agent.dart';
import 'package:movixer/network/data_agent/movixer_data_agent_impl.dart';
import 'package:movixer/network/response/actor_detail_response/actor_detail_response.dart';
import 'package:movixer/network/response/credits_response/credits_response.dart';
import 'package:movixer/network/response/movie_detail_response/movie_detail_response.dart';

class MovixerModel {
  MovixerModel._();
  static final MovixerModel _singleton = MovixerModel._();
  factory MovixerModel() => _singleton;

  final MovixerDataAgent _movixerDataAgent = MovixerDataAgentImpl();

  Future<List<GenresVO>> getAllGenresList() =>
      _movixerDataAgent.getGenresList();

  Future<List<MovieVO>> getAllMoviesByGenres() =>
      _movixerDataAgent.getMoviesByGenres().then((value) {
        var temp = value;
        temp = temp.map((e) {
          e.backdropPath = (e.backdropPath?.isEmpty ?? true)
              ? "/1N7IexWDCWRzMynWyjESakKg8Eb.jpg"
              : e.backdropPath;
          e.posterPath = (e.posterPath?.isEmpty ?? true)
              ? "/1N7IexWDCWRzMynWyjESakKg8Eb.jpg"
              : e.posterPath;
          return e;
        }).toList();
        return temp;
      });

  Future<List<MovieVO>> getAllSimilarMovies() =>
      _movixerDataAgent.getSimilarMovies().then((value) {
        var temp = value;
        temp = temp.map((e) {
          e.backdropPath = (e.backdropPath?.isEmpty ?? true)
              ? "/1N7IexWDCWRzMynWyjESakKg8Eb.jpg"
              : e.backdropPath;
          e.posterPath = (e.posterPath?.isEmpty ?? true)
              ? "/1N7IexWDCWRzMynWyjESakKg8Eb.jpg"
              : e.posterPath;
          return e;
        }).toList();
        return temp;
      });

  Future<List<MovieVO>> getAllPopularMovies() =>
      _movixerDataAgent.getPopularMovies().then((value) {
        var temp = value;
        temp = temp.map((e) {
          e.backdropPath = (e.backdropPath?.isEmpty ?? true)
              ? "/1N7IexWDCWRzMynWyjESakKg8Eb.jpg"
              : e.backdropPath;
          e.posterPath = (e.posterPath?.isEmpty ?? true)
              ? "/1N7IexWDCWRzMynWyjESakKg8Eb.jpg"
              : e.posterPath;
          return e;
        }).toList();
        return temp;
      });

  Future<List<ActorVO>> getAllActorsList() =>
      _movixerDataAgent.getActorList().then((value) {
        var temp = value;
        temp = temp.map((e) {
          e.profilePath = (e.profilePath?.isEmpty ?? true)
              ? "/gYs7kSFwr89BOHG2rxEOet17C2y.jpg"
              : e.profilePath;
          return e;
        }).toList();
        return temp;
      });

  Future<List<MovieVO>> getAllMoviesTopRated() =>
      _movixerDataAgent.getMovieTopRated().then((value) {
        var temp = value;
        temp = temp.map((e) {
          e.backdropPath = (e.backdropPath?.isEmpty ?? true)
              ? "/1N7IexWDCWRzMynWyjESakKg8Eb.jpg"
              : e.backdropPath;
          e.posterPath = (e.posterPath?.isEmpty ?? true)
              ? "/1N7IexWDCWRzMynWyjESakKg8Eb.jpg"
              : e.posterPath;
          return e;
        }).toList();
        return temp;
      });

  Future<MovieDetailResponse> getMovieDetails() =>
      _movixerDataAgent.getMovieDetail().then((value) {
        var temp = value;
        temp.backdropPath = (temp.backdropPath?.isEmpty ?? true)
            ? "/1N7IexWDCWRzMynWyjESakKg8Eb.jpg"
            : temp.backdropPath;
        temp.posterPath = (temp.posterPath?.isEmpty ?? true)
            ? "/1N7IexWDCWRzMynWyjESakKg8Eb.jpg"
            : temp.posterPath;

        return temp;
      });

  Future<List<MovieVO>> getSearchMovies() =>
      _movixerDataAgent.getSearchMovies().then((value) {
        var temp = value;
        temp = temp.map((e) {
          e.backdropPath = (e.backdropPath?.isEmpty ?? true)
              ? "/1N7IexWDCWRzMynWyjESakKg8Eb.jpg"
              : e.backdropPath;
          e.posterPath = (e.posterPath?.isEmpty ?? true)
              ? "/1N7IexWDCWRzMynWyjESakKg8Eb.jpg"
              : e.posterPath;
          return e;
        }).toList();
        return temp;
      });

  Future<CreditsResponse> getCredits() =>
      _movixerDataAgent.getCredits().then((value) {
        value.cast = value.cast.map((e) {
          e.profilePath = (e.profilePath?.isEmpty ?? true)
              ? "/1N7IexWDCWRzMynWyjESakKg8Eb.jpg"
              : e.profilePath;
          return e;
        }).toList();
        value.crew = value.crew.map((e) {
          e.profilePath = (e.profilePath?.isEmpty ?? true)
              ? "/1N7IexWDCWRzMynWyjESakKg8Eb.jpg"
              : e.profilePath;
          return e;
        }).toList();
        return value;
      });

  Future<ActorDetailResponse> getActorDetails() =>
      _movixerDataAgent.getActorDetails().then((value) {
        value.deathday =
            (value.deathday?.isEmpty ?? true) ? "-" : value.deathday;

        value.profilePath = (value.profilePath?.isEmpty ?? true)
            ? "/q1NRzyZQlYkxLY07GO9NVPkQnu8.jpg"
            : value.profilePath;
        return value;
      });

  Future<List<MovieVideoVO>> getMovieVideos() =>
      _movixerDataAgent.getMovieVideos().then((value) {
        List<MovieVideoVO> temp = [];
        for (MovieVideoVO vd in value) {
          if (vd.type == "Trailer" || vd.type == "Teaser") {
            temp.add(vd);
          }
        }
        return temp;
      });
}
