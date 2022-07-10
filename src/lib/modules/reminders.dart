import 'package:nyxx/nyxx.dart';
import 'package:hive/hive.dart';

// model
class Reminder extends HiveObject {
  @HiveField(0)
  late bool active;

  @HiveField(1)
  late DateTime timeEnds;

  @HiveField(2)
  late String userId;

  @HiveField(3)
  late String message;

  @HiveField(4)
  late DateTime createdAt;
}

// Module class
class RemindersModule {
  final String module = 'Reminders';

// add reminder
  Future<void> add_reminder(
      INyxxWebsocket client,
      bool active,
      DateTime timeEnds,
      String userId,
      String message,
      DateTime createdAt) async {
    var box = await Hive.openBox('Reminders');

    var new_reminder = new Reminder()
      ..active = true
      ..timeEnds = timeEnds
      ..userId = userId
      ..message = message
      ..createdAt = createdAt;

    box.add(new_reminder);

    print('[REMINDERS] New reminder saved');
    print(box.getAt(0));
  }

// check & send reminders
  Future<void> check_reminders(
    INyxxWebsocket client,
  ) async {}
}
