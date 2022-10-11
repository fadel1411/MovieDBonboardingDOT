import 'package:auth_request/bloc/movie_bloc.dart';
import 'package:auth_request/detail_page.dart';
import 'package:auth_request/models/movie_model.dart';
import 'package:auth_request/widget/movie_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:logging/logging.dart';

import '../models/movie.dart';
import 'bottom_loader.dart';

final log = Logger('ExampleLogger');

class MovieList extends StatefulWidget {
  const MovieList({super.key, required this.movies});
  final List<Movie> movies;

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    
  }

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => MovieBloc(httpClient: Client())..add(MovieFetched()),
      child: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          switch (state.status) {
            case MovieStatus.failure:
              return const Center(child: Text('failed to fetch movies'));
            case MovieStatus.success:
              if (state.movies.isEmpty) {
                return const Center(child: Text('no movies'));
              }
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return index >= state.movies.length
                      ? const BottomLoader()
                      : InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailPage(movies: state.movies[index]),
                              ),
                            );
                          },
                          child: MovieCard(
                            movies: state.movies,
                            index: index,
                          ));
                },
                itemCount: state.hasReachedMax
                    ? state.movies.length
                    : state.movies.length + 1,
                controller: _scrollController,
              );
            case MovieStatus.initial:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  // @override
  // void dispose() {
  //   _scrollController
  //     ..removeListener(_onScroll)
  //     ..dispose();
  //   super.dispose();
  // }

  void _onScroll() {
    if (_isBottom) context.read<MovieBloc>();
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
} 