import 'package:flutter/material.dart';
import 'package:movixer/data/model/movixer_model.dart';
import 'package:movixer/data/vos/credits_vos/cast_vo.dart';
import 'package:movixer/data/vos/credits_vos/crew_vo.dart';
import 'package:movixer/data/vos/movie_detail_vos/production_companies_vo.dart';
import 'package:movixer/data/vos/movie_vos/movie_vo.dart';

class MovieDetailPageBloc extends ChangeNotifier {
  bool isDispose = false;
  final MovixerModel _movixerModel = MovixerModel();

  String moviePoster = '';
  String movieTitle = '';
  String movieOverview = '';
  List<ProductionCompanyVO> productionCompanyList = [];
  List<CastVO> castList = [];
  List<CrewVO> crewList = [];
  List<MovieVO> similarMovieList = [];

  MovieDetailPageBloc() {
    _movixerModel.getMovieDetails().then((value) {
      moviePoster = value.backdropPath ?? '';
      movieTitle = value.title;
      movieOverview = value.overview ?? '';
      productionCompanyList = value.productionCompanies;
      notifyListeners();
    });

    _movixerModel.getAllSimilarMovies().then((value) {
      similarMovieList = value;
      notifyListeners();
    });

    _movixerModel.getCredits().then((value) {
      castList = value.cast;
      crewList = value.crew;
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
