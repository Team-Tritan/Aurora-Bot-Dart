import "package:nyxx/nyxx.dart";
import "package:nyxx_interactions/nyxx_interactions.dart";
import '../../../config.dart';

class InviteCommand {
  var name = "invite";
  var category = "info";
  var description = "Get the invite link for this bot.";

  execute(bot) {
    final data = SlashCommandBuilder("$name", "$description", [])
      ..registerHandler((event) async {
        var ClientID = CONFIG.clientID;

        String invite =
            'https://discord.com/api/oauth2/authorize?client_id=$ClientID&permissions=8&scope=bot%20applications.commands';

        await event.respond(MessageBuilder.content('$invite'));
      });

    IInteractions.create(WebsocketInteractionBackend(bot))
      ..registerSlashCommand(data)
      ..syncOnReady();
  }
}
