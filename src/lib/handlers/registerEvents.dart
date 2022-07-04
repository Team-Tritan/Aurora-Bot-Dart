library handlers;

import '../events/onReady.dart';
import '../events/onMessageReceived.dart';

registerEvents(bot) async {
  onReady().bind(bot);
  onMessageReceived().bind(bot);
}
