class Room {
  final String title;
  final String location;
  final int price;
  final int area;
  final int bedrooms;
  final int bathrooms;
  final bool hasParking;
  final int photoCount;
  final String imageUrl;
  final bool isNew;
  final List<String> tags;

  const Room({
    required this.title,
    required this.location,
    required this.price,
    required this.area,
    required this.bedrooms,
    required this.bathrooms,
    required this.hasParking,
    required this.photoCount,
    required this.imageUrl,
    this.isNew = false,
    this.tags = const [],
  });

  String get formattedPrice {
    final buffer = StringBuffer();
    final digits = price.toString();
    for (int i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) buffer.write('.');
      buffer.write(digits[i]);
    }
    return '$buffer đ/tháng';
  }
}

const List<Room> mockRooms = [
  Room(
    title: 'Phòng trọ đầy đủ tiện nghi quận Cầu Giấy',
    location: 'Cầu Giấy, Hà Nội',
    price: 3200000,
    area: 25,
    bedrooms: 1,
    bathrooms: 1,
    hasParking: true,
    photoCount: 8,
    imageUrl: 'https://picsum.photos/seed/room1/600/400',
    isNew: true,
    tags: ['Đầy đủ nội thất', 'Giờ giấc tự do'],
  ),
  Room(
    title: 'Phòng gác lửng mới xây khu vực Tân Bình',
    location: 'Tân Bình, TP. HCM',
    price: 2800000,
    area: 20,
    bedrooms: 1,
    bathrooms: 1,
    hasParking: true,
    photoCount: 6,
    imageUrl: 'https://picsum.photos/seed/room2/600/400',
    tags: ['Điện nước riêng', 'Chỗ để xe'],
  ),
  Room(
    title: 'Phòng trọ thoáng mát gần Đại học Bách Khoa',
    location: 'Hai Bà Trưng, Hà Nội',
    price: 2500000,
    area: 18,
    bedrooms: 1,
    bathrooms: 1,
    hasParking: false,
    photoCount: 7,
    imageUrl: 'https://picsum.photos/seed/room3/600/400',
    tags: ['Gần trường học', 'Giờ giấc tự do'],
  ),
  Room(
    title: 'Phòng cao cấp, ban công rộng quận 7',
    location: 'Quận 7, TP. HCM',
    price: 3800000,
    area: 30,
    bedrooms: 1,
    bathrooms: 1,
    hasParking: true,
    photoCount: 10,
    imageUrl: 'https://picsum.photos/seed/room4/600/400',
    tags: ['Đầy đủ nội thất', 'An ninh 24/7'],
  ),
];
