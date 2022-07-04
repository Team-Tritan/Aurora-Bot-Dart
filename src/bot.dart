import 'package:nyxx/nyxx.dart';
import 'config.dart';

void main() {
  final bot = NyxxFactory.createNyxxWebsocket(CONFIG.token, CONFIG.intents)
    ..registerPlugin(Logging())
    ..registerPlugin(CliIntegration())
    ..registerPlugin(IgnoreExceptions())
    ..connect();

  // Listen for message events
  bot.eventsWs.onMessageReceived.listen((event) {
    if (event.message.content == "!ping") {
      event.message.channel.sendMessage(MessageBuilder.content("Pong!"));
    }
  });
}
