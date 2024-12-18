import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/shared_helper.dart';
import '../../../data/models/hotel_model.dart';
import '../../../domain/repositories/hotel_repository.dart';

import 'hotel_event.dart';
import 'hotel_state.dart';

class HotelBloc extends Bloc<HotelEvent, HotelState> {
  final HotelRepository hotelRepository;

  HotelBloc(this.hotelRepository) : super(HotelLoading()) {
    on<FetchHotels>(_fetchHotels);
    on<ToggleFavorite>(_toggleFavorite);
  }

  Future<void> _fetchHotels(FetchHotels event, Emitter<HotelState> emit) async {
    try {
      emit(HotelLoading());
      final hotels = await hotelRepository.getHotels();
      final favorites = await SharedPreferencesHelper.loadFavorites();
      emit(HotelLoaded(hotels: hotels, favorites: favorites));
    } catch (e) {
      emit(HotelError("Failed to load hotels. Please try again."));
    }
  }

  // Add/remove a hotel from the favorites
  Future<void> _toggleFavorite(
      ToggleFavorite event, Emitter<HotelState> emit) async {
    if (state is HotelLoaded) {
      final currentState = state as HotelLoaded;
      final favorites = List<Hotel>.from(currentState.favorites);

      if (favorites.contains(event.hotel)) {
        favorites.remove(event.hotel);
      } else {
        favorites.add(event.hotel);
      }

      await SharedPreferencesHelper.saveFavorites(favorites);
      emit(HotelLoaded(hotels: currentState.hotels, favorites: favorites));
    }
  }
}
