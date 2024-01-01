import 'package:hive/hive.dart';
import 'package:movixer/persistent/hive_constant.dart';

class MovixerDAO {
  MovixerDAO._();
  static final MovixerDAO _singleton = MovixerDAO._();
  factory MovixerDAO() => _singleton;

  Box<int> getGenreIDBox() => Hive.box<int>(kHiveGenreIDBox);
  Box<int> getMovieIDBox() => Hive.box<int>(kHiveMovieIDBox);
  Box<String> getSearchQueryBox() => Hive.box<String>(kHiveSearchQueryBox);
  Box<int> getActorIDBox() => Hive.box<int>(kHiveActorIDBox);

//save data

  void saveGenreID(int id) {
    getGenreIDBox().put(kHiveGenreIDKey, id);
  }

  void saveMovieID(int id) {
    getMovieIDBox().put(kHiveMovieIDKey, id);
  }

  void saveSearchMovieQuery(String query) {
    getSearchQueryBox().put(kHiveSearchQueryKey, query);
  }

  void saveActorID(int id) {
    getActorIDBox().put(kHiveActorIDKey, id);
  }

//get data
  int? get getGenreID => getGenreIDBox().get(kHiveGenreIDKey);
  int? get getMovieID => getMovieIDBox().get(kHiveMovieIDKey);
  String? get getSearchQuery => getSearchQueryBox().get(kHiveSearchQueryKey);
  int? get getActorID => getActorIDBox().get(kHiveActorIDKey);

//remove data
  void removeGenreID() => getGenreIDBox().delete(kHiveGenreIDKey);
}
