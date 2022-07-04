library registerEvents;

import '../events/onDmReceived.dart';

Future<void> registerEvents(client) async {
  client.eventsWs.onDmReceived.listen(onDmReceived);
}
