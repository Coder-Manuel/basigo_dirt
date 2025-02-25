import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class StorageUtil {
  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
  }
}
