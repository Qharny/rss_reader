import 'package:rss_reader/models/feed_items.dart';
import 'package:xml/xml.dart';

abstract class FeedParser {
  List<FeedItem> parse(String xmlContent);
}

class RssParser implements FeedParser {
  @override
  List<FeedItem> parse(String xmlContent) {
    final document = XmlDocument.parse(xmlContent);
    final items = document.findAllElements('item');
    
    return items.map((item) {
      return FeedItem(
        title: item.findElements('title').first.innerText,
        link: item.findElements('link').first.innerText,
        description: item.findElements('description').first.innerText,
        pubDate: DateTime.parse(item.findElements('pubDate').first.innerText),
      );
    }).toList();
  }
}

class AtomParser implements FeedParser {
  @override
  List<FeedItem> parse(String xmlContent) {
    final document = XmlDocument.parse(xmlContent);
    final entries = document.findAllElements('entry');
    
    return entries.map((entry) {
      return FeedItem(
        title: entry.findElements('title').first.text,
        link: entry.findElements('link').first.getAttribute('href') ?? '',
        description: entry.findElements('summary').first.text,
        pubDate: DateTime.parse(entry.findElements('updated').first.text),
      );
    }).toList();
  }
}