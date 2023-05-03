import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    this.isFavoriteScreen = false,
  });

  final bool isFavoriteScreen;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            isFavoriteScreen
                ? 'assets/no_favorites.png'
                : 'assets/no_notes.png',
            height: 300.0,
          ),
          const SizedBox(
            height: 50.0,
          ),
          Text(
            isFavoriteScreen ? 'No favorite notes' : 'No notes to show',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 20.0,
          ),
          Text(
            isFavoriteScreen
                ? 'Add notes to favorite to see them here'
                : 'Click on the "+" icon to add a new note',
          ),
        ],
      ),
    );
  }
}
