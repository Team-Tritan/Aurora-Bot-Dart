import "package:nyxx/nyxx.dart";
import "package:nyxx_interactions/nyxx_interactions.dart";
import '../../handlers/registerInteractions.dart';

class HelpCommand {
  String name = "help";
  String category = "info";
  String description = "The help command for this bot.";
  execute(client) {
    print("[Command Ran] --> $name");

    final data = SlashCommandBuilder("$name", "$description", [])
      ..registerHandler((event) async {
        await event.acknowledge();

        final embed = EmbedBuilder()
          ..addAuthor((author) {
            author.name = 'Dart Bot';
          })
          ..title = 'Help'
          ..description = 'Suck my nuts bozo, coming soon.'
          ..color = DiscordColor.fromHexString("#5865F2")
          ..timestamp = DateTime.now()
          ..addFooter((footer) {
            footer.text =
                'Requested by ${event.interaction.userAuthor?.username}';
            footer.iconUrl = event.interaction.userAuthor?.avatarURL();
          });

        await event.respond(MessageBuilder.embed(embed));
      });

    interactionsWS..registerSlashCommand(data);
  }
}
