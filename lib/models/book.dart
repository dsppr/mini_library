class Book {
  final int id;
  final String title;
  final String author;
  final String coverImage;

  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.coverImage,
  });

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'],
      title: map['title'],
      author: map['author'],
      coverImage: map['coverImage'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'coverImage': coverImage,
    };
  }
}
