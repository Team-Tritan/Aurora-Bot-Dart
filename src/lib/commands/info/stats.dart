import 'dart:io';
import "package:nyxx/nyxx.dart";
import "package:nyxx_interactions/nyxx_interactions.dart";
import 'package:system_info/system_info.dart';
import '../../utils/check_for_guild.dart';
import '../../handlers/register_interactions.dart';

class StatsCommand {
  String name = "stats";
  String category = "info";
  String description = "Generalized stats about the bot.";
  bool dm_disabled = false;

  register(INyxxWebsocket client) {
    print("[Command Ran] --> $name");

    final command = SlashCommandBuilder(this.name, this.description, [])
      ..registerHandler((ISlashCommandInteractionEvent event) async {
        if (dm_disabled) checkForGuild(event);

        await event.acknowledge();

        final String OS = Platform.operatingSystem.toString();
        final String Dart_Version = Platform.version.toString();
        final String Processors = Platform.numberOfProcessors.toString();
        final String Locale = Platform.localeName.toString();
        final int Total_Ram =
            SysInfo.getTotalPhysicalMemory() ~/ (1024 * 1024 * 1024);
        final int Free_Ram =
            SysInfo.getFreePhysicalMemory() ~/ (1024 * 1024 * 1024);
        final String Kernel = SysInfo.kernelName.toString();

        final embed = EmbedBuilder()
          ..addAuthor((author) {
            author.name = 'Aurora Bot';
            author.iconUrl = client.self.avatarURL();
          })
          ..color = DiscordColor.fromHexString("#5865F2")
          ..title = 'Bot Stats'
          ..addField(name: '☄️ OS', content: OS, inline: true)
          ..addField(name: '🌎 Server Locale', content: Locale, inline: true)
          ..addField(
              name: 'ℹ️ Dart Version', content: Dart_Version, inline: true)
          ..addField(name: '💿 CPU Cores', content: Processors, inline: true)
          ..addField(
              name: '📊 Ram Usage',
              content: '${Total_Ram - Free_Ram}/$Total_Ram GB',
              inline: true)
          ..addField(name: '🍿 Kernel', content: Kernel, inline: true)
          ..timestamp = DateTime.now()
          ..addFooter((footer) {
            footer.text =
                'Requested by: ${event.interaction.userAuthor?.username}';
            footer.iconUrl = event.interaction.userAuthor?.avatarURL();
          });

        await event.respond(MessageBuilder.embed(embed));
      });
    interactionsWS..registerSlashCommand(command);
  }
}
