import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hotel_booking_app/core/network/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/hotel_model.dart';

class HotelRepository {
  final ApiService _apiService;

  HotelRepository(this._apiService);

  Future<List<Hotel>> getHotels() async {
    try {
      final data = await _apiService.fetchHotels();
      debugPrint(data[0].toString());
      return data.map<Hotel>((json) => Hotel.fromJson(json)).toList();
    } catch (e) {
      debugPrint('Error fetching hotels: $e');
      return [];
    }
  }

  Future<void> saveFavorite(Hotel hotel) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList('favorites') ?? [];
    if (!favorites.contains(hotel.name)) {
      favorites.add(hotel.toString());
      await prefs.setStringList('favorites', favorites);
    }
  }

  Future<List<Hotel>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList('favorites') ?? [];
    return favorites.map((e) {
      final Map<String, dynamic> hotelJson = json.decode(e);
      return Hotel.fromJson(hotelJson);
    }).toList();
  }
}
