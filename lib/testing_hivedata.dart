//dart dev logging view debug for hive json data

import 'dart:convert';
import 'dart:developer' as developer;

import 'package:auth_request/models/movie_model.dart';
 

void main() {
  var myCustomObject = MovieModelAdapter();

  developer.log(
    'log me', 
    name: 'my.app.category',
    error: jsonEncode(myCustomObject),
  );
}