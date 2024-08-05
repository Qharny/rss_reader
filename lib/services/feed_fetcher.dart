import 'package:http/http.dart' as http;
import 'package:rss_reader/models/feed_items.dart';
import 'feed_parser.dart';

class FeedFetcher {
  final Map<String, FeedParser> _parsers = {
    'rss': RssParser(),
    'atom': AtomParser(),
  };

  Future<List<FeedItem>> fetchFeed(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final contentType = response.headers['content-type'] ?? '';
      final parser = _getParser(contentType);
      return parser.parse(response.body);
    } else {
      throw Exception('Failed to load feed');
    }
  }

  FeedParser _getParser(String contentType) {
    if (contentType.contains('atom')) {
      return _parsers['atom']!;
    } else {
      return _parsers['rss']!;
    }
  }
}