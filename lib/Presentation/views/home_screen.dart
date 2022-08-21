import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/Presentation/note_bloc/note_bloc.dart';
import 'package:todo_bloc/Presentation/views/note_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context)
              .pushNamed('/note_add_update', arguments: {'pageType': 'add'});
          // context.watch<NoteBloc>().add(LoadAllNoteEvent());
          BlocProvider.of<NoteBloc>(context).add(LoadAllNoteEvent());
        },
        child: const Icon(
          Icons.note_add,
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      appBar: AppBar(
        title: const Text('Notes app'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.light),
          )
        ],
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
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => NoteDetailScreen()));
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
                                    Text(
                                      'created at : ${state.loadedNotes[index].createdTime}',
                                      style: const TextStyle(fontSize: 12),
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
