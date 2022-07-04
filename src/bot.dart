import 'package:nyxx/nyxx.dart';
import './config.dart';
import 'lib/handlers/registerInteractions.dart';
import './lib/handlers/registerEvents.dart';
import './lib/utils/database.dart';
import "dart:math";

late INyxxWebsocket client;

void main() {
  final _random = new Random();
  final status = CONFIG.activities[_random.nextInt(CONFIG.activities.length)];

  client = NyxxFactory.createNyxxWebsocket(
    CONFIG.token,
    CONFIG.intents,
    options: ClientOptions(
      initialPresence: PresenceBuilder.of(
        activity: ActivityBuilder.watching(status),
        status: UserStatus.dnd,
      ),
      dispatchRawShardEvent: true,
    ),
  )
    ..registerPlugin(Logging())
    ..registerPlugin(CliIntegration())
    ..registerPlugin(IgnoreExceptions())
    ..connect();

  registerEvents(client);
  registerInteractions(client);
  initDatabase(client);
}
