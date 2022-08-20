import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_bloc/Data/repositories/database_repo.dart';
import 'package:todo_bloc/Presentation/cubit/theme_cubit_cubit.dart';

import 'package:todo_bloc/Presentation/note_bloc/note_observer.dart';
import 'package:todo_bloc/Presentation/views/home_screen.dart';
import 'package:todo_bloc/Presentation/views/note_detail_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  BlocOverrides.runZoned(() {
    runApp(const MyApp());
  }, blocObserver: NoteObserver());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      // themeMode: state is LightThemeCubitState ?ThemeMode.light:ThemeMode.dark,
      // home: RepositoryProvider(
      //   create: (context) => NoteRepository(),
      //   child: const HomeScreen(),
      // ),
      initialRoute: '/',
      routes: {
        '/': (context) => RepositoryProvider(
              create: (context) => NoteRepository(),
              child: HomeScreen(),
            ),
        '/note_detail': (context) => NoteDetailScreen()
      },
    );
  }
}
