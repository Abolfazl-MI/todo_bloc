import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_bloc/Data/repositories/database_repo.dart';

import 'package:todo_bloc/Presentation/views/add_update_note_view.dart';
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
  MyApp({Key? key}) : super(key: key);

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
      initialRoute: '/',
      routes: {
        '/': (context) => RepositoryProvider(
            create: (context) => NoteRepository(),
            child: BlocProvider(
              create: (context) =>
                  NoteBloc(noteRepository: RepositoryProvider.of(context))
                    ..add(IntitNoteDB()),
              child: HomeScreen(),
            )),
        '/note_add_update': (context) => BlocProvider(
            create: (context) => NoteBloc(noteRepository: NoteRepository()),
            child: AddUpdateNoteScreen()),
          '/note_detail':(context) => NoteDetailScreen()
      },
    );
  }
}
