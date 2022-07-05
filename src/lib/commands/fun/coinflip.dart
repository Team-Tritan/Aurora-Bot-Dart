import 'dart:math';
import "package:nyxx/nyxx.dart";
import "package:nyxx_interactions/nyxx_interactions.dart";
import '../../handlers/registerInteractions.dart';

class CoinFlipCommand {
  String name = "coinflip";
  String category = "fun";
  String description = "A super awesome coin flip command.";

  late final EmbedBuilder baseEmbed;

  execute(client) {
    print("[Command Ran] --> $name");

    final data = SlashCommandBuilder("$name", "$description", [])
      ..registerHandler((event) async {
        await event.acknowledge();

        final result = Random().nextBool() ? "tail" : "heads";

        baseEmbed = EmbedBuilder()
          ..addAuthor((author) {
            author.name = 'Aurora Bot';
          })
          ..title = 'Coin Flip'
          ..description = 'The result is **$result**.'
          ..color = DiscordColor.fromHexString("#5865F2")
          ..timestamp = DateTime.now()
          ..addFooter((footer) {
            footer.text =
                'Requested by ${event.interaction.userAuthor?.username}';
            footer.iconUrl = event.interaction.userAuthor?.avatarURL();
          });

        await event.respond(MessageBuilder.embed(baseEmbed));
      });

    interactionsWS..registerSlashCommand(data);
  }
}
