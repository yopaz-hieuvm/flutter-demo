import 'package:flutter/material.dart';
import 'package:flutter_demo/Models/room.dart';

const Color kPrimaryGreen = Color(0xFF16A34A);

class RoomCard extends StatefulWidget {
  final Room room;
  final VoidCallback? onTap;

  const RoomCard({super.key, required this.room, this.onTap});

  @override
  State<RoomCard> createState() => _RoomCardState();
}

class _RoomCardState extends State<RoomCard> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final room = widget.room;
    return InkWell(
      onTap: widget.onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(room),
            Expanded(child: _buildInfo(room)),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(Room room) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        bottomLeft: Radius.circular(16),
      ),
      child: SizedBox(
        width: 130,
        height: 130,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              room.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: const Color(0xFFE5E7EB),
                child: const Icon(Icons.image_outlined,
                    color: Color(0xFF9CA3AF), size: 32),
              ),
            ),
            Positioned(
              left: 8,
              bottom: 8,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.55),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.photo_library_outlined,
                        color: Colors.white, size: 13),
                    const SizedBox(width: 4),
                    Text(
                      '${room.photoCount} ảnh',
                      style: const TextStyle(color: Colors.white, fontSize: 11),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfo(Room room) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (room.isNew) ...[
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: kPrimaryGreen,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'MỚI',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const Spacer(),
              ] else
                const Spacer(),
              GestureDetector(
                onTap: () => setState(() => _isFavorite = !_isFavorite),
                child: Icon(
                  _isFavorite ? Icons.favorite : Icons.favorite_border,
                  size: 20,
                  color: _isFavorite ? Colors.redAccent : const Color(0xFF9CA3AF),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            room.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              height: 1.25,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.location_on_outlined,
                  size: 14, color: Color(0xFF6B7280)),
              const SizedBox(width: 2),
              Expanded(
                child: Text(
                  room.location,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 12, color: Color(0xFF6B7280)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            room.formattedPrice,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: kPrimaryGreen,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              _feature(Icons.crop_square, '${room.area} m²'),
              const SizedBox(width: 10),
              _feature(Icons.bed_outlined, '${room.bedrooms}'),
              const SizedBox(width: 10),
              _feature(Icons.bathtub_outlined, '${room.bathrooms}'),
              const SizedBox(width: 10),
              _feature(Icons.two_wheeler_outlined,
                  room.hasParking ? 'Có' : 'Không'),
            ],
          ),
          if (room.tags.isNotEmpty) ...[
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: room.tags
                  .asMap()
                  .entries
                  .map((e) => _tag(e.value, e.key))
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _feature(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: const Color(0xFF6B7280)),
        const SizedBox(width: 3),
        Text(label,
            style: const TextStyle(fontSize: 11, color: Color(0xFF4B5563))),
      ],
    );
  }

  Widget _tag(String label, int index) {
    const styles = <({Color bg, Color fg})>[
      (bg: Color(0xFFDCFCE7), fg: Color(0xFF15803D)),
      (bg: Color(0xFFEDE9FE), fg: Color(0xFF6D28D9)),
      (bg: Color(0xFFFFEDD5), fg: Color(0xFFC2410C)),
      (bg: Color(0xFFDBEAFE), fg: Color(0xFF1D4ED8)),
    ];
    final style = styles[index % styles.length];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: style.bg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          color: style.fg,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
