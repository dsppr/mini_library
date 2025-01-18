class Book {
  final int? id;
  final String title;
  final String author;
  final String category;
  final String status;
  final String description;

  Book({
    this.id,
    required this.title,
    required this.author,
    required this.category,
    required this.status,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'category': category,
      'status': status,
      'description': description,
    };
  }

  static Book fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'],
      title: map['title'],
      author: map['author'],
      category: map['category'],
      status: map['status'],
      description: map['description'],
    );
  }
}
