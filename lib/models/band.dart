class Band {
  final id;
  final name;
  final votes;

  const Band({required this.id, required this.name, required this.votes});

  factory Band.fromMap(Map<String, dynamic> obj) {
    return Band(id: obj['id'], name: obj['name'], votes: obj['votes']);
  }
}
