library eventHandler;

import './events/onReady.dart';
import 'events/onMessageReceived.dart';

handleEvents(bot) async {
  onReady(bot);
  onMessageReceived(bot);
}
