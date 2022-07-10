import 'dart:math';
import "package:nyxx/nyxx.dart";
import "package:nyxx_interactions/nyxx_interactions.dart";
import '../../handlers/register_interactions.dart';

class CoinFlipCommand {
  String name = "coinflip";
  String category = "fun";
  String description = "A super awesome coin flip command.";

  register(INyxxWebsocket client) {
    late final EmbedBuilder baseEmbed;

    print("[Command Ran] --> $name");

    final command = SlashCommandBuilder(this.name, this.description, [])
      ..registerHandler((ISlashCommandInteractionEvent event) async {
        await event.acknowledge();

        final result = Random().nextBool() ? "tail" : "heads";

        baseEmbed = EmbedBuilder()
          ..addAuthor((author) {
            author.name = 'Aurora Bot';
            author.iconUrl = client.self.avatarURL();
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

    interactionsWS..registerSlashCommand(command);
  }
}
