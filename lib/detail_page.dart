import 'dart:convert';
 
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'api_key.dart';
import 'models/movie.dart'; 
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
        centerTitle: true,
        title: Text(movies?.original_title ?? ""),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
          children: [ 
            // Text(movies!.poster_path)
            SizedBox(
              width: 360.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40.0),
                child: Image.network('https://image.tmdb.org/t/p/original/${movies?.poster_path ?? " "}',
                fit: BoxFit.fitWidth,
                ),
              ),
            ), 
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(movies!.original_title, style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              height: 2
                ),
              ),
            ),
             Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    movies!.release_date,
                    style: const TextStyle(fontSize: 14,
                    fontWeight: FontWeight.bold), 
                    textAlign: TextAlign.right,
                  ),
                  const Icon(Icons.date_range, color: Colors.yellow,),
                        ],
                ),
                const Divider(height: 1.0, color: Colors.white,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(movies!.overview,
              style: const TextStyle(fontSize: 18),
              ),
            ),            
             
              ],
              ),  
          ),
      ), 
    );
  }
}
Future<List<Movie>> fetchmovie_detailDetail(http.Client client) async {                 
  final response = await client
      .get(Uri.parse('https://api.themoviedb.org/3/trending/movie/week?api_key=$apiKey'),); 

    // Use the compute funtion to run fetchmovie_detail in a separate isolate
    return compute(parsemovie, response.body);
}
// A function that converts a response body into a List<Movie>.
List<Movie> parsemovie(String responseBody) {
  // decode json from trending data
  final parsed = jsonDecode(responseBody)['results'];

  return parsed.map<Movie>((json) => Movie.fromJson(json)).toList();
}