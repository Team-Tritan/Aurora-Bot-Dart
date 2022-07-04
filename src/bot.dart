import 'package:nyxx/nyxx.dart';
import './lib/eventHandler.dart';
import 'config.dart';

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

  handleEvents(bot);
}
