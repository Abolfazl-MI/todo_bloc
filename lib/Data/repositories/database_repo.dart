import 'package:dartz/dartz.dart';
import 'package:todo_bloc/Data/models/note_modle.dart';
import 'package:todo_bloc/Data/provider/database_provider.dart';
import 'package:todo_bloc/core/crud_enum.dart';
import 'package:todo_bloc/core/failure_modle.dart';
import 'package:todo_bloc/core/rawdata_modle.dart';

class NoteRepository {
  final DataBaseProvider _databaseProvider = DataBaseProvider();

  // gets all notes from database
  Future<Either<NoteError, List<Note>>> getAllNotes() async {
    RawData rawData = await _databaseProvider.readAllNotes();
    if (rawData.status == CrudStatus.success) {
      List<Note> notes = rawData.data;
      return Right(notes);
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

  // update note in database
  Future<Either<NoteError, Note>> updateNote(
      {String? title, String? body, required String currentTitle}) async {
    if (title != null) {
      RawData result = await _databaseProvider.updateNote(
          currentTitle: currentTitle, newTitle: title);
      if (result.status == CrudStatus.success) {
        return Right(result.data);
      } else if (result.status == CrudStatus.failure) {
        return Left(NoteError(result.data));
      }
    }
    if (body != null) {
      RawData result = await _databaseProvider.updateNote(
          currentTitle: currentTitle, newBody: body);
      if (result.status == CrudStatus.success) {
        return Right(result.data);
      } else if (result.status == CrudStatus.failure) {
        return Left(NoteError(result.data));
      } else {
        return Left(NoteError('UNEXPECTED ERRO'));
      }
    }

    if (title == null && body == null) {
      return Left(NoteError('title and body was null'));
    }

    return Left(NoteError('sth goes wrong'));
  }

  //init databse and loads all notes exists inside
  Future<Either<NoteError, List<Note>>> initDataBase() async {
    bool initResult = await _databaseProvider.initDb();
    if (initResult) {
      RawData rawData = await _databaseProvider.readAllNotes();
      if (rawData.status == CrudStatus.success) {
        return Right(rawData.data);
      } else {
        return Left(NoteError('cant load Notes from db'));
      }
    } else {
      return left(NoteError('cant init DataBase'));
    }
  }
}
