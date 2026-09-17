class Property {
  final String id;
  final String title;
  final String location;
  final String price;
  final String image;
  final int beds;
  final int baths;
  final String type;
  final double rating;

  const Property({
    required this.id,
    required this.title,
    required this.location,
    required this.price,
    required this.image,
    required this.beds,
    required this.baths,
    required this.type,
    required this.rating,
  });

  // API ke JSON ko Property mein badalta hai
  factory Property.fromJson(Map<String, dynamic> json) {
    final images = (json['imageUrls'] is List) ? json['imageUrls'] as List : [];
    return Property(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? 'Untitled',
      location: json['locationLabel']?.toString() ??
          [json['city'], json['country']]
              .where((e) => e != null && '$e'.toString().isNotEmpty)
              .join(', '),
      price: json['priceLabel']?.toString() ??
          '${json['currency'] ?? ''} ${json['price'] ?? ''}'.trim(),
      image: images.isNotEmpty ? images.first.toString() : '',
      beds: (json['beds'] as num?)?.toInt() ?? 0,
      baths: (json['baths'] as num?)?.toInt() ?? 0,
      type: json['type']?.toString() ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

const List<Property> sampleProperties = [
  Property(
    id: '1',
    title: 'The Lakefront Estate',
    location: 'Lake Geneva, Switzerland',
    price: '\$1.320,00',
    image:
        'https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&w=800',
    beds: 6,
    baths: 6,
    type: 'Houses',
    rating: 4.5,
  ),
  Property(
    id: '2',
    title: 'The Emerald Mansion',
    location: 'Beverly Hills, California, USA',
    price: '\$1.320,00',
    image:
        'https://images.pexels.com/photos/1029599/pexels-photo-1029599.jpeg?auto=compress&cs=tinysrgb&w=800',
    beds: 6,
    baths: 6,
    type: 'Villa',
    rating: 4.5,
  ),
  Property(
    id: '3',
    title: 'Modern Loft in Manhattan',
    location: 'Manhattan, New York City, USA',
    price: '\$2.800,000',
    image:
        'https://images.pexels.com/photos/1571460/pexels-photo-1571460.jpeg?auto=compress&cs=tinysrgb&w=800',
    beds: 3,
    baths: 2,
    type: 'Apartment',
    rating: 4.5,
  ),
  Property(
    id: '4',
    title: 'Coastal Villa in Malibu',
    location: 'Malibu, California, USA',
    price: '\$12.500,000',
    image:
        'https://images.pexels.com/photos/32870/pexels-photo.jpg?auto=compress&cs=tinysrgb&w=800',
    beds: 5,
    baths: 4,
    type: 'Villa',
    rating: 4.5,
  ),
  Property(
    id: '5',
    title: 'Countryside Cottage',
    location: 'Cotswolds, England',
    price: '\$950,000',
    image:
        'https://images.pexels.com/photos/280222/pexels-photo-280222.jpeg?auto=compress&cs=tinysrgb&w=800',
    beds: 4,
    baths: 3,
    type: 'Houses',
    rating: 4.5,
  ),
  Property(
    id: '6',
    title: 'Penthouse Apartment',
    location: 'Dubai Marina, Dubai, UAE',
    price: '\$9.200,000',
    image:
        'https://images.pexels.com/photos/1732414/pexels-photo-1732414.jpeg?auto=compress&cs=tinysrgb&w=800',
    beds: 4,
    baths: 4,
    type: 'Apartment',
    rating: 4.5,
  ),
];
