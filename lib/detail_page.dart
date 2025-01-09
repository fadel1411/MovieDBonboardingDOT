import 'dart:convert';
 
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'api_key.dart';
import 'models/movie.dart'; 
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
class DetailPage extends StatelessWidget {
  final Movie? movies; 
  const DetailPage({
    Key? key, 
    this.movies, 
    }) : super(key: key);     
  // final List<Movie> movie_detail;
 
  @override
  Widget build(BuildContext context) {
     Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.redAccent;
      }
      return Colors.yellow;
    }
    return Stack(
      children: <Widget>[
        Container (
          padding: const EdgeInsets.only(top: 200.0),
        decoration:  BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.center,
            image: NetworkImage(
              'https://image.tmdb.org/t/p/original/${movies?.poster_path ?? " "}'
              ),
              fit: BoxFit.fitWidth,
              ),
        ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Colors.green.withAlpha(40),
                Colors.black26,
                Colors.red.shade300
              ]
            )
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 280, left: 12, right: 12),
              child: Column(
              children: [ 
                // Text(movies!.poster_path)
                const Icon(
                  Icons.play_circle_fill, 
                  size: 48, 
                  color: Colors.grey,),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(movies!.original_title, style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    height: 2
                    ),
                  ),
                ),
                RatingBarIndicator(
                      rating: 3.75,
                    // ignore: prefer_const_constructors
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 24.0,
                      direction: Axis.horizontal,
                    ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    
                    Text(
                      movies!.release_date,
                      style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 18,
                        fontWeight: FontWeight.bold), 
                        textAlign: TextAlign.right,
                    ),
                    const Text("| 2 hr 30 min",
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text("| 2 hr 30 min",
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      ),
                    ),
                    ],
                  ),
                    const Divider(height: 1.0, color: Colors.white,),
                  // SizedBox(width: 100, height: 40),
                    Padding(
                      padding: EdgeInsets.only(top: 40, left: 24, right: 24),
                      child: Column(
                        children : [
                          const Text("Storyline", 
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 8,),
                            Text(movies!.overview,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16),
                            ),  
                            ElevatedButton( 
                                style: ButtonStyle( 
                                    backgroundColor: MaterialStateProperty.resolveWith(getColor)
                                  ),
                                onPressed: () { 
                              }, child:  const Text("Buy Now", style: TextStyle(color: Colors.black),)
                            ), 
                        ],                  
                      ),
                    ),  
                  ],
                ),  
              ),
            ), 
          ),
        ), 
      ]
    );
  }
}
Future<List<Movie>> fetchmovie_detailDetail(http.Client client) async {                 
  final response = await client
      .get(Uri.parse('https://api.themoviedb.org/3/trending/movie/week?api_key=$apiKey'),); 

    // Use the compute funtion to run fetchmovie_detail in a separate isolate
 // docs: https://docs.flutter.dev/cookbook/networking/background-parsing
    return compute(parsemovie, response.body);
}
// A function that converts a response body into a List<Movie>.
List<Movie> parsemovie(String responseBody) {
  // decode json from trending data
  final parsed = jsonDecode(responseBody)['results'];
  return parsed.map<Movie>((json) => Movie.fromJson(json)).toList();
}
