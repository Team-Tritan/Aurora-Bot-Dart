library registerEvents;

import '../events/on_dm_received.dart';
import '../events/on_message_received.dart';
import '../events/on_ready.dart';

Future<void> registerEvents(client) async {
  client.eventsWs.onReady.listen(onReady);
  client.eventsWs.onDmReceived.listen(onDmReceived);
  client.eventsWs.onMessageReceived.listen(onMessageReceived);
}
