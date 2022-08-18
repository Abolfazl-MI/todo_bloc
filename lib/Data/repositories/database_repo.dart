import 'package:dartz/dartz.dart';
import 'package:todo_bloc/Data/models/note_modle.dart';
import 'package:todo_bloc/Data/provider/database_provider.dart';
import 'package:todo_bloc/core/crud_enum.dart';
import 'package:todo_bloc/core/failure_modle.dart';
import 'package:todo_bloc/core/rawdata_modle.dart';

class NoteRepository {
  final DataBaseProvider _databaseProvider = DataBaseProvider();

  // database repository constructor
  NoteRepository() {
    _databaseProvider.initDb();
  }

  // gets all notes from database
  Future<Either<NoteError, List<Note>>> getAllNotes() async {
   RawData rawData= await _databaseProvider.readAllNotes();
   if (rawData.status == CrudStatus.success) {
      return Right(rawData.data);
    } else {
      return Left(NoteError(rawData.data));
    }
  }

  //delete note from database
  Future<Either<NoteError, Note>> deletNoteFromDb(String title) async {
    RawData rawData = await _databaseProvider.deleteSingleNote(title: title);
    if (rawData.status == CrudStatus.success) {
      return Right(rawData.data);
    } else {
      return Left(NoteError(rawData.data));
    }
  }

  // create note in database
  Future<Either<NoteError, Note>> createNote(Note note) async {
    RawData rawData = await _databaseProvider.createNote(note: note);
    if (rawData.status == CrudStatus.success) {
      return Right(rawData.data);
    } else {
      return Left(NoteError(rawData.data));
    }
  }
}
