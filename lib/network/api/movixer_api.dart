import 'package:dio/dio.dart';

import 'package:movixer/network/api_constant/api_constant.dart';
import 'package:movixer/network/response/actor_detail_response/actor_detail_response.dart';
import 'package:movixer/network/response/actors_response/actors_response.dart';
import 'package:movixer/network/response/credits_response/credits_response.dart';
import 'package:movixer/network/response/genres_response/genres_response.dart';
import 'package:movixer/network/response/movie_detail_response/movie_detail_response.dart';
import 'package:movixer/network/response/movie_top_rated_response/movie_top_rated_response.dart';
import 'package:movixer/network/response/movie_video_response/movie_video_response.dart';
import 'package:movixer/network/response/movies_by_genres_response/movies_by_genres_response.dart';
import 'package:movixer/network/response/popular_movie_response/popular_movies_response.dart';
import 'package:movixer/network/response/search_movie_response/search_movie_response.dart';
import 'package:movixer/network/response/similar_movies_response/similar_movies_response.dart';

import 'package:retrofit/http.dart';
part 'movixer_api.g.dart';

@RestApi(baseUrl: kBaseURL)
abstract class MovixerApi {
  factory MovixerApi(Dio dio) => _MovixerApi(dio);

  @GET(kEndPointForGenres)
  Future<GenresResponse> getAllGenres(@Query(kQueryParamsApiKey) String apiKey);

  @GET(kEndPointForMovieByGenres)
  Future<MoviesByGenresResponse> getAllMoviesByGenres(
      @Query(kQueryParamsKeyForMovieByGenres) int withGenres,
      @Query(kQueryParamsApiKey) String apiKey);

  @GET(kEndPointForSimilarMovies)
  Future<SimilarMoviesResponse> getAllSimilarMovies(
      @Path(kPathParamsMovieID) int id,
      @Query(kQueryParamsApiKey) String apiKey);

  @GET(kEndPointForPopularMovies)
  Future<PopularMoviesResponse> getAllPopularMovies(
      @Query(kQueryParamsApiKey) String apiKey);

  @GET(kEndPointForActors)
  Future<ActorsResponse> getAllActors(@Query(kQueryParamsApiKey) String apiKey);

  @GET(kEndPointForMovieTopRated)
  Future<MovieTopRatedResponse> getAllMoviesTopRated(
      @Query(kQueryParamsApiKey) String apiKey);

  @GET(kEndPointForMovieDetails)
  Future<MovieDetailResponse> getMovieDetails(
      @Query(kQueryParamsApiKey) String apiKey,
      @Path(kPathParamsMovieID) int movieID);

  @GET(kEndPointForSearchMovie)
  Future<SearchMovieResponse> getSearchedMovies(
      @Query(kQueryParamsApiKey) String apiKey,
      @Query(kQueryParamsKeyForSearchMovie) String query);

  @GET(kEndPointForCredits)
  Future<CreditsResponse> getCredits(@Query(kQueryParamsApiKey) String apiKey,
      @Path(kPathParamsMovieID) int movieID);

  @GET(kEndPointForActorDetails)
  Future<ActorDetailResponse> getActorDetails(
      @Query(kQueryParamsApiKey) String apiKey,
      @Path(kPathParamsActorID) int actorID);

  @GET(kEndPointForMovieVideo)
  Future<MovieVideoResponse> getMovieVideos(@Path(kPathParamsMovieID) int id,
      @Query(kQueryParamsApiKey) String apiKey);
}
