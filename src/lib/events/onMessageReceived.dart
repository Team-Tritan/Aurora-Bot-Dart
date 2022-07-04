import 'package:nyxx/nyxx.dart';

import '../../config.dart';

class onMessageReceived {
  String name = 'onMessageReceived';

  bind(self) {
    print("[Event Loaded] --> $name");

    self.eventsWs.onMessageReceived.listen((e) {
      final prefix = CONFIG.default_prefix;

      if (e.message.content == prefix + 'ping') {
        e.message.channel.sendMessage(
            MessageBuilder.content("Pong daddy! Use the slash commands."));
      }
    });
  }
}
