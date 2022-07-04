import '../commands/info/help.dart';
import '../commands/info/invite.dart';

registerCommands(bot) {
  HelpCommand().execute(bot);
  InviteCommand().execute(bot);
}
