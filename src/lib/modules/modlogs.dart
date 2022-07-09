import 'package:nyxx/nyxx.dart';
import 'package:hive/hive.dart';
import '../../bin/bot.dart' show client;

Future<void> onDelete(event) async {
  final author = event.message.author;
  final guild_id = event.message.guild.id.toString();
  final author_tag = author.tag.toString() + author.discriminator.toString();
  final content = event.message.content.toString();

  var settings = await Hive.openBox('Settings');
  var guild_settings = settings.get(guild_id);
  var modlog_id = guild_settings['channel'];

  final logger = EmbedBuilder()
    ..addAuthor((author) {
      author.name = 'Aurora Bot';
    })
    ..title = 'Message Deleted'
    ..description = 'Content: ```$content```'
    ..color = DiscordColor.fromHexString("#5865F2")
    ..timestamp = DateTime.now()
    ..addFooter((footer) {
      footer.text = 'Author: ${author_tag}';
      footer.iconUrl = author.avatarURL();
    });

  final ch = await client.fetchChannel(Snowflake(modlog_id)) as ITextChannel;
  await ch.sendMessage(MessageBuilder.embed(logger));
}
