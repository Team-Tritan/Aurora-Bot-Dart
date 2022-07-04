import 'dart:math';
import "package:nyxx/nyxx.dart";
import "package:nyxx_interactions/nyxx_interactions.dart";
import "../../../config.dart";

class CoinFlipCommand {
  String name = "coinflip";
  String category = "fun";
  String description = "A super awesome coin flip command.";
  execute(client) {
    print("[Command Ran] --> $name");

    final data = SlashCommandBuilder("$name", "$description", [])
      ..registerHandler((event) async {
        final result = Random().nextBool() ? "tail" : "heads";

        final embed = EmbedBuilder()
          ..title = 'Dart Bot'
          ..description = 'The result for your coinflip is **$result**.'
          ..color = '#5865F2' as DiscordColor?;

        await event.respond(MessageBuilder.embed(embed));
      });

    if (CONFIG.register_on_ready) {
      registerSlashCommand(client, data);
    }
  }

  registerSlashCommand(client, data) {
    IInteractions.create(WebsocketInteractionBackend(client))
      ..registerSlashCommand(data)
      ..syncOnReady();
  }
}
