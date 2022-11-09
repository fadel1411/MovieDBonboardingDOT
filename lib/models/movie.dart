import 'dart:convert';
import 'dart:ffi';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';


// A function that converts a response body into a List<Movie>.
    List<Movie> parseMovies(String responseBody) {
      // decode json from trending data
      final parsed = jsonDecode(responseBody)['results'];

      return parsed.map<Movie>((json) => Movie.fromJson(json)).toList();
    }
    
class Movie extends Equatable {     
  final String original_title;
  final String overview;
  final String poster_path; 
  final String backdrop_path; 
  final String release_date;
  // final String vote_average;
  // final int genre_id;

  const Movie({     
    required this.original_title,
    required this.overview,
    required this.poster_path,
    required this.release_date, 
    required this.backdrop_path,
    // required this.vote_average,
    // required this.genre_id,
    
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(  
      original_title: json['original_title'],
      overview: json['overview'],
      poster_path: json['poster_path'], 
      release_date: json['release_date'],
      backdrop_path: json['backdrop_path'],
      // vote_average: json['vote_average'],
      // genre_id: json['genre_id'],
    );

  @override
  List<Object?> get props => [original_title, overview, poster_path, release_date, backdrop_path];
}

  