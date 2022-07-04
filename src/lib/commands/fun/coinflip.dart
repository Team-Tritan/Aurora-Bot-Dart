import 'dart:math';
import "package:nyxx/nyxx.dart";
import "package:nyxx_interactions/nyxx_interactions.dart";
import '../../handlers/registerCommands.dart';

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
          ..color = DiscordColor.fromHexString("#5865F2")
          ..timestamp = DateTime.now();

        await event.respond(MessageBuilder.embed(embed));
      });

    interactionsWS..registerSlashCommand(data);
  }
}
