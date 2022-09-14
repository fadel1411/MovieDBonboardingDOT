 import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';


import '../api_key.dart'; 
import '../models/movie.dart';

part 'movie_event.dart';
part 'movie_state.dart';
 
const _movieLimit = 20;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttleTime(duration), mapper);
  };
}


class MovieBloc extends Bloc<MovieEvent, MovieState> {
    MovieBloc({required this.httpClient}) : super(const MovieState()) {
      on <MovieFetched>(
        _onMovieFetched,
        transformer: throttleDroppable(throttleDuration),
        );
  }
  Future<void> _onMovieFetched(MovieFetched event, Emitter<MovieState> emit) async {
    try {
      if (state.status == MovieStatus.initial) {
        final movies = await _fetchMovies(1);
        return emit(state.copyWith(
          status: MovieStatus.success,
          movies: movies,
          hasReachedMax: false,
        ));
      }
      final movies = await _fetchMovies(state.movies.length ~/ 20 + 1);
      if (movies.isEmpty) {
        return emit(state.copyWith(hasReachedMax: true));
      }
      return emit(state.copyWith(
        status: MovieStatus.success,
        movies: List.of(state.movies)..addAll(movies),
        hasReachedMax: false,
      ));
    } catch (_) {
      return emit(state.copyWith(status: MovieStatus.failure));
    }
  }
  
      /// register on<MovieFetched> event
      Future<List<Movie>> _fetchMovies([int startIndex = 0]) async {
    final response = await httpClient.get(Uri.parse(
        'https://api.themoviedb.org/3/trending/movie/week?api_key=$apiKey'));

    // Use the compute funtion to run fetchMovies in a separate isolate
    return compute(parseMovies, response.body);
    
    }

// A function that converts a response body into a List<Movie>.
    List<Movie> parseMovies(String responseBody) {
      // decode json from trending data
      final parsed = jsonDecode(responseBody)['results'];

      return parsed.map<Movie>((json) => Movie.fromJson(json)).toList();
    }
    
    final http.Client httpClient;
  }