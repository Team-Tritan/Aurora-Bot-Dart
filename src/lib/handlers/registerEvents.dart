library registerEvents;

import '../events/onDmReceived.dart';
import '../events/onMessageReceived.dart';

Future<void> registerEvents(client) async {
  client.eventsWs.onDmReceived.listen(onDmReceived);
  client.eventsWs.onMessageReceived.listen(onMessageReceived);
}
