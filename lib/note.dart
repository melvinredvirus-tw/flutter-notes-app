class Note {
  Note({
    this.id,
    this.isFavorite = false,
    required this.title,
    required this.content,
  });

  factory Note.empty() {
    return Note(title: '', content: '');
  }

  String? id;
  String title;
  String content;
  bool isFavorite;
}
