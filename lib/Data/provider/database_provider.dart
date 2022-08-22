import 'dart:async';
import 'dart:developer';
import 'package:hive/hive.dart';
import 'package:todo_bloc/Data/models/note_modle.dart';
import 'package:todo_bloc/core/crud_enum.dart';
import 'package:todo_bloc/core/rawdata_modle.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DataBaseProvider {
  static final String _boxName = 'NoteBox';
  Box<Note>? _noteBox;

  Future<bool> initDb() async {
    try {
      log("******INitingDatabase*******", name: 'DB_PROVIDER');

      Hive.registerAdapter(NoteAdapter());
      _noteBox = await Hive.openBox(_boxName);
      if (_noteBox != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Stream<BoxEvent> noteStream() {
    return Hive.box(_boxName).watch();
  }

  Future<RawData> createNote({required Note note}) async {
    try {
      log('********creating_Note:{title :${note.title}, body:${note.body},********',
          name: 'DB_PROVIDER');

      if (_noteBox == null) {
        _noteBox = await Hive.openBox(_boxName);
      }
      int noteCreated = await _noteBox!.add(note);
      var createdNote = _noteBox!.getAt(noteCreated);
      print(
        '${createdNote?.title},${createdNote?.body}',
      );
      return RawData(status: CrudStatus.success, data: createdNote);
    } catch (e) {
      return RawData(status: CrudStatus.failure, data: e.toString());
    }
  }

  Future<RawData> updateNote({
    required int index,
    required String newTitle,
    required String newBody,
  }) async {
    try {
      // if (!await Hive.boxExists(_boxName)) {
      _noteBox = await Hive.openBox(_boxName);
      Note? cNote = _noteBox!.getAt(index);
      cNote = Note(title: newTitle, body: newBody);
      _noteBox!.putAt(index, cNote);
      return RawData(status: CrudStatus.success, data: cNote);
      // log("******updating note*******", name: 'DB_PROVIDER');
      // Note currentNote = _noteBox!.values
      //     .firstWhere((element) => element.title == currentTitle);
      // print(currentNote.toString());

      // Note newNote = currentNote.copyWith(title: newTitle, body: newBody);
      // newNote.save();
      // print(newNote.toString());
      // return RawData(status: CrudStatus.success, data: newNote);
      //     .where((element) => element.title == currentTitle);
      // currentNote.copyWith(
      //   title: newTitle,
      //   body: newBody,
      // );
      // currentNote.save();
      // return RawData(status: CrudStatus.success, data: currentNote);
      // if (newTitle != null) {
      //   currentNote.copyWith(title: newTitle);
      //   currentNote.save();
      //   return RawData(status: CrudStatus.success, data: currentNote);
      // }
      // if (newBody != null) {
      //   currentNote.copyWith(body: newBody);
      //   currentNote.save();
      //   return RawData(status: CrudStatus.success, data: currentNote);
      // } else {
      //   return RawData(
      //       status: CrudStatus.failure, data: 'No data Provided for Update');
      // }
    } catch (e) {
      return RawData(status: CrudStatus.failure, data: e.toString());
    }
  }

  Future<RawData> readAllNotes() async {
    try {
      if (!await Hive.boxExists(_boxName)) {
        _noteBox = await Hive.openBox(_boxName);
      }
      log("******READRING ALL NOTES*******", name: 'DB_PROVIDER');

      List<Note> notes = _noteBox!.values.toList();
      return RawData(status: CrudStatus.success, data: notes);
    } catch (e) {
      throw e;
      // return RawData(status: CrudStatus.failure, data: e.toString());
    }
  }

  Future<RawData> deleteSingleNote({required String title}) async {
    try {
      log("******DELETEING NOTE*******", name: 'DB_PROVIDER');

      Note note =
          _noteBox!.values.firstWhere((element) => element.title == title);
      note.delete();
      return RawData(status: CrudStatus.success, data: note);
    } catch (e) {
      return RawData(status: CrudStatus.failure, data: e.toString());
    }
  }
}
