import 'package:nyxx/nyxx.dart';

import '../../config.dart';

class onMessageReceived {
  bind(bot) {
    print("[Event Loaded] --> onMessageReceived");

    bot.eventsWs.onMessageReceived.listen((event) {
      final prefix = CONFIG.default_prefix;

      if (event.message.content == prefix + 'ping') {
        event.message.channel
            .sendMessage(MessageBuilder.content("Pong daddy!"));
      }
    });
  }
}
