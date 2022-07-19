import '../../handlers/register_interactions.dart' show interactionsWS;
import 'package:nyxx_interactions/nyxx_interactions.dart';
import 'package:nyxx/nyxx.dart';
import '../../utils/check_for_guild.dart';
import '../../modules/reminders.dart';

class RemindCommand {
  // class my nuts im afraid
  String name = "remind";
  String category = "utility";
  String description = "Add a reminder!";
  bool dm_disabled = true;

  register(INyxxWebsocket client) {
    print("[Command Ran] --> $name");

    final command = SlashCommandBuilder(this.name, this.description, [
      CommandOptionBuilder(
        CommandOptionType.string,
        'time',
        'Time as a number only (Ex. 15)',
        required: true,
      ),
      CommandOptionBuilder(
        CommandOptionType.string,
        'unit',
        'Time unit (Ex. seconds, minutes, hours, or days)',
        required: true,
      ),
      CommandOptionBuilder(CommandOptionType.string, 'text', 'Reminder text',
          required: true)
    ])
      ..registerHandler((ISlashCommandInteractionEvent event) async {
        if (dm_disabled) checkForGuild(event);

        var sexyEmbed = EmbedBuilder()
          ..addAuthor((author) {
            author.name = 'Aurora Bot';
            author.iconUrl = client.self.avatarURL();
          })
          ..title = 'Set Reminder'
          ..color = DiscordColor.fromHexString("#5865F2")
          ..timestamp = DateTime.now()
          ..addFooter((footer) {
            footer.text =
                'Requested by ${event.interaction.userAuthor?.username}';
            footer.iconUrl = event.interaction.userAuthor?.avatarURL();
          });

        final userId = event.interaction.userAuthor?.id;

        await event.acknowledge();

        var time = event.getArg('time').toString();
        int time_num = int.parse('$time');

        var unit = event.getArg('unit').toString();
        var text = event.getArg('text').toString();

        if (unit == 'seconds') {
          //
        } else if (unit == 'minutes') {
          final new_time = DateTime.now().add(Duration(minutes: time_num));

          var new_reminder = new RemindersModule().add_reminder(
              client, true, new_time, userId.toString(), text, DateTime.now());

          print(new_reminder);

          sexyEmbed
            ..description = 'We will remind you to `$text` at $new_time.';

          return event.respond(MessageBuilder.embed(sexyEmbed));
        } else if (unit == 'hours') {
        } else if (unit == 'days') {
          //
        } else {
          sexyEmbed
            ..description =
                'You need to specify a unit of time that matches exactly the following: `minutes`, `days`, or `hours`.';
          return event.respond(MessageBuilder.embed(sexyEmbed));
        }
      });
    interactionsWS..registerSlashCommand(command);
  }
}
