library registerEvents;

import '../events/onDmReceived.dart';
import '../events/onMessageReceived.dart';
import '../events/onReady.dart';

Future<void> registerEvents(client) async {
  client.eventsWs.onReady.listen(onReady);
  client.eventsWs.onDmReceived.listen(onDmReceived);
  client.eventsWs.onMessageReceived.listen(onMessageReceived);
}
