class Buku {
  final int? id;
  final String title;
  final String author;
  final String category;
  final String status; // Available or Borrowed
  final String content;
  final String? coverImage;

  Buku({
    this.id,
    required this.title,
    required this.author,
    required this.category,
    required this.status,
    required this.content,
    this.coverImage,
  });

  // Convert object to Map (for SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'category': category,
      'status': status,
      'content': content,
      'coverImage': coverImage,
    };
  }

  // Convert Map to object
  factory Buku.fromMap(Map<String, dynamic> map) {
    return Buku(
      id: map['id'],
      title: map['title'],
      author: map['author'],
      category: map['category'],
      status: map['status'],
      content: map['content'],
      coverImage: map['coverImage'],
    );
  }
}
