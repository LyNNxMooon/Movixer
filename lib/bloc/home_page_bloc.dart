import 'package:flutter/material.dart';

import 'package:movixer/data/model/movixer_model.dart';

import 'package:movixer/data/vos/actor_vos/actor_vo.dart';
import 'package:movixer/data/vos/genres_vos/genres_vos.dart';
import 'package:movixer/data/vos/movie_video_vos/movie_video_vo.dart';
import 'package:movixer/data/vos/movie_vos/movie_vo.dart';

class HomePageBloc extends ChangeNotifier {
  bool isDispose = false;
  final MovixerModel _movixerModel = MovixerModel();

  List<GenresVO> genresList = [];
  List<MovieVO> moviesByGenresList = [];
  List<MovieVO> popularMoviesList = [];
  List<MovieVO> topRatedMovieList = [];
  List<ActorVO> actorList = [];
  List<MovieVideoVO> videoList = [];

  HomePageBloc() {
    _movixerModel.getAllGenresList().then((value) {
      genresList = value;
      notifyListeners();
    });

    _movixerModel.getAllMoviesByGenres().then((value) {
      moviesByGenresList = value;
      notifyListeners();
    });

    _movixerModel.getAllMoviesTopRated().then((value) {
      topRatedMovieList = value;
      notifyListeners();
    });

    _movixerModel.getAllPopularMovies().then((value) {
      popularMoviesList = value;
      notifyListeners();
    });

    _movixerModel.getAllActorsList().then((value) {
      actorList = value;
      notifyListeners();
    });
  }

  void callMoviesByGenreApi() {
    _movixerModel.getAllMoviesByGenres().then((value) {
      moviesByGenresList = value;
      notifyListeners();
    });
  }

  void callMovieVideosApi() {
    _movixerModel.getMovieVideos().then((value) {
      videoList = value;
      notifyListeners();
    });
  }

  @override
  void notifyListeners() {
    if (!isDispose) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    isDispose = true;
    super.dispose();
  }
}
