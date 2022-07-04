import '../commands/info/help.dart';
import '../commands/info/invite.dart';
import '../commands/info/ping.dart';

registerCommands(client) {
  HelpCommand().execute(client);
  InviteCommand().execute(client);
  PingCommand().execute(client);
}
