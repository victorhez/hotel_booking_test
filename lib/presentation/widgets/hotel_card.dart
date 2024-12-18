import 'package:flutter/material.dart';
import '../../data/models/hotel_model.dart';

class HotelCard extends StatelessWidget {
  final Hotel hotel;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  // ignore: use_key_in_widget_constructors
  const HotelCard({
    required this.hotel,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Adds a shadow effect
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Rounded corners
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12)), // Rounded top corners
            child: Image.network(
              hotel.images[0]
                  .thumbnail, // Assuming hotel has an imageUrl property
              height: 150, // Fixed height for the image
              width: double.infinity, // Full width
              fit: BoxFit.cover, // Cover the entire area
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0), // Padding around the text
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hotel.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                    height: 8), // Space between title and description
                Text(
                  hotel.description,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600], // Grey color for description
                  ),
                ),
              ],
            ),
          ),
          // Favorite button
          Padding(
            padding: const EdgeInsets.only(right: 16.0, bottom: 16.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : null,
                ),
                onPressed: onFavoriteToggle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
