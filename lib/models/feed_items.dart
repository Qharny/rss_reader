class FeedItem {
  final String title;
  final String link;
  final String description;
  final DateTime pubDate;

  FeedItem({
    required this.title,
    required this.link,
    required this.description,
    required this.pubDate,
  });

  @override
  String toString() {
    return 'Title: $title\nLink: $link\nDescription: $description\nPublication Date: ${pubDate.toIso8601String()}\n';
  }
}