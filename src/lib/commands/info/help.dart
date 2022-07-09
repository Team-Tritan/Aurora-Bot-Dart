import "package:nyxx/nyxx.dart";
import "package:nyxx_interactions/nyxx_interactions.dart";
import '../../handlers/register_interactions.dart';
import '../../utils/check_for_guild.dart';

class HelpCommand {
  String name = "help";
  String category = "info";
  String description = "The help command for this bot.";
  bool dm_disabled = false;

  register(INyxxWebsocket client) {
    late final EmbedBuilder baseEmbed;

    print("[Command Ran] --> $name");

    final command = SlashCommandBuilder(name, description, [])
      ..registerHandler((ISlashCommandInteractionEvent event) async {
        if (dm_disabled) checkForGuild(event);

        await event.acknowledge();

        baseEmbed = EmbedBuilder()
          ..addAuthor((author) {
            author.name = 'Aurora Bot';
            author.iconUrl = client.self.avatarURL();
          })
          ..title = 'Command Help'
          ..color = DiscordColor.fromHexString("#5865F2")
          ..timestamp = DateTime.now()
          ..addField(name: 'Info Commands', content: 'help, invite, ping')
          ..addField(name: 'Fun Commands', content: 'coinflip')
          ..addField(name: 'Utility Commands', content: 'bookmark, afk')
          ..addField(name: 'Bot Settings', content: 'logging')
          ..addFooter((footer) {
            footer.text =
                'Requested by ${event.interaction.userAuthor?.username}';
            footer.iconUrl = event.interaction.userAuthor?.avatarURL();
          });

        await event.respond(MessageBuilder.embed(baseEmbed));
      });

    interactionsWS..registerSlashCommand(command);
  }
}
