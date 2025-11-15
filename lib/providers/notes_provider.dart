import 'package:flutter/material.dart';
import '../models/note.dart';
import '../services/database_service.dart';

class NotesProvider extends ChangeNotifier {
  List<Note> _notes = [];
  final DatabaseService _dbService = DatabaseService();

  List<Note> get notes => _notes;

  NotesProvider() {
    fetchNotes();
  }

  Future<void> fetchNotes() async {
    _notes = await _dbService.getNotes();
    notifyListeners();
  }

  Future<void> addOrUpdateNote(Note note) async {
    if (note.id == null) {
      await _dbService.insertNote(note);
    } else {
      await _dbService.updateNote(note);
    }
    await fetchNotes();
  }

  Future<void> deleteNote(int id) async {
    await _dbService.deleteNote(id);
    await fetchNotes();
  }
}