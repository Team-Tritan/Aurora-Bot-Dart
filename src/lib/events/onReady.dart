import 'package:nyxx/nyxx.dart';

class onReady {
  String name = 'onReady';

  bind(client) {
    print("[Event Loaded] --> $name");
      client.eventsWs.onReady.listen((e) {
        
      });
  }
}
