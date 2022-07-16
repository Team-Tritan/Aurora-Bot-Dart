import 'package:nyxx/nyxx.dart';
import 'package:hive/hive.dart';
import '../../bin/bot.dart' show client;

class ModlogsModule {
  final String module = 'Modlogs';

  Future<void> message_deleted(event) async {
    if (!event.message.guild) return;

    final author = event.message.author;
    final guild_id = event.message.guild?.id.toString();
    final author_tag = author.tag.toString() + author.discriminator.toString();
    final content = event.message.content.toString();

    if (guild_id == null) return;
    if (author == null) return;
    if (content == '') return;

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

    final log_channel =
        await client.fetchChannel(Snowflake(modlog_id)) as ITextChannel;

    await log_channel.sendMessage(MessageBuilder.embed(logger));
  }

  Future<void> message_updated(event) async {
    if (!event.oldMessage.guild) return;

    final guild_id = event.oldMessage?.guild?.id.toString();

    final author_tag = event.oldMessage.author.tag.toString() +
        event.oldMessage.author.discriminator.toString();
    final message_id = event.messageId.toString();

    final old_message_content = event.oldMessage.content.toString();
    final updated_message_content = event.updatedMessage.content.toString();

    var settings = await Hive.openBox('Settings');
    var guild_settings = settings.get(guild_id);
    var modlog_id = guild_settings['channel'];

    if (event.oldMessage.author.bot) return;
    if (updated_message_content == '``````') return;
    if (updated_message_content == '') return;

    final logger = EmbedBuilder()
      ..addAuthor((x) {
        x.name = author_tag;
        x.iconUrl = event.oldMessage.author.avatarURL();
      })
      ..title = 'Message Updated'
      ..addField(
          name: '**Old Message**', content: '```${old_message_content}```')
      ..addField(
          name: '**Edited Message**',
          content: '```${updated_message_content}```')
      ..addField(
          name: 'Jump to Message',
          content:
              '[Click here to jump to the message.](https://discord.com/channels/${guild_id}/${event.channel.id.toString()}/${message_id})')
      ..addFooter((footer) {
        footer.text = 'Edited by $author_tag';
        footer.iconUrl = event.oldMessage.author.avatarURL();
      })
      ..color = DiscordColor.fromHexString("#5865F2")
      ..timestamp = DateTime.now();

    final log_channel =
        await client.fetchChannel(Snowflake(modlog_id)) as ITextChannel;

    await log_channel.sendMessage(MessageBuilder.embed(logger));
  }

  Future<void> message_bulk_delete(IMessageDeleteBulkEvent event) async {
    final guild_id = event.guild?.id.toString();
    final stuff = event.getDeletedMessages();

    var settings = await Hive.openBox('Settings');
    var guild_settings = settings.get(guild_id);
    var modlog_id = guild_settings['channel'];

    final embed = EmbedBuilder()
      ..addAuthor((author) {
        author.name = 'Aurora Bot';
        author.iconUrl = client.self.avatarURL();
      })
      ..title = 'Message Bulk Deleted'
      ..color = DiscordColor.fromHexString("#5865F2");

    stuff.forEach((i) => {
          embed
            ..addField(
                name: 'ID: ${i.id.toString()}', content: '```${i.content}```')
        });

    final log_channel =
        await client.fetchChannel(Snowflake(modlog_id)) as ITextChannel;

    await log_channel.sendMessage(MessageBuilder.embed(embed));
  }

  Future<void> role_created(IRoleCreateEvent event) async {
    final guild_id = event.guild.id.toString();
    final role_name = event.role.name.toString();
    final role_id = event.role.id.toString();
    final role_createdAt = event.role.createdAt.toString();

    var settings = await Hive.openBox('Settings');
    var guild_settings = settings.get(guild_id);
    var modlog_id = guild_settings['channel'];

    final embed = EmbedBuilder()
      ..addAuthor((author) {
        author.name = 'Aurora Bot';
        author.iconUrl = client.self.avatarURL();
      })
      ..title = 'Role Created'
      ..addField(name: 'Role Name', content: role_name, inline: true)
      ..addField(name: "Role ID", content: role_id, inline: true)
      ..addField(name: 'Created At', content: role_createdAt, inline: false)
      ..color = DiscordColor.fromHexString("#5865F2")
      ..timestamp = DateTime.now();

    final log_channel =
        await client.fetchChannel(Snowflake(modlog_id)) as ITextChannel;

    await log_channel.sendMessage(MessageBuilder.embed(embed));
  }

  Future<void> role_deleted(IRoleCreateEvent event) async {
    final guild_id = event.guild.id.toString();
    final role_name = event.role.name.toString();
    final role_id = event.role.id.toString();

    var settings = await Hive.openBox('Settings');
    var guild_settings = settings.get(guild_id);
    var modlog_id = guild_settings['channel'];

    final embed = EmbedBuilder()
      ..addAuthor((author) {
        author.name = 'Aurora Bot';
        author.iconUrl = client.self.avatarURL();
      })
      ..title = 'Role Deleted'
      ..addField(name: 'Role Name', content: role_name, inline: true)
      ..addField(name: "Role ID", content: role_id, inline: true)
      ..addField(name: 'Deleted At', content: DateTime.now(), inline: false)
      ..color = DiscordColor.fromHexString("#5865F2")
      ..timestamp = DateTime.now();

    final log_channel =
        await client.fetchChannel(Snowflake(modlog_id)) as ITextChannel;

    await log_channel.sendMessage(MessageBuilder.embed(embed));
  }
}
