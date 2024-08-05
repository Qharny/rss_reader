import 'package:path/path.dart';
import 'package:rss_reader/models/feeds.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class FeedStorage {
  late Database _database;

  Future<void> init() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'feeds.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE feeds(id INTEGER PRIMARY KEY, url TEXT, title TEXT, description TEXT)',
        );
      },
    );
  }

  Future<void> addFeed(Feed feed) async {
    await _database.insert('feeds', feed.toMap());
  }

  Future<List<Feed>> getFeeds() async {
    final List<Map<String, dynamic>> maps = await _database.query('feeds');
    return List.generate(maps.length, (i) {
      return Feed.fromMap(maps[i]);
    });
  }

  Future<void> deleteFeed(int id) async {
    await _database.delete(
      'feeds',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}