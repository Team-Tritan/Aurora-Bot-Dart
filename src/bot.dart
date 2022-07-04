import 'package:nyxx/nyxx.dart';
import './config.dart';
import './lib/handlers/registerCommands.dart';
import './lib/handlers/registerEvents.dart';

main() {
  var self = NyxxFactory.createNyxxWebsocket(
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

  registerEvents(self);
  registerCommands(self);
}
