import 'dart:io';
import 'package:rss_reader/models/feeds.dart';

import '../services/feed_storage.dart';
import '../services/feed_fetcher.dart';

class CliManager {
  final FeedStorage _storage = FeedStorage();
  final FeedFetcher _fetcher = FeedFetcher();

  Future<void> run() async {
    await _storage.init();

    while (true) {
      print('\nRSS Feed Reader');
      print('1. Add Feed');
      print('2. List Feeds');
      print('3. View Feed Items');
      print('4. Delete Feed');
      print('5. Exit');
      print('Enter your choice:');

      final choice = stdin.readLineSync();

      switch (choice) {
        case '1':
          await _addFeed();
          break;
        case '2':
          await _listFeeds();
          break;
        case '3':
          await _viewFeedItems();
          break;
        case '4':
          await _deleteFeed();
          break;
        case '5':
          print('Goodbye!');
          exit(0);
        default:
          print('Invalid choice. Please try again.');
      }
    }
  }

  Future<void> _addFeed() async {
    print('Enter feed URL:');
    final url = stdin.readLineSync() ?? '';
    print('Enter feed title:');
    final title = stdin.readLineSync() ?? '';
    print('Enter feed description:');
    final description = stdin.readLineSync() ?? '';

    final feed = Feed(url: url, title: title, description: description);
    await _storage.addFeed(feed);
    print('Feed added successfully!');
  }

  Future<void> _listFeeds() async {
    final feeds = await _storage.getFeeds();
    if (feeds.isEmpty) {
      print('No feeds found.');
    } else {
      for (var feed in feeds) {
        print('${feed.id}: ${feed.title} (${feed.url})');
      }
    }
  }

  Future<void> _viewFeedItems() async {
    await _listFeeds();
    print('Enter feed ID to view items:');
    final id = int.tryParse(stdin.readLineSync() ?? '');
    if (id == null) {
      print('Invalid ID.');
      return;
    }

    final feeds = await _storage.getFeeds();
    final feed = feeds.firstWhere((f) => f.id == id, orElse: () => Feed(url: '', title: '', description: ''));
    if (feed.url.isEmpty) {
      print('Feed not found.');
      return;
    }

    try {
      final items = await _fetcher.fetchFeed(feed.url);
      for (var item in items) {
        print(item);
        print('-------------------');
      }
    } catch (e) {
      print('Error fetching feed: $e');
    }
  }

  Future<void> _deleteFeed() async {
    await _listFeeds();
    print('Enter feed ID to delete:');
    final id = int.tryParse(stdin.readLineSync() ?? '');
    if (id == null) {
      print('Invalid ID.');
      return;
    }

    await _storage.deleteFeed(id);
    print('Feed deleted successfully!');
  }
}