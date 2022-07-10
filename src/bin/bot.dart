import 'package:nyxx/nyxx.dart';
import 'package:hive/hive.dart';
import '../config.dart';
import '../lib/handlers/register_interactions.dart';
import '../lib/handlers/register_events.dart';
import '../lib/modules/reminders.dart';

late INyxxWebsocket client;

void main() async {
  client = NyxxFactory.createNyxxWebsocket(
    CONFIG.token,
    CONFIG.intents,
  )
    ..registerPlugin(Logging())
    ..registerPlugin(CliIntegration())
    ..registerPlugin(IgnoreExceptions())
    ..connect();

  registerEvents(client);
  registerModules(client);
  registerInteractions(client);

  Hive.init('../../database');
}
