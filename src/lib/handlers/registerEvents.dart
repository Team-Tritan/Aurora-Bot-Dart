library handlers;

import '../events/onReady.dart';
import '../events/onMessageReceived.dart';

registerEvents(self) async {
  onReady().bind(self);
  onMessageReceived().bind(self);
}
