class Collection {
  final int id;
  final String name;
  final List<int> bookIds;

  const Collection({
    required this.id,
    required this.name,
    required this.bookIds,
  });

  factory Collection.fromMap(Map<String, dynamic> map) {
    return Collection(
      id: map['id'],
      name: map['name'],
      bookIds: (map['bookIds'] as String).split(',').map(int.parse).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'bookIds': bookIds.join(','),
    };
  }
}
