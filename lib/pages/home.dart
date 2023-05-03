import 'package:flutter/material.dart';
import 'package:flutter_notes/models/theme.dart';
import 'package:flutter_notes/note.dart';
import 'package:flutter_notes/pages/notes_viewer.dart';
import 'package:flutter_notes/models/notes.dart';
import 'package:flutter_notes/widgets/notes_list_view.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    var themeModel = Provider.of<ThemeModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
        actions: [
          IconButton(
            onPressed: () {
              if (themeModel.themeMode == ThemeMode.light) {
                themeModel.setThemeMode(ThemeMode.dark);
              } else {
                themeModel.setThemeMode(ThemeMode.light);
              }
            },
            tooltip: themeModel.themeMode == ThemeMode.light
                ? 'Dark Theme'
                : 'Light Theme',
            icon: themeModel.themeMode == ThemeMode.light
                ? const Icon(Icons.dark_mode)
                : const Icon(Icons.light_mode),
          ),
        ],
      ),
      body: Consumer<NotesModel>(
        builder: (context, notesModel, child) {
          return Row(
            children: [
              Visibility(
                visible: MediaQuery.of(context).size.width > 768,
                child: NavigationRail(
                  selectedIndex: currentTabIndex,
                  onDestinationSelected: (value) => setState(() {
                    currentTabIndex = value;
                  }),
                  labelType: NavigationRailLabelType.all,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.notes),
                      label: Text('All notes'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.favorite),
                      label: Text('Favorites'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: NotesListView(
                  showFavorites: currentTabIndex == 1,
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Visibility(
        visible: MediaQuery.of(context).size.width <= 768,
        child: BottomNavigationBar(
          currentIndex: currentTabIndex,
          onTap: (value) => setState(() {
            currentTabIndex = value;
          }),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.notes),
              label: 'All notes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return NoteViewer(
                  note: Note.empty(),
                );
              },
            ),
          );
        },
        tooltip: 'Add Note',
        child: const Icon(Icons.add),
      ),
    );
  }
}
