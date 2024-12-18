import 'package:equatable/equatable.dart';

import '../../../data/models/hotel_model.dart';


abstract class HotelEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchHotels extends HotelEvent {}

class ToggleFavorite extends HotelEvent {
  final Hotel hotel;

  ToggleFavorite(this.hotel);

  @override
  List<Object?> get props => [hotel];
}
