import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_bloc/Data/models/note_modle.dart';

class NoteDetailScreen extends StatelessWidget {
  const NoteDetailScreen({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    Note note = ModalRoute.of(context)!.settings.arguments as Note;

    // TODO: implement build
    // throw UnimplementedError();
    return Scaffold(
      appBar: AppBar(
        title: Text(note.title!),
        centerTitle: true,
      ),
      body: Center(
        child: Text(note.body!),
      ),
    );
  }
}
