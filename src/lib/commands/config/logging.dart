import 'package:nyxx_interactions/nyxx_interactions.dart';
import 'package:nyxx/nyxx.dart';
import 'package:hive/hive.dart';
import '../../utils/check_for_guild.dart';
import '../../handlers/register_interactions.dart' show interactionsWS;

class LoggingCommand {
  String name = "logging";
  String category = "config";
  String description = "Set a modlogs channel for your server, or disable it.";
  bool dm_disabled = true;

  register(INyxxWebsocket client) {
    print("[Command Ran] --> $name");

    final command = SlashCommandBuilder(name, description, [
      CommandOptionBuilder(
        CommandOptionType.boolean,
        'enabled',
        'True if enabled, false if disabled.',
        required: true,
      ),
      CommandOptionBuilder(
        CommandOptionType.channel,
        'channel',
        'Channel for modlogs.',
        required: true,
      ),
    ])
      ..registerHandler((ISlashCommandInteractionEvent event) async {
        if (dm_disabled) checkForGuild(event);

        await event.acknowledge();

        final channel = (event.getArg('channel').value.toString());
        final enabled = (event.getArg('enabled').value.toString());
        final guild_id = event.interaction.guild?.id.toString();

        var settings = await Hive.openBox('Settings');

        settings.put(guild_id, {'channel': channel, 'enabled': enabled});

        final embed = EmbedBuilder()
          ..addAuthor((author) {
            author.name = 'Aurora Bot';
          })
          ..title = 'Bot Settings Updated'
          ..description = 'Server logs have been enabled for <#$channel>.'
          ..color = DiscordColor.fromHexString("#5865F2")
          ..timestamp = DateTime.now()
          ..addFooter((footer) {
            footer.text =
                'Requested by ${event.interaction.userAuthor?.username}';
            footer.iconUrl = event.interaction.userAuthor?.avatarURL();
          });

        return event.respond(MessageBuilder.embed(embed));
      });
    interactionsWS..registerSlashCommand(command);
  }
}
