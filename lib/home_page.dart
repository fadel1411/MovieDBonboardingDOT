import 'package:auth_request/widget/movie_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'bloc/movie_bloc.dart';

class HomePage extends StatelessWidget {
    const HomePage({super.key});

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('List of Movie')),
      body: BlocProvider(
        create: (context) => MovieBloc(httpClient: http.Client())
          ..add(MovieFetched()),
        // mungkin array
        child: const MovieList(movies: [],),
      ),
    );
  }
}