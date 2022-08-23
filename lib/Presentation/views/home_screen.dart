import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/Presentation/routes/routes.dart';

import 'package:todo_bloc/logic/note_bloc/note_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).pushNamed(AppRouteName.noteAddScreen);

          BlocProvider.of<NoteBloc>(context).add(LoadAllNoteEvent());
        },
        child: const Icon(
          Icons.note_add,
        ),
      ),
      appBar: AppBar(
        title: const Text('Notes app'),
        centerTitle: true,
        actions: [],
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocConsumer<NoteBloc, NoteState>(
            builder: (context, state) {
              if (state is NoteLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is NoteLoadedState) {
                if (state.loadedNotes.isEmpty) {
                  return const Center(
                    child: Text('no Note here :)'),
                  );
                } else {
                  return ListView.builder(
                    itemCount: state.loadedNotes.length,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: width,
                          height: 90,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  AppRouteName.noteDetailScree,
                                  arguments: state.loadedNotes[index]);
                            },
                            child: Card(
                              elevation: 8,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                        child: Text(
                                      state.loadedNotes[index].title!,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    )),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'created at : ${state.loadedNotes[index].createdTime}',
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                        Container(
                                          width: 100,
                                          height: 35,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                child: IconButton(
                                                    onPressed: () async {
                                                      await Navigator.of(
                                                              context)
                                                          .pushNamed(
                                                              AppRouteName
                                                                  .noteEditScreen,
                                                              arguments: {
                                                            'data': state
                                                                    .loadedNotes[
                                                                index],
                                                            'index': index
                                                          });
                                                      BlocProvider.of<NoteBloc>(
                                                              context)
                                                          .add(
                                                              LoadAllNoteEvent());
                                                    },
                                                    icon: Icon(
                                                        Icons.edit_outlined)),
                                              ),
                                              IconButton(
                                                  onPressed: () async {
                                                    BlocProvider.of<NoteBloc>(
                                                            context)
                                                        .add(DeleteNoteEvent(
                                                            state
                                                                .loadedNotes[
                                                                    index]
                                                                .title!));
                                                  },
                                                  icon: Icon(
                                                      Icons.delete_outlined)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                }
              }
              if (state is NoteErrorState) {
                return AlertDialog(
                  title: const Text('Error'),
                  content: Text(state.error),
                );
              }
              return Container();
            },
            listener: ((context, state) {}),
          )),
    );
  }
}
