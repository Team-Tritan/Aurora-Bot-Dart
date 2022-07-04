import "package:nyxx/nyxx.dart";
import "package:nyxx_interactions/nyxx_interactions.dart";
import '../../handlers/registerCommands.dart';

class HelpCommand {
  String name = "help";
  String category = "info";
  String description = "The help command for this bot.";
  execute(client) {
    print("[Command Ran] --> $name");

    final data = SlashCommandBuilder("$name", "$description", [])
      ..registerHandler((event) async {
        final embed = EmbedBuilder()
          ..title = 'Dart Bot'
          ..description = 'Suck my nuts bozo'
          ..color = DiscordColor.fromHexString("#5865F2")
          ..timestamp = DateTime.now();

        await event.respond(MessageBuilder.embed(embed));
      });

    interactionsWS..registerSlashCommand(data);
  }
}
