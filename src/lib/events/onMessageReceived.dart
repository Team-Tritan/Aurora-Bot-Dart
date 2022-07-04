import 'package:nyxx/nyxx.dart';

import '../../config.dart';

class onMessageReceived {
  String name = 'onMessageReceived';

  bind(client) {
    print("[Event Loaded] --> $name");

    client.eventsWs.onMessageReceived.listen((e) {
      final prefix = CONFIG.default_prefix;

      if (e.message.content == prefix + 'ping') {
        e.message.channel.sendMessage(
            MessageBuilder.content("Pong daddy! Use the slash commands."));
      }
    });
  }
}
