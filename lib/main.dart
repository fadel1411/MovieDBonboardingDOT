 import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;


import 'app.dart';
import 'bloc/simple_bloc_observer.dart';
import 'models/adapter_movie.dart';

void main() async { 
  // pathProvider.getApplicationDocumentsDirectory();
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // register adapter 
  Hive.registerAdapter(MovieAdapterAdapter());

  Bloc.observer = SimpleBlocObserver();
  runApp(App());
}
  