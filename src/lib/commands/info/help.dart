import "package:nyxx/nyxx.dart";
import "package:nyxx_interactions/nyxx_interactions.dart";

class HelpCommand {
  var name = "help";
  var category = "info";
  var description = "The help command for this bot.";

  execute(bot) {
    final data = SlashCommandBuilder("$name", "$description", [])
      ..registerHandler((event) async {
        await event.respond(MessageBuilder.content("Work in progress."));
      });

    IInteractions.create(WebsocketInteractionBackend(bot))
      ..registerSlashCommand(data)
      ..syncOnReady();
  }
}
