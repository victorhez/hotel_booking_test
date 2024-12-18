import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/blocs/hotels/hotel_bloc.dart';
import '../../logic/blocs/hotels/hotel_event.dart';
import '../../logic/blocs/hotels/hotel_state.dart';
import '../widgets/error_widget.dart';
import '../widgets/hotel_card.dart';

@RoutePage()
// ignore: use_key_in_widget_constructors
class HotelsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HotelBloc, HotelState>(
      builder: (context, state) {
        if (state is HotelLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HotelLoaded) {
          return ListView.separated(
            itemCount: state.hotels.length,
            itemBuilder: (_, index) {
              final hotel = state.hotels[index];
              final isFavorite = state.favorites.contains(hotel);
              return Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: HotelCard(
                  hotel: hotel,
                  isFavorite: isFavorite,
                  onFavoriteToggle: () {
                    context.read<HotelBloc>().add(ToggleFavorite(hotel));
                  },
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 10,
              );
            },
          );
        } else if (state is HotelError) {
          return CustomErrorWidget(
            onRetry: () {
              context.read<HotelBloc>().add(FetchHotels());
            },
          );
        }
        return Container();
      },
    );
  }
}
