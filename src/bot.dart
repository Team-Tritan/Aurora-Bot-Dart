import 'package:nyxx/nyxx.dart';
import './config.dart';
import './lib/handlers/registerCommands.dart';
import './lib/handlers/registerEvents.dart';
import './lib/database/init.dart';

void main() {
  var client = NyxxFactory.createNyxxWebsocket(
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
  registerCommands(client);
  OpenDatabase(client);
}
