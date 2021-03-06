import "package:nyxx/nyxx.dart";

// if command shows dm_disabled in command class, checks for guild and if no guild, returns message.
void checkForGuild(event) {
  if (event.interaction.guild == null) {
    var baseEmbed = EmbedBuilder()
      ..addAuthor((author) {
        author.name = 'Aurora Bot';
      })
      ..title = ':x: Command Failed'
      ..description =
          "We're sorry, this command does not work in the DMs. You can run this in a server though!"
      ..color = DiscordColor.fromHexString("#5865F2")
      ..timestamp = DateTime.now()
      ..addFooter((footer) {
        footer.text = 'Requested by ${event.interaction.userAuthor?.username}';
        footer.iconUrl = event.interaction.userAuthor?.avatarURL();
      });

    return event.respond(MessageBuilder.embed(baseEmbed));
  }
}
