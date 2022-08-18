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

class EditNoteEvent extends NoteEvent {
  final Note note;

  const EditNoteEvent(this.note);
}

class DeleteNoteEvent extends NoteEvent {
  final String title;

  const DeleteNoteEvent(this.title);
}

class UpdateNoteEvent extends NoteEvent {
  final Note note;

  const UpdateNoteEvent(this.note);
}

class LoadAllNoteEvent extends NoteEvent{
  
}

// create note event 

