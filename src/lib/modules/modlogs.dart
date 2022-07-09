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
    ..addAuthor((x) {
      x.name = author_tag;
      x.iconUrl = author.avatarURL();
    })
    ..title = 'Message Deleted'
    ..description = '**Content:** ```$content```'
    ..color = DiscordColor.fromHexString("#5865F2")
    ..timestamp = DateTime.now();

  final ch = await client.fetchChannel(Snowflake(modlog_id)) as ITextChannel;
  await ch.sendMessage(MessageBuilder.embed(logger));
}
