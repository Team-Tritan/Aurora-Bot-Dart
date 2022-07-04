library handlers;

import '../events/onReady.dart';
import '../events/onMessageReceived.dart';

registerEvents(client) async {
  onReady().bind(client);
  onMessageReceived().bind(client);
}
