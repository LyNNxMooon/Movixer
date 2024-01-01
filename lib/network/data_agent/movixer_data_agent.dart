import 'package:movixer/data/vos/actor_vos/actor_vo.dart';
import 'package:movixer/data/vos/genres_vos/genres_vos.dart';
import 'package:movixer/data/vos/movie_video_vos/movie_video_vo.dart';
import 'package:movixer/data/vos/movie_vos/movie_vo.dart';
import 'package:movixer/network/response/actor_detail_response/actor_detail_response.dart';
import 'package:movixer/network/response/credits_response/credits_response.dart';
import 'package:movixer/network/response/movie_detail_response/movie_detail_response.dart';

abstract class MovixerDataAgent {
  Future<List<GenresVO>> getGenresList();
  Future<List<MovieVO>> getMoviesByGenres();
  Future<List<MovieVO>> getSimilarMovies();
  Future<List<MovieVO>> getPopularMovies();
  Future<List<ActorVO>> getActorList();
  Future<List<MovieVO>> getMovieTopRated();
  Future<MovieDetailResponse> getMovieDetail();
  Future<List<MovieVO>> getSearchMovies();
  Future<CreditsResponse> getCredits();
  Future<ActorDetailResponse> getActorDetails();
  Future<List<MovieVideoVO>> getMovieVideos();
}
