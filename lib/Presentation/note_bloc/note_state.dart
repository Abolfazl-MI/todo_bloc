part of 'note_bloc.dart';

abstract class NoteState extends Equatable {
  const NoteState();

  @override
  List<Object> get props => [];
}



class NoteLoadingState extends NoteState {}

class NoteLoadedState extends NoteState {
  final List<Note> loadedNotes;

  NoteLoadedState(this.loadedNotes);

}

class NoteErrorState extends NoteState {
  final String error;

  const NoteErrorState(this.error);
  @override
  // TODO: implement props
  List<Object> get props => [error];
}
