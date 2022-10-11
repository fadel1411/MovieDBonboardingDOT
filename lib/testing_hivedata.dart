//dart dev logging view debug for hive json data

import 'dart:convert';
import 'dart:developer' as developer;

import 'models/movie_model.dart';

 

void main() {
  var myCustomObject = MovieModelAdapter();

  developer.log(
    'log me', 
    name: 'my.app.category',
    error: jsonEncode(myCustomObject),
  );
}
