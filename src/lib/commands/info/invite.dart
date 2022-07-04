import "package:nyxx/nyxx.dart";
import "package:nyxx_interactions/nyxx_interactions.dart";
import '../../../config.dart';
import '../../handlers/registerInteractions.dart';

class InviteCommand {
  String name = "invite";
  String category = "info";
  String description = "Get the invite link for this bot.";
  execute(client) {
    print("[Command Ran] --> $name");

    final data = SlashCommandBuilder("$name", "$description", [])
      ..registerHandler((event) async {
        await event.acknowledge();

        var ClientID = CONFIG.clientID;

        String invite =
            'https://discord.com/api/oauth2/authorize?client_id=$ClientID&permissions=8&scope=bot%20applications.commands';

        await event.respond(MessageBuilder.content('$invite'));
      });

    interactionsWS..registerSlashCommand(data);
  }
}
