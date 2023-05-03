import 'package:flutter/material.dart';
import 'package:flutter_notes/models/notes.dart';
import 'package:flutter_notes/note.dart';
import 'package:provider/provider.dart';

class NoteViewer extends StatefulWidget {
  const NoteViewer({
    super.key,
    required this.note,
  });

  final Note note;

  @override
  State<NoteViewer> createState() => _NoteViewerState();
}

class _NoteViewerState extends State<NoteViewer> {
  TextEditingController noteBodyTextController = TextEditingController();
  TextEditingController noteTitleTextController = TextEditingController();

  @override
  void initState() {
    noteTitleTextController.text = widget.note.title;
    noteBodyTextController.text = widget.note.content;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note.id == null ? 'Add Note' : ''),
        actions: [
          IconButton(
            onPressed: () {
              var notesModelProvider =
                  Provider.of<NotesModel>(context, listen: false);

              if (widget.note.id == null) {
                notesModelProvider.addNote(
                  title: noteTitleTextController.text,
                  content: noteBodyTextController.text,
                );

                Navigator.of(context).pop();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Note added'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              } else {
                notesModelProvider.updateNote(
                  id: widget.note.id!,
                  title: noteTitleTextController.text,
                  content: noteBodyTextController.text,
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Changes saved'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            icon: const Icon(Icons.save),
            tooltip: 'Save',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 16.0,
        ),
        child: Column(
          children: [
            TextField(
              controller: noteTitleTextController,
              keyboardType: TextInputType.text,
              maxLines: null,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Title',
              ),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
            Expanded(
              child: TextField(
                controller: noteBodyTextController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                expands: true,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Content...',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
