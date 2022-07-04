import 'package:nyxx/nyxx.dart';

onReady(bot) {
  print("[Event Loaded] --> onReady");

  bot.eventsWs.onReady.listen((IReadyEvent e) {
    print(
        "[Bot Ready] Bot is logged into the discord API and has received the ready event.");
  });
}
