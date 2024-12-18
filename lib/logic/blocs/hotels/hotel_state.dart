import 'package:equatable/equatable.dart';
import '../../../data/models/hotel_model.dart';


abstract class HotelState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HotelLoading extends HotelState {}

class HotelLoaded extends HotelState {
  final List<Hotel> hotels;
  final List<Hotel> favorites;

  HotelLoaded({
    required this.hotels,
    required this.favorites,
  });

  @override
  List<Object?> get props => [hotels, favorites];
}

class HotelError extends HotelState {
  final String message;

  HotelError(this.message);

  @override
  List<Object?> get props => [message];
}
