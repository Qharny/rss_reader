# RSS (Really Simple Syndication) Feed Reader 

A command-line RSS feed reader application built with Dart. This application allows users to manage RSS and Atom feed subscriptions, view feed items, and store subscriptions persistently.

## Features

- Subscribe to RSS and Atom feeds
- List all subscribed feeds
- View items from a specific feed
- Delete feed subscriptions
- Persistent storage of feed subscriptions using SQLite
- Support for both RSS and Atom feed formats

## Prerequisites

- Dart SDK (version 2.12.0 or higher)
- SQLite

## Installation

1. Clone this repository:
git clone https://github.com/Qharny/rss_reader
cd rss_reader

1. Install dependencies:
dart pub get

## Usage

To run the application:
dart run bin/rss_reader.dart

Follow the on-screen prompts to interact with the RSS Feed Reader:

1. Add Feed: Subscribe to a new RSS or Atom feed
2. List Feeds: View all subscribed feeds
3. View Feed Items: Fetch and display items from a specific feed
4. Delete Feed: Unsubscribe from a feed
5. Exit: Close the application

## Project Structure
rss_reader/
│
├── bin/
│   └── rss_reader.dart
│
├── lib/
│   ├── models/
│   │   ├── feed.dart
│   │   └── feed_item.dart
│   │
│   ├── services/
│   │   ├── feed_parser.dart
│   │   ├── feed_storage.dart
│   │   └── feed_fetcher.dart
│   │
│   └── cli/
│       └── cli_manager.dart
│
├── pubspec.yaml
└── README.md

## Dependencies

- http: ^0.13.5
- xml: ^6.2.2
- path: ^1.8.0
- sqflite: ^2.2.6
- sqflite_common_ffi: ^2.2.5

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is open source and available under the [MIT License](LICENSE).