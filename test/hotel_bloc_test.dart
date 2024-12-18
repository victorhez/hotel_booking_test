import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:hotel_booking_app/logic/blocs/hotels/hotel_bloc.dart';
import 'package:hotel_booking_app/logic/blocs/hotels/hotel_event.dart';
import 'package:hotel_booking_app/logic/blocs/hotels/hotel_state.dart';
import 'package:hotel_booking_app/data/models/hotel_model.dart';

import 'hotel_repository_test.mocks.dart'; // Import generated mocks

void main() {
  late MockHotelRepository mockHotelRepository;
  late HotelBloc hotelBloc;

  setUp(() {
    mockHotelRepository = MockHotelRepository();
    hotelBloc = HotelBloc(mockHotelRepository);
  });

  tearDown(() {
    hotelBloc.close();
  });

  test('Initial state is HotelLoading', () {
    expect(hotelBloc.state, equals(HotelLoading()));
  });

  test('Emit HotelLoaded when FetchHotels is successful', () async {
    // Arrange
    final mockHotels = [
     Hotel(
          name: "Luxury Hotel",
          description: "5-star luxury hotel in Bali.",
          hotelClass: "Luxury",
          extractedHotelClass: 5,
          images: [
            HotelImage(
                thumbnail: "https://example.com/luxury_hotel_thumbnail.jpg")
          ],
          overallRating: 4.8,
          amenities: ["Pool", "Spa", "Gym"],
          reviews: 33),
           Hotel(
          name: "Beachside Resort",
          description: "Relax by the beach.",
          hotelClass: "Resort",
          extractedHotelClass: 4,
          images: [
            HotelImage(
                thumbnail: "https://example.com/beachside_resort_thumbnail.jpg")
          ],
          overallRating: 4.3,
          amenities: ["Beach Access", "Bar", "Free Wi-Fi"],
          reviews: 33),
      Hotel(
          name: "Budget Inn",
          description: "Affordable and comfortable.",
          hotelClass: "Budget",
          extractedHotelClass: 3,
          images: [
            HotelImage(
                thumbnail: "https://example.com/budget_inn_thumbnail.jpg")
          ],
          overallRating: 3.9,
          amenities: ["Free Parking", "Complimentary Breakfast"],
          reviews: 344),
    ];
    when(mockHotelRepository.getHotels()).thenAnswer((_) async => mockHotels);

    // Act
    hotelBloc.add(FetchHotels());

    // Assert
    await expectLater(
      hotelBloc.stream,
      emitsInOrder([
        HotelLoading(),
        HotelLoaded(hotels: mockHotels, favorites: []),
      ]),
    );

    verify(mockHotelRepository.getHotels()).called(1);
  });

  test('Emit HotelError when FetchHotels fails', () async {
    // Arrange
    when(mockHotelRepository.getHotels()).thenThrow(Exception('API Error'));

    // Act
    hotelBloc.add(FetchHotels());

    // Assert
    await expectLater(
      hotelBloc.stream,
      emitsInOrder([
        HotelLoading(),
        HotelError("Failed to load hotels. Please try again."),
      ]),
    );

    verify(mockHotelRepository.getHotels()).called(1);
  });

  test('ToggleFavorite adds and removes favorites', () async {
    // Arrange
    final mockHotels = [
      Hotel(
          name: "Luxury Hotel",
          description: "5-star luxury hotel in Bali.",
          hotelClass: "Luxury",
          extractedHotelClass: 5,
          images: [
            HotelImage(
                thumbnail: "https://example.com/luxury_hotel_thumbnail.jpg")
          ],
          overallRating: 4.8,
          amenities: ["Pool", "Spa", "Gym"],
          reviews: 33),
    ];
    final mockFavorites = <Hotel>[];

    hotelBloc.emit(HotelLoaded(hotels: mockHotels, favorites: mockFavorites));

    // Act
    final hotel = mockHotels.first;
    hotelBloc.add(ToggleFavorite( hotel));

    // Assert
    await expectLater(
      hotelBloc.stream,
      emits(
        HotelLoaded(
          hotels: mockHotels,
          favorites: [hotel],
        ),
      ),
    );

    hotelBloc.add(ToggleFavorite( hotel));
    await expectLater(
      hotelBloc.stream,
      emits(
        HotelLoaded(
          hotels: mockHotels,
          favorites: [],
        ),
      ),
    );
  });
}
