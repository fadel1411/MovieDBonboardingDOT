import 'package:flutter/material.dart';

import '../models/movie.dart';

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
    return Stack(children: [
      Container(
        decoration: BoxDecoration(
          color: const Color(0xFFECEFF1),
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage(
                'https://image.tmdb.org/t/p/w500${movies[index].poster_path}'),
            fit: BoxFit.fitHeight,
          ),
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
        ),
      ),
    ]);
  }
}
