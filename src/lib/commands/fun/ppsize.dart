import "package:nyxx/nyxx.dart";
import "package:nyxx_interactions/nyxx_interactions.dart";
import '../../handlers/register_interactions.dart';
import 'dart:math';

class PPSizeCommand {
  String name = "ppsize";
  String category = "fun";
  String description = "Just incase you don't know.";
  register(INyxxWebsocket client) {
    print("[Command Ran] --> $name");

    final command = SlashCommandBuilder(this.name, this.description, [])
      ..registerHandler((ISlashCommandInteractionEvent event) async {
        final int smolest_pp_size = 3;
        final int biggest_pp_size = 50;

        var pp_size = smolest_pp_size +
            Random().nextInt(biggest_pp_size - smolest_pp_size);

        String finalString = "";

        for (var i = 0; i < pp_size; i++) {
          if (i == 0) {
            finalString += "8";
          } else if (i + 1 == pp_size) {
            finalString += "D";
          } else {
            finalString += "=";
          }
        }
        await event.respond(MessageBuilder.content('$finalString'));
      });

    interactionsWS..registerSlashCommand(command);
  }
}
