library registerEvents;

import '../events/on_dm_received.dart';
import '../events/on_message_received.dart';
import '../events/on_ready.dart';
import 'package:nyxx/nyxx.dart';
import '../modules/modlogs.dart';

Future<void> registerEvents(INyxxWebsocket client) async {
  client.eventsWs.onReady.listen(onReady);
  client.eventsWs.onDmReceived.listen(onDmReceived);
  client.eventsWs.onMessageReceived.listen(onMessageReceived);
}

Future<void> registerModules(INyxxWebsocket client) async {
  //Modlogs
  client.eventsWs.onMessageDelete.listen(onDelete);
}
