import 'dart:async';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/Data/models/note_modle.dart';
import 'package:todo_bloc/Data/repositories/database_repo.dart';
import 'package:todo_bloc/core/failure_modle.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteRepository _noteRepository;
  NoteBloc({required NoteRepository noteRepository})
      : _noteRepository = noteRepository,
        super(NoteLoadingState()) {
    on<AddNoteEvent>(_addNoteEvent);
    on<UpdateNoteEvent>(_updateNoteEvent);
    on<DeleteNoteEvent>(_deleteNoteEvent);
    on<LoadAllNoteEvent>(_loadAllNote);
    on<IntitNoteDB>(_initDb);
  }

  List<Note> notes = [];

  FutureOr<void> _addNoteEvent(
      AddNoteEvent event, Emitter<NoteState> emit) async {
    log('***********adding new note to db***********', name: 'NOTE_BLOC');
    emit(NoteLoadingState());
    Either<NoteError, Note> createdNote = await _noteRepository.createNote(Note(
      title: event.note.title,
      body: event.note.body,
      createdTime: event.note.createdTime,
    ));
    createdNote.fold(
      (NoteError error) => emit(NoteErrorState(error.errorMsg!)),
      (Note note) {
        notes.add(note);
        emit(NoteLoadedState(notes));
      },
    );
  }

  FutureOr<void> _deleteNoteEvent(
      DeleteNoteEvent event, Emitter<NoteState> emit) async {
    log('***********deleting note from db***********', name: 'NOTE_BLOC');

    emit(NoteLoadingState());
    Either<NoteError, Note> resualt =
        await _noteRepository.deletNoteFromDb(event.title);
    resualt.fold(
      (NoteError error) => emit(NoteErrorState(error.errorMsg!)),
      (Note note) {
        notes.remove(note);
        emit(NoteLoadedState(notes));
      },
    );
  }

  FutureOr<void> _loadAllNote(
      LoadAllNoteEvent event, Emitter<NoteState> emit) async {
    log('***********loading all notes from db***********', name: 'NOTE_BLOC');

    emit(NoteLoadingState());
    Either<NoteError, List<Note>> resualt = await _noteRepository.getAllNotes();
    resualt.fold(
      (NoteError error) => emit(NoteErrorState(error.errorMsg!)),
      (List<Note> loadedNotes) {
        notes = loadedNotes;
        emit(NoteLoadedState(notes));
      },
    );
  }

  FutureOr<void> _updateNoteEvent(
      UpdateNoteEvent event, Emitter<NoteState> emit) async {
    log('***********updating note***********', name: 'NOTE_BLOC');

    emit(NoteLoadingState());
    if (event.title != null) {
      Either<NoteError, Note> resualt = await _noteRepository.updateNote(
          currentTitle: event.currentTitle, title: event.title);
      resualt.fold(
        (NoteError error) => emit(NoteErrorState(error.errorMsg.toString())),
        (Note note) {
          var curentNote = notes
              .firstWhere((element) => element.title == event.currentTitle);
          var newNote = curentNote.copyWith(title: note.title, body: note.body);
          notes.remove(curentNote);
          notes.add(newNote);
          emit(NoteLoadedState(notes));
        },
      );
    }
    if (event.body != null) {
      Either<NoteError, Note> resualt = await _noteRepository.updateNote(
          currentTitle: event.currentTitle, body: event.body);
      resualt.fold(
        (NoteError error) => emit(NoteErrorState(error.errorMsg!)),
        (Note note) {
          var curentNote = notes
              .firstWhere((element) => element.title == event.currentTitle);
          var newNote = curentNote.copyWith(body: note.body);
          notes.remove(curentNote);
          notes.add(newNote);
          emit(NoteLoadedState(notes));
        },
      );
    }

    if (event.body != null && event.title != null) {
      Either<NoteError, Note> resualt = await _noteRepository.updateNote(
          currentTitle: event.currentTitle,
          body: event.body,
          title: event.title);
      resualt.fold(
        (NoteError error) => emit(NoteErrorState(error.errorMsg!)),
        (Note note) {
          var curentNote = notes
              .firstWhere((element) => element.title == event.currentTitle);
          var newNote = curentNote.copyWith(body: note.body, title: note.title);
          notes.remove(curentNote);
          notes.add(newNote);
          emit(NoteLoadedState(notes));
        },
      );
    }

    if (event.title == null && event.body == null) {
      emit(NoteErrorState('No title or body changes for update'));
    }
  }

  FutureOr<void> _initDb(IntitNoteDB event, Emitter<NoteState> emit) async {
    log('***********initing db***********', name: 'NOTE_BLOC');

    Either<NoteError, List<Note>> resualt =
        await _noteRepository.initDataBase();
    resualt.fold(
      (NoteError error) => emit(NoteErrorState(error.errorMsg.toString())),
      (List<Note>dbNotes) => emit(NoteLoadedState(dbNotes)),
    );
  }
}
