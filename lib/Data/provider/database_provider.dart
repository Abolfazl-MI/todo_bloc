import 'dart:async';
import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:todo_bloc/Data/models/note_modle.dart';
import 'package:todo_bloc/core/crud_enum.dart';
import 'package:todo_bloc/core/rawdata_modle.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DataBaseProvider {
  static String _boxName = 'NoteBox';
  Box<Note>? _noteBox;
  Future<bool> _initAdaptors() async {
    log("******REGESTRING_ADAPTER*******");

    try {
      Hive.registerAdapter(NoteAdapter());
      return true;
    } catch (e) {
      return false;
    }
  }
  // stream of changes from db

  Future<bool> _initNoteBox() async {
    try {
      log("******INITING_NOTE_BOX*******");
      if (await Hive.boxExists(_boxName)) {
        _noteBox = Hive.box(_boxName);
        return true;
      } else {
        _noteBox = await Hive.openBox(_boxName);
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> initDb() async {
    try {
      log("******INitingDatabase*******");

      var adapter = await _initAdaptors();
      var noteBox = await _initNoteBox();
      if (adapter && noteBox) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<RawData> createNote({required Note note}) async {
    try {
      log('********creating_Note:{title :${note.title}, body:${note.body},********');
      int noteCreated = await _noteBox!.add(note);
      var createdNote = _noteBox!.getAt(noteCreated);
      return RawData(status: CrudStatus.success, data: createdNote);
    } catch (e) {
      return RawData(status: CrudStatus.failure, data: e.toString());
    }
  }

  Future<RawData> updateNote({
    required String currentTitle,
    String? newTitle,
    String? newBody,
  }) async {
    try {
      log("******updating note*******");
      Note currentNote = _noteBox!.values
          .firstWhere((element) => element.title == currentTitle);
      if (newTitle != null) {
        currentNote.copyWith(title: newTitle);
        currentNote.save();
        return RawData(status: CrudStatus.success);
      }
      if (newBody != null) {
        currentNote.copyWith(body: newBody);
        currentNote.save();
        return RawData(status: CrudStatus.success, data: currentNote);
      } else {
        return RawData(
            status: CrudStatus.failure, data: 'No data Provided for Update');
      }
    } catch (e) {
      return RawData(status: CrudStatus.failure, data: e.toString());
    }
  }

  Future<RawData> readAllNotes() async {
    try {
      log("******READRING ALL NOTES*******");

      List<Note> notes = _noteBox!.values.toList();
      return RawData(status: CrudStatus.success, data: notes);
    } catch (e) {
      return RawData(status: CrudStatus.failure, data: e.toString());
    }
  }

  Future<RawData> deleteSingleNote({required String title}) async {
    try {
      log("******DELETEING NOTE*******");

      Note note =
          _noteBox!.values.firstWhere((element) => element.title == title);
      note.delete();
      return RawData(status: CrudStatus.success, data: note);
    } catch (e) {
      return RawData(status: CrudStatus.failure, data: e.toString());
    }
  }

  
}
