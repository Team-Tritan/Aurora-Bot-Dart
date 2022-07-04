import '../commands/info/help.dart';
import '../commands/info/invite.dart';

registerCommands(self) {
  HelpCommand().execute(self);
  InviteCommand().execute(self);
}
