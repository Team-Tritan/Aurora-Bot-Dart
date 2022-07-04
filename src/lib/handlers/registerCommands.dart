import 'dart:async';
import '../commands/fun/coinflip.dart';
import '../commands/info/help.dart';
import '../commands/info/invite.dart';
import 'package:nyxx_interactions/nyxx_interactions.dart';

late IInteractions interactionsWS;

Future<void> registerCommands(client) async {
  interactionsWS = IInteractions.create(WebsocketInteractionBackend(client));

  HelpCommand().execute(client);
  InviteCommand().execute(client);
  CoinFlipCommand().execute(client);

  interactionsWS.syncOnReady();
}
