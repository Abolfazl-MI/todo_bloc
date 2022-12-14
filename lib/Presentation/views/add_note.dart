import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/Data/models/note_modle.dart';

import 'package:todo_bloc/logic/note_bloc/note_bloc.dart';

class AddNoteScreen extends StatelessWidget {
  AddNoteScreen({
    super.key,
  });
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (titleController.text.isNotEmpty &&
                bodyController.text.isNotEmpty) {
              Note createdNote = Note(
                  title: titleController.text,
                  body: bodyController.text,
                  createdTime: DateTime.now()
                      .toString()
                      .split(' ')[0]
                      .replaceAll('-', '/'));
              BlocProvider.of<NoteBloc>(context, listen: false)
                  .add(AddNoteEvent(createdNote));
              Navigator.of(context).pop();
            } else {
              showCupertinoModalPopup(
                context: context,
                builder: ((context) => _alertDialog(context)),
              );
            }
          },
          child: const Icon(Icons.save_outlined),
        ),
        appBar: AppBar(
          title: Text('Create Your Note'),
          centerTitle: true,
        ),
        body: _builtBody(
          context,
        ));
  }

  AlertDialog _alertDialog(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          Icon(
            Icons.dangerous_outlined,
            // color: Colors.red,
          ),
          Text('Error'),
        ],
      ),
      content: const Text('title and body shouldn\'t be empty'),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('ok'))
      ],
    );
  }

  _builtBody(
    BuildContext context,
  ) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<NoteBloc, NoteState>(builder: (context, state) {
      if (state is NoteLoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is NoteErrorState) {
        log(state.error);
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          showCupertinoModalPopup(
            context: context,
            builder: (context) => AlertDialog(
                  content: Text(state.error),
                ));
        });
      }

      return SizedBox(
        // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        width: size.width,
        height: size.height,
        // color: Colors.green,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: size.width,
              height: 100,
              // color: Colors.amber,
              child: Center(
                child: TextFormField(
                  controller: titleController,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.w700),
                  decoration: const InputDecoration(
                    hintText: 'Note Title...',
                    hintStyle: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const Divider(),
            Expanded(
                child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                validator: ((value) {
                  if (value == null) return 'body shouldn\'t be Empty';
                  return null;
                }),
                controller: bodyController,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                decoration: const InputDecoration(
                  hintText: 'your note body will go here..',
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                maxLines: 100,
              ),
            ))
          ],
        ),
      );
    });
  }
}
