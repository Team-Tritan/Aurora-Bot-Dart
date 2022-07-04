import 'dart:html';

import 'package:nyxx_interactions/nyxx_interactions.dart';
import 'package:nyxx/nyxx.dart';
import '../../utils/checkForGuild.dart';
import '../../handlers/registerInteractions.dart' show interactionsWS;

class BookmarkCommand {
  String name = "afk";
  String category = "utility";
  String description = "Set yourself as AFK in the server.";
  bool dm_disabled = true;

  late final EmbedBuilder bookmarkEmbed;
  late final IMessage message;

  execute(client) {
    print("[Command Ran] --> $name");

    final data = SlashCommandBuilder('$name', '$description', [
      CommandOptionBuilder(
        CommandOptionType.string,
        'reason',
        'Reason for AFK',
        required: true,
      )
    ])
      ..registerHandler((event) async {
        if (dm_disabled) checkForGuild(event);

        await event.acknowledge();

        final reason = (event.getArg('reason').value.toString());

        var success = EmbedBuilder()
          ..addAuthor((author) {
            author.name = 'Aurora Bot';
          })
          ..title = 'AFK Enabled'
          ..description = 'You have marked yourself as AFK for $reason.'
          ..color = DiscordColor.fromHexString("#5865F2")
          ..timestamp = DateTime.now()
          ..addFooter((footer) {
            footer.text =
                'Requested by ${event.interaction.userAuthor?.username}';
            footer.iconUrl = event.interaction.userAuthor?.avatarURL();
          });

        // Do database logic!!!!!
        return event.respond(MessageBuilder.embed(success));
      });
    interactionsWS..registerSlashCommand(data);
  }
}
