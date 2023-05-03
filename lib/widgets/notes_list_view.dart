import 'package:flutter/material.dart';
import 'package:flutter_notes/note.dart';
import 'package:flutter_notes/pages/notes_viewer.dart';
import 'package:flutter_notes/models/notes.dart';
import 'package:flutter_notes/widgets/empty_state.dart';
import 'package:provider/provider.dart';

class NotesListView extends StatelessWidget {
  const NotesListView({
    super.key,
    this.showFavorites = false,
  });

  final bool showFavorites;

  @override
  Widget build(BuildContext context) {
    var notesModel = Provider.of<NotesModel>(context);
    var notes = showFavorites ? notesModel.favoriteNotes : notesModel.notes;

    if (notes.isEmpty) {
      return EmptyState(
        isFavoriteScreen: showFavorites,
      );
    }

    return ListView(
      children: getListItems(context, notes),
    );
  }

  List<Widget> getListItems(BuildContext context, List<Note> notes) {
    var notesModel = Provider.of<NotesModel>(context);
    var listItems = <Widget>[];

    for (var note in notes) {
      var listItem = ListTile(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return NoteViewer(
                  note: note,
                );
              },
            ),
          );
        },
        title: Text(note.title.isNotEmpty ? note.title : 'No Title'),
        subtitle: Text(
          note.content.isNotEmpty ? note.content : 'No content',
          style: const TextStyle(
            overflow: TextOverflow.ellipsis,
          ),
        ),
        leading: const Icon(Icons.note),
        trailing: PopupMenuButton(
          onSelected: (value) {
            if (value == 'delete') {
              notesModel.removeNote(
                id: note.id!,
              );

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Note deleted'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            } else if (value == 'favorite') {
              var isInitiallyFavorite = note.isFavorite;

              notesModel.setFavorite(
                id: note.id!,
                isFavorite: !isInitiallyFavorite,
              );

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(isInitiallyFavorite
                      ? 'Note removed from favorites'
                      : 'Note added to favorites'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
          itemBuilder: (context) {
            return [
              const PopupMenuItem(
                value: 'delete',
                child: Text('Delete'),
              ),
              PopupMenuItem(
                value: 'favorite',
                child: Text(!note.isFavorite
                    ? 'Add to favorites'
                    : 'Remove from favorites'),
              ),
            ];
          },
        ),
      );

      listItems.add(listItem);
    }

    return listItems;
  }
}
