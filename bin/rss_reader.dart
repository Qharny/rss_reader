
import 'package:rss_reader/cli/cli_manager.dart';

void main(List<String> arguments) async {
  final cliManager = CliManager();
  await cliManager.run();
}