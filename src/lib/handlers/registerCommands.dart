import '../commands/fun/coinflip.dart';
import '../commands/info/help.dart';
import '../commands/info/invite.dart';

Future<void> registerCommands(client) async {
  HelpCommand().execute(client);
  InviteCommand().execute(client);
  CoinFlipCommand().execute(client);
}
