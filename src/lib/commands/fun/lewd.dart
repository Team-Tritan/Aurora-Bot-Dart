import "package:nyxx/nyxx.dart";
import "package:nyxx_interactions/nyxx_interactions.dart";
import 'package:requests/requests.dart';
import '../../handlers/register_interactions.dart';
import '../../utils/check_for_guild.dart';

class LewdCommand {
  String name = "lewd";
  String category = "fun";
  String description = "Yaoi yaoi yaoi";
  bool dm_disabled = false;

  register(INyxxWebsocket client) {
    print("[Command Ran] --> $name");

    final command = SlashCommandBuilder(this.name, this.description, [])
      ..registerHandler((ISlashCommandInteractionEvent event) async {
        if (dm_disabled) checkForGuild(event);

        await event.acknowledge();

        var res = await Requests.get('http://lewd.tritan.gg/api/v1/yaoi',
            bodyEncoding: RequestBodyEncoding.FormURLEncoded);

        dynamic json = res.json();

        await event.respond(MessageBuilder.content(json['url']));
      });

    interactionsWS..registerSlashCommand(command);
  }
}
