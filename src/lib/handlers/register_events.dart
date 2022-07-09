import 'package:nyxx/nyxx.dart';
import '../events/on_dm_received.dart';
import '../events/on_message_received.dart';
import '../events/on_ready.dart';
import '../modules/modlogs.dart' as modlogs;

Future<void> registerEvents(INyxxWebsocket client) async {
  client.eventsWs.onReady.listen(onReady);
  client.eventsWs.onDmReceived.listen(onDmReceived);
  client.eventsWs.onMessageReceived.listen(onMessageReceived);
}

Future<void> registerModules(INyxxWebsocket client) async {
  client.eventsWs.onMessageDelete.listen(modlogs.message_deleted);
}
