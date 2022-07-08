import "package:nyxx/nyxx.dart";
import "package:nyxx_interactions/nyxx_interactions.dart";
import '../../handlers/register_interactions.dart';
import '../../utils/check_for_guild.dart';

class InviteCommand {
  String name = "invite";
  String category = "info";
  String description = "Get the invite link for this bot.";
  bool dm_disabled = false;

  register(client) {
    print("[Command Ran] --> $name");

    final command = SlashCommandBuilder(name, description, [])
      ..registerHandler((ISlashCommandInteractionEvent event) async {
        if (dm_disabled) checkForGuild(event);

        await event.acknowledge();

        var ClientID = client.appId;

        String invite =
            'https://discord.com/api/oauth2/authorize?client_id=$ClientID&permissions=8&scope=bot%20applications.commands';

        await event.respond(MessageBuilder.content('$invite'));
      });

    interactionsWS..registerSlashCommand(command);
  }
}
