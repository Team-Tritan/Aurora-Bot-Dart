import 'package:nyxx/nyxx.dart';
import 'lib/registerEvents.dart';
import 'config.dart';
import 'lib/registerCommands.dart';

void main() {
  var bot = NyxxFactory.createNyxxWebsocket(
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

  registerEvents(bot);
  registerCommands(bot);
}
