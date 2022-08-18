import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_bloc/Data/models/note_modle.dart';
import 'package:todo_bloc/Data/repositories/database_repo.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteRepository _noteRepository;
  NoteBloc({required NoteRepository noteRepository})
      : _noteRepository = noteRepository,
        super(NoteInitial()) {
    on<AddNoteEvent>(_addNoteEvent);
    on<EditNoteEvent>(_editNoteEvent);
    on<UpdateNoteEvent>(_updateNoteEvent);
    on<DeleteNoteEvent>(_deleteNoteEvent);
    on<LoadAllNoteEvent>(_loadAllNote);
  }

  FutureOr<void> _addNoteEvent(AddNoteEvent event, Emitter<NoteState> emit) {
    emit(NoteLoadingState());
    _noteRepository.createNote(Note(
      title: event.note.title,
      body: event.note.body,
      createdTime: event.note.createdTime,
    )).then((value) {
      if(value!=null){
        
      }
    });
  }

  FutureOr<void> _editNoteEvent(EditNoteEvent event, Emitter<NoteState> emit) {}

  FutureOr<void> _updateNoteEvent(
      UpdateNoteEvent event, Emitter<NoteState> emit) {}

  FutureOr<void> _deleteNoteEvent(
      DeleteNoteEvent event, Emitter<NoteState> emit) {}

  FutureOr<void> _loadAllNote(
      LoadAllNoteEvent event, Emitter<NoteState> emit) {}
}
