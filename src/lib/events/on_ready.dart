import 'package:nyxx/nyxx.dart';
import "dart:math";
import 'dart:async';
import '../../config.dart';
import '../../bin/bot.dart' show client;
import '../modules/reminders.dart';

final bool isStopped = false;
final _random = new Random();

Future<void> onReady(event) async {
  // Initial presence, then interval kicks in
  client.setPresence(
    PresenceBuilder.of(
      status: UserStatus.dnd,
      activity: ActivityBuilder.watching("ahhhh oooooo mmmmmm"),
    ),
  );

// Init functions
  setStatusTimer(client);
  checkReminders(client);
}

// Functions
setStatusTimer(client) {
  Timer.periodic(Duration(minutes: 20), (timer) {
    if (isStopped) {
      timer.cancel();
    }

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

checkReminders(client) {
  Timer.periodic(Duration(seconds: 1), (timer) {
    RemindersModule().check_reminders(client);
  });
}
