import 'package:nyxx/nyxx.dart';

import '../../config.dart';

Future<void> onMessageReceived(IMessageReceivedEvent event) async {
  final prefix = CONFIG.default_prefix;

  if (event.message.content == prefix + 'ping') {
    event.message.channel.sendMessage(
        MessageBuilder.content("Pong daddy! Use the slash commands."));
  }
}
