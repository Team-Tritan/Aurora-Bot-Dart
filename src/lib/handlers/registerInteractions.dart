library registerCommands;

import 'dart:async';
import '../commands/fun/coinflip.dart';
import '../commands/info/help.dart';
import '../commands/info/invite.dart';
import '../commands/info/ping.dart';
import '../commands/utility/bookmark.dart';
import 'package:nyxx_interactions/nyxx_interactions.dart';

late IInteractions interactionsWS;

Future<void> registerInteractions(client) async {
  interactionsWS = IInteractions.create(WebsocketInteractionBackend(client));

  HelpCommand().execute(client);
  PingCommand().execute(client);
  InviteCommand().execute(client);
  CoinFlipCommand().execute(client);
  BookmarkCommand().execute(client);

  interactionsWS.syncOnReady();
}
