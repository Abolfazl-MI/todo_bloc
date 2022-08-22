part of 'note_bloc.dart';

abstract class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object> get props => [];
}

class AddNoteEvent extends NoteEvent {
  final Note note;

  const AddNoteEvent(this.note);
}

class DeleteNoteEvent extends NoteEvent {
  final String title;

  const DeleteNoteEvent(this.title);
}

class UpdateNoteEvent extends NoteEvent {
  final String title;
  final String body;
  final int currentIndex;
  const UpdateNoteEvent(
      {required this.title, required this.body, required this.currentIndex});
}

class LoadAllNoteEvent extends NoteEvent {}

class IntitNoteDB extends NoteEvent {}
