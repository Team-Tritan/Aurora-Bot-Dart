import 'package:hive/hive.dart';
import "package:nyxx/nyxx.dart";

// Checks if AFK is enabled for user, then disables when a message is sent.
void disableAFK(client, message) async {
  final box = await Hive.openBox('AFKs');
  final isAFK = box.get(message.author.id.toString());

  if (isAFK != null) {
    await box.delete(message.author.id.toString());
    print('[AFK] Disabled AFK for ${message.author.id.toString()}.');

/** 
    var baseEmbed = EmbedBuilder()
      ..title = 'AFK Disabled'
      ..color = DiscordColor.fromHexString("#5865F2");

    return message.channel.sendMessage(MessageBuilder.embed(baseEmbed));
 */
  }
}
