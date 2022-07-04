import "package:nyxx/nyxx.dart";
import "package:nyxx_interactions/nyxx_interactions.dart";

class HelpCommand {
  String name = "help";
  String category = "info";
  String description = "The help command for this bot.";

  execute(self) {
    print("[Command Ran] --> $name");

    final command = SlashCommandBuilder("$name", "$description", [])
      ..registerHandler((event) async {
        final embed = EmbedBuilder()
          ..title = 'Dart Bot'
          ..description = 'Suck my nuts bozo'
          ..color = '#5865F2' as DiscordColor?;

        await event.respond(MessageBuilder.embed(embed));
      });

    IInteractions.create(WebsocketInteractionBackend(self))
      ..registerSlashCommand(command)
      ..syncOnReady();
  }
}
