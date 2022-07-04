import 'package:nyxx/nyxx.dart';
import '../../config.dart';
import '../../bot.dart' show client;

Future<void> onDmReceived(IMessageReceivedEvent event) async {
  final owner = await client.fetchUser(Snowflake(CONFIG.ownerID));
  final user = event.message.author as IUser;

  if (user.bot) return;

  final message = event.message;
  final messageCondition = message.content.isNotEmpty
      ? message.content.contains(RegExp(r'\`\`\`(.*?)\`\`\`'))
          ? message.content
          : '```${message.content}```'
      : 'No content';

  final dmEmbed = EmbedBuilder()
    ..title = 'DM recieved!'
    ..description = '''
          Author: ${user.mention}
          Message: $messageCondition
          '''
    ..color = DiscordColor.goldenrod
    ..timestamp = DateTime.now()
    ..addFooter((footer) {
      footer.text = 'Message sent by ${user.username}';
      footer.iconUrl = user.avatarURL();
    });

  if (message.attachments.isNotEmpty) {
    dmEmbed.imageUrl = message.attachments.first.url;
  }

  await owner.sendMessage(MessageBuilder.embed(dmEmbed));
}
