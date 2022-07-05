import 'package:nyxx/nyxx.dart';
import "dart:math";
import 'dart:async';
import '../../config.dart';
import '../../bot.dart' show client;

bool isStopped = false;

Future<void> onReady(event) async {
  await setStatusTimer(client);
}

setStatusTimer(client) async {
  Timer.periodic(Duration(minutes: 20), (timer) {
    if (isStopped) {
      timer.cancel();
    }

    final _random = new Random();
    final status = CONFIG.activities[_random.nextInt(CONFIG.activities.length)];

    client.setPresence(
      PresenceBuilder.of(
        status: UserStatus.dnd,
        activity: ActivityBuilder.watching(status),
      ),
    );

    print("[Status Updated] --> $status");
  });
}
