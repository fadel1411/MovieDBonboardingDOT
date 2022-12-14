 import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart'; 
import 'app.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'bloc/simple_bloc_observer.dart'; 
import 'models/movie_model.dart';

Future<void> main() async {  
  
  pathProvider.getApplicationDocumentsDirectory();
  WidgetsFlutterBinding.ensureInitialized();
  // await Hive.initFlutter();

  // // register adapter 
  await Hive.initFlutter();
  Hive.registerAdapter(MovieModelAdapter());
  var box = await Hive.openBox('movie');

  

  Bloc.observer = SimpleBlocObserver();
  runApp(const App());
}
  