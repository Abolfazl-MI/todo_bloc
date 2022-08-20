import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/Data/repositories/database_repo.dart';
// import 'package:todo_bloc/Presentation/bloc/note_bloc.dart';
import 'package:todo_bloc/Presentation/note_bloc/note_bloc.dart';
import 'package:todo_bloc/Presentation/views/note_detail_screen.dart';
import 'package:zefyrka/zefyrka.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    ZefyrController controller = ZefyrController();
    return BlocProvider(
      lazy: false,
      create: (context) => NoteBloc(
        noteRepository: RepositoryProvider.of(context),
      )..add(IntitNoteDB()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Notes app'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.light),
            )
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocConsumer<NoteBloc, NoteState>(
              builder: (context, state) {
                if (state is NoteLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is NoteLoadedState) {
                  if (state.loadedNotes.isEmpty) {
                    return Center(
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
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                          child: Text(
                                        state.loadedNotes[index].title!,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      )),
                                      Text(
                                        'created at : ${state.loadedNotes[index].createdTime}',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                                elevation: 8,
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
                    title: Text('Error'),
                    content: Text(state.error),
                  );
                }
                return Container();
              },
              listener: ((context, state) {}),
            )),
      ),
    );
  }
}


/* 
ListView.builder(
            itemCount: 20,
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                                child: Text(
                              'Title',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            )),
                            Text(
                              'created at : 1400/4/27',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      elevation: 8,
                    ),
                  ),
                ),
              );
            }),
          ),

 */