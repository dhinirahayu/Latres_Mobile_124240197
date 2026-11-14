import 'package:hive_flutter/hive_flutter.dart';
import '../models/show_model.dart';

class HiveService {
  static const String boxName = 'favorite_shows_box';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(boxName);
  }

  static Box getBox() {
    return Hive.box(boxName);
  }

  static Future<bool> toggleFavorite(ShowModel show) async {
    final box = getBox();
    final String key = show.id.toString();

    if (box.containsKey(key)) {
      await box.delete(key);
      return false;
    } else {
      await box.put(key, show.toMap());
      return true;
    }
  }

  static Future<void> removeFavorite(int id) async {
    final box = getBox();
    await box.delete(id.toString());
  }

  static bool isFavorite(int id) {
    final box = getBox();
    return box.containsKey(id.toString());
  }

  static List<ShowModel> getAllFavorites() {
    final box = getBox();
    final List<ShowModel> favorites = [];

    for (var key in box.keys) {
      final item = box.get(key);
      if (item != null && item is Map) {
        favorites.add(ShowModel.fromMap(item));
      }
    }

    return favorites;
  }
}
