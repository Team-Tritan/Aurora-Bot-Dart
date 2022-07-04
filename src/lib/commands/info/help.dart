import "package:nyxx/nyxx.dart";
import "package:nyxx_interactions/nyxx_interactions.dart";

class HelpCommand {
  String name = "help";
  String category = "info";
  String description = "The help command for this bot.";

  execute(self) {
    final data = SlashCommandBuilder("$name", "$description", [])
      ..registerHandler((event) async {
        print(event);

        await event.respond(MessageBuilder.content("Work in progress."));
      });

    IInteractions.create(WebsocketInteractionBackend(self))
      ..registerSlashCommand(data)
      ..syncOnReady();
  }
}
