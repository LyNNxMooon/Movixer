import 'package:flutter/material.dart';
import 'package:movixer/data/model/movixer_model.dart';
import 'package:movixer/data/vos/movie_vos/movie_vo.dart';

class SearchMoviePageBloc extends ChangeNotifier {
  bool isDispose = false;
  final MovixerModel _movixerModel = MovixerModel();

  List<MovieVO> searchMovieList = [];

  void callSearchMovies() {
    _movixerModel.getSearchMovies().then((value) {
      searchMovieList = value;
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
