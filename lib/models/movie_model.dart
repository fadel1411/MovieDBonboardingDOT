import 'package:hive/hive.dart';

part 'movie_model.g.dart';
@HiveType(typeId: 1)
class MovieModel  {
  @HiveField(0) 
  String original_title;

  @HiveField(1) 
  String overview;   

  @HiveField(2)
  String poster_path;

  @HiveField(3) 
  String release_date;

  void getItem() {} 
   MovieModel(this.original_title, this.overview, this.poster_path, this.release_date);
}
