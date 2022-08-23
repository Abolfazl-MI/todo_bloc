import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/Data/models/note_modle.dart';
import 'package:todo_bloc/logic/logic.dart';

class EditNoteScreen extends StatefulWidget {
  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  TextEditingController titleController = TextEditingController();

  TextEditingController bodyController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        final dataPassed =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      Note? note = dataPassed['data'];
      titleController = TextEditingController(text: note!.title);
      bodyController = TextEditingController(text: note.body);

    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // throw UnimplementedError();

    final dataPassed =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    Note? note = dataPassed['data'];
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (titleController.text == note!.title ||
              bodyController.text == note.body ||
              titleController.text == note.title &&
                  bodyController.text == note.body) {
            Navigator.of(context).pop();
          } else {
            BlocProvider.of<NoteBloc>(context).add(UpdateNoteEvent(
              title: titleController.text,
              body: bodyController.text,
              currentIndex: dataPassed['index'],
            ));
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Navigator.of(context).pop();
            });
          }
        },
        child: Icon(Icons.save_outlined),
      ),
      body: _builtBody(context),
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
        child: SafeArea(
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
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.w700),
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
        ),
      );
    });
  }
}
