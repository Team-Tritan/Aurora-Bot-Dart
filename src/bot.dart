import 'package:nyxx/nyxx.dart';
import './config.dart';
import 'lib/handlers/registerInteractions.dart';
import './lib/handlers/registerEvents.dart';
import './lib/utils/database.dart';

late INyxxWebsocket client;

void main() {
  client = NyxxFactory.createNyxxWebsocket(
    CONFIG.token,
    CONFIG.intents,
    options: ClientOptions(
      initialPresence: PresenceBuilder.of(
        activity: ActivityBuilder.watching("ur cock"),
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
