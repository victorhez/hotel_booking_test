class Hotel {
  final String name;
  final String description;

  final String hotelClass;
  final int extractedHotelClass;
  final List<HotelImage> images;
  final double overallRating;
  final int reviews;
  final List<String> amenities;

  Hotel({
    required this.name,
    required this.description,
    required this.hotelClass,
    required this.extractedHotelClass,
    required this.images,
    required this.overallRating,
    required this.reviews,
    required this.amenities,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      hotelClass: json['hotel_class'] ?? '1',
      extractedHotelClass: json['extracted_hotel_class'] ?? 1,
      images: (json['images'] as List? ?? [])
          .map((img) => HotelImage.fromJson(img))
          .toList(),
      overallRating: json['overall_rating']?.toDouble() ?? 0.0,
      reviews: json['reviews'] ?? 0,
      amenities: (json['amenities'] as List? ?? [])
          .map((amenity) => amenity.toString())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'hotel_class': hotelClass,
      'extracted_hotel_class': extractedHotelClass,
      'images': images.map((img) => img.toJson()).toList(),
      'overall_rating': overallRating,
      'reviews': reviews,
      'amenities': amenities,
    };
  }
}

class GPSCoordinates {
  final double latitude;
  final double longitude;

  GPSCoordinates({
    required this.latitude,
    required this.longitude,
  });

  factory GPSCoordinates.fromJson(Map<String, dynamic> json) {
    return GPSCoordinates(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

class HotelImage {
  final String thumbnail;

  HotelImage({
    required this.thumbnail,
  });

  factory HotelImage.fromJson(Map<String, dynamic> json) {
    return HotelImage(
      thumbnail: json['thumbnail'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'thumbnail': thumbnail,
    };
  }
}

class Review {
  final String author;
  final String content;
  final double rating;

  Review({
    required this.author,
    required this.content,
    required this.rating,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      author: json['author'],
      content: json['content'],
      rating: json['rating']?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'author': author,
      'content': content,
      'rating': rating,
    };
  }
}
