import 'package:http/http.dart' as http;
import "package:nyxx/nyxx.dart";
import "package:nyxx_interactions/nyxx_interactions.dart";
import '../../handlers/register_interactions.dart';
import '../../utils/check_for_guild.dart';

class PingCommand {
  String name = "ping";
  String category = "info";
  String description = "Get the websocket latency of the bot.";
  bool dm_disabled = false;

  register(INyxxWebsocket client) {
    late final EmbedBuilder baseEmbed;
    print("[Command Ran] --> $name");

    final command = SlashCommandBuilder(name, description, [])
      ..registerHandler((ISlashCommandInteractionEvent event) async {
        if (dm_disabled) checkForGuild(event);

        await event.acknowledge();

        final gatewayDelayInMillis = (event.client as INyxxWebsocket)
                .shardManager
                .shards
                .map((e) => e.gatewayLatency.inMilliseconds)
                .reduce((value, element) => value + element) /
            (event.client as INyxxWebsocket).shards;
        final gatewayLatency = gatewayDelayInMillis.abs().floor();

        final apiStopwatch = Stopwatch()..start();
        await http.head(Uri(
            scheme: 'https', host: Constants.host, path: Constants.baseUri));
        final apiLatency = apiStopwatch.elapsedMilliseconds;
        apiStopwatch.stop();

        baseEmbed = EmbedBuilder()
          ..addAuthor((author) {
            author.name = 'Aurora Bot';
            author.iconUrl = client.self.avatarURL();
          })
          ..color = DiscordColor.fromHexString("#5865F2")
          ..title = ':ping_pong: Ping'
          ..timestamp = DateTime.now()
          ..addField(
              name: 'Gateway latency',
              content: '$gatewayLatency ms',
              inline: false)
          ..addField(
              name: 'REST latency', content: '$apiLatency ms', inline: false)
          ..addField(
              name: 'Message latency', content: 'Pending ...', inline: false)
          ..addFooter((footer) {
            footer.text =
                'Requested by: ${event.interaction.userAuthor?.username}';
            footer.iconUrl = event.interaction.userAuthor?.avatarURL();
          });

        final messageStopwatch = Stopwatch()..start();
        final message =
            await event.sendFollowup(MessageBuilder.embed(baseEmbed));

        baseEmbed.replaceField(
          name: 'Message latency',
          content: '${messageStopwatch.elapsedMilliseconds} ms',
          inline: false,
        );

        await message.edit(MessageBuilder.embed(baseEmbed));
        messageStopwatch.stop();
      });

    interactionsWS..registerSlashCommand(command);
  }
}
