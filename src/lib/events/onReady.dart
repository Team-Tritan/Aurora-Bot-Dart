import 'package:nyxx/nyxx.dart';

class onReady {
  String name = 'onReady';

  bind(self) {
    print("[Event Loaded] --> $name");

    self.eventsWs.onReady.listen((e) {
      print(
          "[Bot Ready] Bot is logged into the discord API and has received the ready event.");
    });
  }
}
