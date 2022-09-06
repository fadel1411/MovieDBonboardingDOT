import 'dart:convert';

import 'package:flutter/material.dart';

import 'detail_page.dart';
import 'models/movie_response.dart';

import 'package:auth_request/api_key.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<List<Movie>> fetchMovies(http.Client client) async {
  final response = await client
      .get(Uri.parse('https://api.themoviedb.org/3/trending/movie/week?api_key=$apiKey')); 

    // Use the compute funtion to run fetchMovies in a separate isolate
    return compute(parseMovies, response.body);
}
// A function that converts a response body into a List<Movie>.
List<Movie> parseMovies(String responseBody) {
  // decode json from trending data
  final parsed = jsonDecode(responseBody)['results'];

  return parsed.map<Movie>((json) => Movie.fromJson(json)).toList();
}
 
class MovieApp extends StatefulWidget {
  const MovieApp({super.key});

  @override
  MovieAppState createState() => MovieAppState();
}

class MovieAppState extends State<MovieApp> {
  late Future<Movie> futureAlbum;

  @override
  void initState() {
    super.initState(); 
  }
  
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'MovieDB List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('MovieDB List'),
        ),
        body: Center( 
          child: FutureBuilder<List<Movie>>(
            future: fetchMovies(http.Client()),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('${snapshot.error}');
                
              } else if (snapshot.hasData) { 
                return MoviesList(movies: snapshot.data!);
          } else {
            return  const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    ),
      ),
    );
  }
}

// 
class MoviesList extends StatelessWidget {
  const MoviesList({super.key, required this.movies});

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 20,
        mainAxisSpacing: 40,

      ), 
      // padding: EdgeInsets.all(20),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () { 
            Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context) => DetailPage(movies : movies[index]) ));
          },
          child: MovieCard(movies: movies, index: index,));
        
      },
    );
  }
}

class MovieCard extends StatelessWidget {
  const MovieCard({
    Key? key,
    required this.movies,
    required this.index,
  }) : super(key: key);

  final List<Movie> movies;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Image.network(
        'https://image.tmdb.org/t/p/original/${movies[index].poster_path}',
        fit: BoxFit.fitWidth,   //   frameBuilder: (context, child, frame, wasSynchronouslyLoaded) => Padding(padding: EdgeInsets.all(4)) ,
      ),
    );
  }
}
                
                // Card(
                //   child: Column(
                //     children: [
                //       FittedBox(
                //         child: Image.network('https://image.tmdb.org/t/p/original/$image',
                //         fit: BoxFit.cover, 
                //         height: 200,
                //         width: 100,)
                //         ),
                //       Text(snapshot.data!.original_title),
                //       Text(snapshot.data!.release_date),
                //       Positioned(
                //     bottom: 100,
                //     left: 100,
                //     right: 100,
                //     child: Text(
                //       snapshot.data!.original_title,
                //     )
                //   )
                //     ],
                //   ), 
                // );

                // card widget end

                // Image.network('https://image.tmdb.org/t/p/original/$image'); 
                // return Text(snapshot.data!.overview);
//               }

              // By default, show a loading spinner.
//               return const CircularProgressIndicator();
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
