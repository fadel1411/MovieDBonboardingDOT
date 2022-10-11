part of 'movie_bloc.dart';



abstract class MovieEvent extends Equatable {
  @override
  List<Object> get props => [];
}


class MovieFetched extends MovieEvent {
 //hive flutter changenotifier
  // addItem(MovieModel item) async {
  //   var box = await Hive.openBox<MovieModel>('movie');

  //   box.add(item);
 
  // }
}
 

 