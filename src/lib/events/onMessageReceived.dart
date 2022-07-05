import 'package:nyxx/nyxx.dart';
import '../../bot.dart' show client;
import '../utils/disableAFK.dart';

Future<void> onMessageReceived(IMessageReceivedEvent event) async {
  late final message = event.message;

  // Checks if AFK is enabled for user, then disables when a message is sent.
  disableAFK(client, message);
}
