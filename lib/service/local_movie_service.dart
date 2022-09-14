

import 'package:hive_flutter/hive_flutter.dart';

import '../models/movie.dart';

class LocalMovieServie {
  late Box<Movie> _movieBox;

  Future<void> init() async {
    _movieBox = await Hive.openBox<Movie>('movies');
  }

  Future<void> assignAllAdBanners({required List<Movie> movies}) async {
    await _movieBox.clear();
    await _movieBox.addAll(movies);
  }

  List<Movie> getAllMovies() {
    return _movieBox.values.toList();
  }  
}