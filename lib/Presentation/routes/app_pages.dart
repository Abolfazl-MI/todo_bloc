import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/Data/repositories/database_repo.dart';

import '../../logic/logic.dart';
import '../views/views.dart';
import 'app_route_name.dart';

class AppPages {
  static Map<String, Widget Function(BuildContext)> routes = {
    AppRouteName.noteHomeScreen: (context) => BlocProvider(
          create: (context) => NoteBloc(noteRepository: NoteRepository()),
          child: const HomeScreen(),
        ),
    AppRouteName.noteAddScreen: (context) => BlocProvider(
        create: (context) => NoteBloc(noteRepository: NoteRepository())),
    AppRouteName.noteEditScreen: (context) => BlocProvider(
          create: (context) => NoteBloc(noteRepository: NoteRepository()),
          child: EditNoteScreen(),
        ),
    AppRouteName.noteDetailScree: (context) => NoteDetailScreen()
  };
}
// Widget Function(BuildContext

// 