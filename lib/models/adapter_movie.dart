// ignore_for_file: non_constant_identifier_names

import 'package:auth_request/models/movie.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
 
part 'adapter_movie.g.dart';



    
@HiveType(typeId: 1)
class MovieAdapter{
  @HiveField(0) 
  late String original_title;

  @HiveField(1) 
  late String overview;   

  @HiveField(2)
  late String poster_path;

  @HiveField(3) 
  late String release_date;

}
