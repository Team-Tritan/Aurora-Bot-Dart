library registerCommands;

import 'dart:async';
import '../commands/config/logging.dart';
import '../commands/fun/coinflip.dart';
import '../commands/info/help.dart';
import '../commands/info/invite.dart';
import '../commands/info/ping.dart';
import '../commands/utility/afk.dart';
import '../commands/utility/bookmark.dart';
import 'package:nyxx_interactions/nyxx_interactions.dart';
import 'package:nyxx/nyxx.dart';

late IInteractions interactionsWS;

Future<void> registerInteractions(INyxxWebsocket client) async {
  interactionsWS = IInteractions.create(WebsocketInteractionBackend(client));

  HelpCommand().register(client);
  PingCommand().register(client);
  InviteCommand().register(client);
  CoinFlipCommand().register(client);
  BookmarkCommand().register(client);
  AFKCommand().register(client);
  LoggingCommand().register(client);

  interactionsWS.syncOnReady();
}
