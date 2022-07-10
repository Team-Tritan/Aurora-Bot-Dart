import 'dart:async';
import 'package:nyxx_interactions/nyxx_interactions.dart';
import 'package:nyxx/nyxx.dart';
import '../commands/config/logging.dart';
import '../commands/fun/coinflip.dart';
import '../commands/info/help.dart';
import '../commands/info/invite.dart';
import '../commands/info/ping.dart';
import '../commands/info/stats.dart';
import '../commands/utility/afk.dart';
import '../commands/utility/bookmark.dart';

late IInteractions interactionsWS;

Future<void> registerInteractions(INyxxWebsocket client) async {
  interactionsWS = IInteractions.create(WebsocketInteractionBackend(client));

  new HelpCommand().register(client);
  new PingCommand().register(client);
  new InviteCommand().register(client);
  new CoinFlipCommand().register(client);
  new BookmarkCommand().register(client);
  new AFKCommand().register(client);
  new LoggingCommand().register(client);
  new StatsCommand().register(client);

  interactionsWS.syncOnReady();
}
