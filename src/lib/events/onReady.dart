import 'package:nyxx/nyxx.dart';
import "dart:math";
import 'dart:async';
import '../../config.dart';
import '../../bot.dart' show client;

Future<void> onReady(event) async {
  client.setPresence(
    PresenceBuilder.of(
      status: UserStatus.dnd,
      activity: ActivityBuilder.watching('hello world!'),
    ),
  );

  setStatusTimer(client);
}

bool isStopped = false;

setStatusTimer(client) {
  Timer.periodic(Duration(minutes: 10), (timer) {
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
