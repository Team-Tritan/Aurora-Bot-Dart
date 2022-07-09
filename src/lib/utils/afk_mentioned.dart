import 'package:hive/hive.dart';
import "package:nyxx/nyxx.dart";

void afkMentioned(INyxxWebsocket client, message) async {
  final mentioned = message.mentions == null || message.mentions.isEmpty
      ? null
      : message.mentions.first;

  if (mentioned != null) {
    final box = await Hive.openBox('AFKs');
    final isAFK = box.get(mentioned.id.toString());

    if (isAFK != null) {
      var baseEmbed = EmbedBuilder()
        ..addAuthor((author) {
          author.name = 'Aurora Bot';
        })
        ..title = 'User is AFK'
        ..description =
            'The user you mentioned is currently AFK, the reason listed is listed below. ```' +
                isAFK['reason'] +
                '```'
        ..color = DiscordColor.fromHexString("#5865F2")
        ..timestamp = DateTime.now()
        ..addFooter((footer) {
          footer.text = 'Pinged by ${message.author.username}';
          footer.iconUrl = message.author.avatarURL();
        });

      return message.channel.sendMessage(MessageBuilder.embed(baseEmbed));
    }
  }
}
