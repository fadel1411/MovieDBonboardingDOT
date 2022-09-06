import 'dart:convert';

import 'package:auth_request/app.dart';
import 'package:auth_request/models/movie_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

import 'api_key.dart';
import 'models/movie_detail.dart';

class DetailPage extends StatelessWidget {
  final Movie? movies;
  
  const DetailPage({
    Key? key, 
    this.movies, 
    }) : super(key: key);
       
  // final List<Movie> movie_detail;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movies?.original_title ?? ""),
      ),
      body: SingleChildScrollView(
        child: Column(
        children: [ 
          // Text(movies!.poster_path)
          ClipRRect(
            borderRadius: BorderRadius.circular(40.0),
            child: Image.network('https://image.tmdb.org/t/p/original/${movies?.poster_path ?? " "}',
            fit: BoxFit.fitWidth,
            ),
          ),
          Text(movies!.original_t
        ),
      ),
    );
  }
}
Future<List<MovieDetail>> fetchmovie_detailDetail(http.Client client) async {                 
  final response = await client
      .get(Uri.parse('https://api.themoviedb.org/3/movies/550?api_key=$apiKey'),); 

    // Use the compute funtion to run fetchmovie_detail in a separate isolate
    return compute(parsemovie_detail, response.body);
}
// A function that converts a response body into a List<Movie>.
List<MovieDetail> parsemovie_detail(String responseBody) {
  // decode json from trending data
  final parsed = jsonDecode(responseBody)['results'];

  return parsed.map<MovieDetail>((json) => MovieDetail.fromJson(json)).toList();
}