import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_bloc/Data/repositories/database_repo.dart';
import 'package:todo_bloc/Presentation/routes/app_pages.dart';
import 'package:todo_bloc/Presentation/routes/app_route_name.dart';

import 'package:todo_bloc/Presentation/views/add_note.dart';
import 'package:todo_bloc/Presentation/views/edit_note.dart';
import 'package:todo_bloc/Presentation/views/home_screen.dart';
import 'package:todo_bloc/Presentation/views/note_detail_screen.dart';

import 'package:todo_bloc/logic/note_bloc/note_bloc.dart';
import 'package:todo_bloc/logic/note_bloc/note_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  BlocOverrides.runZoned(() {
    runApp(MyApp());
  }, blocObserver: NoteObserver());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      initialRoute: AppRouteName.noteHomeScreen,
      routes:AppPages.routes
    );
  }
}
