import 'package:mongo_dart/mongo_dart.dart';
import '../../config.dart';

OpenDatabase(client) async {
  final db = Db(CONFIG.mongodb);
  await db.open();
  print("[MONGODB] --> Connected to MongoDB, and attached to the client.");
  return db;
}
