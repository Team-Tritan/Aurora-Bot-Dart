import "package:nyxx/nyxx.dart";
import "package:nyxx_interactions/nyxx_interactions.dart";

class PingCommand {
  String name = "ping";
  String category = "info";
  String description = "Get the websocket ping.";

  execute(client) {
    print("[Command Ran] --> $name");

    final data = SlashCommandBuilder("$name", "$description", [])
      ..registerHandler((event) async {
        var user = event.interaction.userAuthor?.username;
        final embed = EmbedBuilder()
          ..title = 'Dart Bot'
          ..description = 'Suck my nuts bozo'
          ..color = '#5865F2' as DiscordColor?;

        await event.respond(MessageBuilder.embed(embed));
      });

    IInteractions.create(WebsocketInteractionBackend(client))
      ..registerSlashCommand(data)
      ..syncOnReady();
  }
}
