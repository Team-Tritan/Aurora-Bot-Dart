library registerCommands;

import 'dart:async';
import '../commands/fun/coinflip.dart';
import '../commands/info/help.dart';
import '../commands/info/invite.dart';
import '../commands/info/ping.dart';
import '../commands/utility/afk.dart';
import '../commands/utility/bookmark.dart';
import 'package:nyxx_interactions/nyxx_interactions.dart';

late IInteractions interactionsWS;

Future<void> registerInteractions(client) async {
  interactionsWS = IInteractions.create(WebsocketInteractionBackend(client));

  HelpCommand().register(client);
  PingCommand().register(client);
  InviteCommand().register(client);
  CoinFlipCommand().register(client);
  BookmarkCommand().register(client);
  AFKCommand().register(client);

  interactionsWS.syncOnReady();
}
