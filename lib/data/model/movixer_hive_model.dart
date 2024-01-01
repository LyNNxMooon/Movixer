import 'package:movixer/persistent/dao/movixer_hive.dart';

class MovixerHiveModel {
  MovixerHiveModel._();
  static final MovixerHiveModel _singleton = MovixerHiveModel._();
  factory MovixerHiveModel() => _singleton;
  final MovixerDAO _movixerDAO = MovixerDAO();

  //save data

  void saveGenreID(int id) {
    _movixerDAO.saveGenreID(id);
  }

  void saveMovieID(int id) {
    _movixerDAO.saveMovieID(id);
  }

  void saveSearchQuery(String query) {
    _movixerDAO.saveSearchMovieQuery(query);
  }

  void saveActorID(int id) {
    _movixerDAO.saveActorID(id);
  }

  //get data

  int get getGenreID => _movixerDAO.getGenreID ?? 28;
  int get getMovieID => _movixerDAO.getMovieID ?? 901362;
  String get getSearchQuery => _movixerDAO.getSearchQuery ?? '';
  int get getActorID => _movixerDAO.getActorID ?? 974169;

  //remove data
  void removeGenreID() => _movixerDAO.removeGenreID();
}
