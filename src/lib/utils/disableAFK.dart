import 'package:hive/hive.dart';

// Checks if AFK is enabled for user, then disables when a message is sent.
void disableAFK(client, message) async {
  final box = await Hive.openBox('AFKs');
  final isAFK = box.get(message.author.id.toString());

  if (isAFK != null) {
    await box.delete(message.author.id.toString());
    print('[AFK] Removed AFK status from ${message.author.id}');
  }
}
