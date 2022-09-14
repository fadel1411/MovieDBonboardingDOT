// import 'dart:convert';
 
import 'package:flutter/material.dart';

import 'home_page.dart';

// import 'models/movie.dart';
// import 'detail_page.dart';
// import 'home_page.dart'; 
// import 'package:auth_request/api_key.dart';
// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';


class App extends MaterialApp {
  const App({super.key}) : super(home: const HomePage());
}

// class MovieApp extends StatefulWidget {
//   const MovieApp({super.key})

//   @override
//   MovieAppState createState() => MovieAppState();
// }

// class MovieAppState extends State<MovieApp> {
//   late Future<Movie> futureAlbum;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'MovieDB List',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         textTheme: GoogleFonts.poppinsTextTheme(
//           Theme.of(context).textTheme,
//         ),
//         scaffoldBackgroundColor: Colors.purple[200],
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('MovieDB List'),
//         ),
//         body: Center(
//           child: FutureBuilder<List<Movie>>(
//             future: fetchMovies(http.Client()),
//             builder: (context, snapshot) {
//               if (snapshot.hasError) {
//                 return Text('${snapshot.error}');
//               } else if (snapshot.hasData) {
//                 return MoviesList(movies: snapshot.data!);
//               } else {
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

// //
// class MoviesList extends StatelessWidget {
//   const MoviesList({super.key, required this.movies});

//   final List<Movie> movies;

//   @override
//   Widget build(BuildContext context) {
//     // return BlocBuilder<MovieCubit, MovieSuccess>( 
//     //   builder: (context, state) {
//         return Padding(
//           padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
//           child: GridView.builder(
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               crossAxisSpacing: 20,
//               mainAxisSpacing: 20,
//             ),
//             // padding: EdgeInsets.all(20),
//             itemCount: 20,
//             itemBuilder: (context, index) {
//               return InkWell(
//                   onTap: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) =>
//                                 DetailPage(movies: movies[index])));
//                   },
//                   child: MovieCard(
//                     movies: movies,
//                     index: index,
//                   ));
//             },
//           ),
//         );
//       }
//     // );
//   }

// class MovieCard extends StatelessWidget {
//   const MovieCard({
//     Key? key,
//     required this.movies,
//     required this.index,
//   }) : super(key: key);

//   final List<Movie> movies;
//   final int index;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(children: [
//       Container(
//         decoration: BoxDecoration(
//           color: const Color(0xFFECEFF1),
//           borderRadius: BorderRadius.circular(10),
//           image: DecorationImage(
//             image: NetworkImage(
//                 'https://image.tmdb.org/t/p/w500${movies[index].poster_path}'),
//             fit: BoxFit.fitHeight,
//           ),
//           border: Border.all(
//             color: Colors.black,
//             width: 2,
//           ),
//         ),
//       ),
//     ]);
//   }
// }
