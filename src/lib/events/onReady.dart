import 'package:nyxx/nyxx.dart';

class onReady {
  bind(bot) {
    print("[Event Loaded] --> onReady");

    bot.eventsWs.onReady.listen((IReadyEvent e) {
      print(
          "[Bot Ready] Bot is logged into the discord API and has received the ready event.");
    });
  }
}
