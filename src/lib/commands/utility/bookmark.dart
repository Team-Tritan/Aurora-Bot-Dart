import 'package:nyxx_interactions/nyxx_interactions.dart';
import 'package:nyxx/nyxx.dart';
import '../../handlers/registerInteractions.dart' show interactionsWS;

class BookmarkCommand {
  String name = "bookmark";
  String category = "utility";
  String description = "Bookmark a message from a server to your dms!";
  late final EmbedBuilder bookmarkEmbed;

  execute(client) {
    print("[Command Ran] --> $name");

    final data = SlashCommandBuilder("$name", "$description", [
      CommandOptionBuilder(
        CommandOptionType.string,
        'id',
        'Message ID.',
        required: true,
      )
    ])
      ..registerHandler((event) async {
        await event.acknowledge();

        late final IMessage message;

        print(event.interaction.type);
        print(SlashCommandType.chat.value);

        if (event.interaction.type == 2) {
          // If slash command type is chat.
          final id = int.parse(event.getArg('id').value.toString());
          final channel = await event.interaction.channel.getOrDownload();
          message = await channel.fetchMessage(id.toSnowflake());
        } else {
          message = event.interaction.resolved!.messages.first;
        }

        bookmarkEmbed = EmbedBuilder()
          ..addAuthor((author) {
            author.name = 'Tritan Bot';
          })
          ..title = 'Bookmarked message'
          ..description = message.content.isNotEmpty ? message.content : null
          ..imageUrl = message.attachments.isNotEmpty
              ? message.attachments.first.url
              : null
          ..url = message.url
              .replaceAll('@me', event.interaction.guild!.id.id.toString())
          ..color = DiscordColor.fromHexString("#5865F2")
          ..timestamp = DateTime.now()
          ..addFooter((footer) {
            footer.text =
                'Requested by ${event.interaction.userAuthor?.username}';
            footer.iconUrl = event.interaction.userAuthor?.avatarURL();
          });

        await event.sendFollowup(MessageBuilder.embed(bookmarkEmbed));

        final componentMessageBuilder = ComponentMessageBuilder();
        final componentRow = ComponentRowBuilder()
          ..addComponent(ButtonBuilder(
              'Bookmark this ', 'add-bm-button', ButtonStyle.success))
          ..addComponent(
              ButtonBuilder('Delete', 'delete-bm-button', ButtonStyle.danger));
        componentMessageBuilder.addComponentRow(componentRow);

        await event.respond(componentMessageBuilder);
      });

    interactionsWS
      ..registerSlashCommand(data)
      ..registerButtonHandler('add-bm-button', addButtonHandler)
      ..registerButtonHandler('delete-bm-button', deleteButtonHandler);
    ;
  }

  Future<void> addButtonHandler(IButtonInteractionEvent event) async {
    await event.acknowledge();
    final author = event.interaction.userAuthor;

    await author?.sendMessage(MessageBuilder.embed(bookmarkEmbed)) ??
        await event.respond(
          MessageBuilder.content(
            "Your DM's are closed! The bookmarked message cannot be sent!",
          ),
          hidden: true,
        );
  }

  Future<void> deleteButtonHandler(IButtonInteractionEvent event) async {
    await event.acknowledge();

    await event.deleteOriginalResponse();
  }
}
