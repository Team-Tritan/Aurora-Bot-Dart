import 'package:nyxx_interactions/nyxx_interactions.dart';
import 'package:nyxx/nyxx.dart';
import 'dart:isolate'; // this bad boy is FIRE
import '../../utils/checkForGuild.dart';
import '../../handlers/registerInteractions.dart' show interactionsWS;

class EvalCommand {
  String name = "eval";
  String category = "utility";
  String description = "Run a dart command evaluation.";
  bool dm_disabled = true;

  late final EmbedBuilder bookmarkEmbed;
  late final IMessage message;

  execute(client) {
    print("[Command Ran] --> $name");

    final data = SlashCommandBuilder('$name', '$description', [
      CommandOptionBuilder(
        CommandOptionType.string,
        'code',
        'The dart code to be evaluated in the form of a function ofc.',
        required: true,
      )
    ])
      ..registerHandler((event) async {
        if (dm_disabled) checkForGuild(event);
        await event.acknowledge();

        final function =
            event.getArg('code').value.toString().replaceAll('```', '');
        final functionName = function.split('()')[0].split(' ')[1];

        final uri = Uri.dataFromString(
          '''
      import 'dart:isolate';
      import 'dart:math';
      import 'dart:cli';
      import 'dart:io' hide exit;
      void main(_, SendPort port) {
        port.send($functionName());
      }
      $function
      ''',
          mimeType: 'application/dart',
        );

        final port = ReceivePort();
        final isolate = await Isolate.spawnUri(uri, [], port.sendPort);
        final String response = (await port.first).toString();

        port.close();
        isolate.kill();

        var content = function.replaceAll('{', '{\n\t');
        content = content.replaceAll('}', '\n}');
        content = content.replaceAll(';', ';\n\t');

        final evalEmbed = EmbedBuilder()
          ..addAuthor((author) {
            author.name = 'Aurora Bot';
          })
          ..title = 'Evaluate Dart Code'
          ..color = DiscordColor.fromHexString("#5865F2")
          ..timestamp = DateTime.now()
          ..addField(name: 'Code', content: '```dart\n$content```')
          ..addField(name: 'Output', content: '```dart\n$response```')
          ..addFooter((footer) {
            footer.text =
                'Requested by ${event.interaction.userAuthor?.username}';
            footer.iconUrl = event.interaction.userAuthor?.avatarURL();
          });

        await event.respond(MessageBuilder.embed(evalEmbed));
      });
    interactionsWS..registerSlashCommand(data);
  }
}
