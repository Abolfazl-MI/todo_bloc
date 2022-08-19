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
  final String? title;
  final String? body;
  final String currentTitle;
  const UpdateNoteEvent({this.title, this.body, required this.currentTitle});
}

class LoadAllNoteEvent extends NoteEvent {}

class IntitNoteDB extends NoteEvent{
  
}

// create note event 

