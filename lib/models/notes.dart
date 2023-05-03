import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_notes/note.dart';
import 'package:uuid/uuid.dart';

class NotesModel extends ChangeNotifier {
  final List<Note> _notes = [];

  UnmodifiableListView<Note> get notes => UnmodifiableListView(_notes);
  UnmodifiableListView<Note> get favoriteNotes =>
      UnmodifiableListView(_notes.where((element) => element.isFavorite));

  String addNote({
    required String title,
    required String content,
  }) {
    var id = const Uuid().v4();

    _notes.add(Note(
      id: id,
      title: title,
      content: content,
    ));

    notifyListeners();
    return id;
  }

  void updateNote({
    required String id,
    required String title,
    required String content,
  }) {
    var targetNoteIndex = _notes.indexWhere((element) => element.id == id);

    _notes[targetNoteIndex].title = title;
    _notes[targetNoteIndex].content = content;

    notifyListeners();
  }

  void removeNote({required String id}) {
    _notes.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void setFavorite({required String id, required bool isFavorite}) {
    var targetNoteIndex = _notes.indexWhere((element) => element.id == id);
    _notes[targetNoteIndex].isFavorite = isFavorite;

    notifyListeners();
  }
}
