import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/blocs/hotels/hotel_bloc.dart';
import '../../logic/blocs/hotels/hotel_event.dart';
import '../../logic/blocs/hotels/hotel_state.dart';
import '../../presentation/widgets/hotel_card.dart';

@RoutePage()
// ignore: use_key_in_widget_constructors
class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favorites")),
      body: BlocBuilder<HotelBloc, HotelState>(
        builder: (context, state) {
          if (state is HotelLoaded && state.favorites.isNotEmpty) {
            return ListView.builder(
              itemCount: state.favorites.length,
              itemBuilder: (context, index) {
                final hotel = state.favorites[index];
                return Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: HotelCard(
                    hotel: hotel,
                    isFavorite: true,
                    onFavoriteToggle: () {
                      context.read<HotelBloc>().add(ToggleFavorite(hotel));
                    },
                  ),
                );
              },
            );
          } else if (state is HotelLoaded && state.favorites.isEmpty) {
            return const Center(
              child: Text(
                "No favorite hotels yet!",
                style: TextStyle(fontSize: 16),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
