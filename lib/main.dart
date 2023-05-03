import 'package:flutter/material.dart';
import 'package:flutter_notes/models/theme.dart';
import 'package:flutter_notes/pages/home.dart';
import 'package:flutter_notes/models/notes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NotesModel>(
          create: (context) => NotesModel(),
        ),
        ChangeNotifierProvider<ThemeModel>(
          create: (context) => ThemeModel(),
        ),
      ],
      child: Consumer<ThemeModel>(
        builder: (context, themeModel, child) {
          return MaterialApp(
            themeMode: themeModel.themeMode,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            darkTheme: ThemeData.dark().copyWith(
              colorScheme: const ColorScheme.dark().copyWith(
                primary: Colors.blue,
                secondary: Colors.blue,
              ),
            ),
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
