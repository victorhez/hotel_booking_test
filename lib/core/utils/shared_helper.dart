import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/hotel_model.dart';

class SharedPreferencesHelper {
  static const String favoritesKey = 'favorite_hotels';

  
  static Future<void> saveFavorites(List<Hotel> hotels) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final hotelJsonList = hotels.map((hotel) => jsonEncode(hotel.toJson())).toList();
      await prefs.setStringList(favoritesKey, hotelJsonList);
    } catch (e) {
     //
    }
  }

  
  static Future<List<Hotel>> loadFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final hotelJsonList = prefs.getStringList(favoritesKey) ?? [];
      return hotelJsonList
          .map((hotelJson) => Hotel.fromJson(jsonDecode(hotelJson)))
          .toList();
    } catch (e) {


      return [];
    }
  }


  static Future<void> clearFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(favoritesKey);
    } catch (e) {
      // 

    }
  }


  static Future<bool> isFavorite(Hotel hotel) async {
    try {
      final favorites = await loadFavorites();
      return favorites.any((fav) => fav.name == hotel.name); // Assumes Hotel has an `id` field.
    } catch (e) {

      return false;
    }
  }
}
