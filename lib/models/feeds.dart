class Feed {
  final int? id;
  final String url;
  final String title;
  final String description;

  Feed({
    this.id,
    required this.url,
    required this.title,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'url': url,
      'title': title,
      'description': description,
    };
  }

  factory Feed.fromMap(Map<String, dynamic> map) {
    return Feed(
      id: map['id'],
      url: map['url'],
      title: map['title'],
      description: map['description'],
    );
  }
}