import 'package:nyxx/nyxx.dart';
import '../../bin/bot.dart' show client;
import '../utils/afk_mentioned.dart';
import '../utils/disable_afk.dart';

Future<void> onMessageReceived(IMessageReceivedEvent event) async {
  late final message = event.message;

  disableAFK(client, message);
  afkMentioned(client, message);
}
