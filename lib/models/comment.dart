class Comment {
  String id;
  String author;
  String content;
  DateTime createdAt;

  Comment({
    required this.id,
    required this.author,
    required this.content,
    required this.createdAt,
  });

  String get formattedDate {
    return '${createdAt.day}-${createdAt.month}-${createdAt.year} ${createdAt.hour}:${createdAt.minute}';
  }
}
