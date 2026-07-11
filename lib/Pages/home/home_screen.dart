import 'package:flutter/material.dart';
import 'package:flutter_demo/Models/room.dart';
import 'package:flutter_demo/Service/auth_service.dart';
import 'package:flutter_demo/Widgets/my_button.dart';
import 'package:flutter_demo/Widgets/room_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? _currentIndex;
  bool? _isLoggingOut;

  AuthService get _authService => AuthService();

  @override
  void reassemble() {
    super.reassemble();
    _currentIndex ??= 0;
    _isLoggingOut ??= false;
  }

  Future<void> _logout() async {
    setState(() => _isLoggingOut = true);
    try {
      await _authService.signOut();
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoggingOut = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        bottom: false,
        child: (_currentIndex ?? 0) == 4 ? _buildAccountTab() : _buildHomeTab(),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildHomeTab() {
    return Stack(
      children: [
        Column(
          children: [
            _buildHeader(),
            _buildSearchBar(),
            const SizedBox(height: 16),
            _buildCategories(),
            const SizedBox(height: 16),
            _buildSortRow(),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                itemCount: mockRooms.length,
                separatorBuilder: (_, __) => const SizedBox(height: 14),
                itemBuilder: (context, index) =>
                    RoomCard(room: mockRooms[index]),
              ),
            ),
          ],
        ),
        Positioned(
          right: 16,
          bottom: 16,
          child: _buildMapButton(),
        ),
      ],
    );
  }

  Widget _buildAccountTab() {
    final email = _authService.currentUserEmail ?? 'Không có email';

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tài khoản',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
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
            child: Column(
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: const BoxDecoration(
                    color: Color(0xFFDCFCE7),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 40,
                    color: kPrimaryGreen,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Email đăng nhập',
                  style: TextStyle(fontSize: 13, color: Color(0xFF6B7280)),
                ),
                const SizedBox(height: 4),
                Text(
                  email,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF111827),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          if (_isLoggingOut ?? false)
            const Center(child: CircularProgressIndicator())
          else
            SizedBox(
              width: double.infinity,
              child: MyButton(
                onTap: _logout,
                buttontext: 'Đăng xuất',
                color: Colors.redAccent,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Danh sách phòng trọ',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF111827),
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Tìm phòng phù hợp với bạn',
                  style: TextStyle(fontSize: 13, color: Color(0xFF6B7280)),
                ),
              ],
            ),
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(Icons.notifications_none_rounded,
                  size: 28, color: Color(0xFF374151)),
              Positioned(
                right: 2,
                top: 2,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Color(0xFF9CA3AF), size: 22),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        isCollapsed: true,
                        border: InputBorder.none,
                        hintText: 'Tìm theo khu vực, tên phòng, địa chỉ...',
                        hintStyle:
                            TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: const Icon(Icons.tune, color: Color(0xFF374151)),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    final categories = [
      (_Cat('Gần tôi', Icons.location_on, const Color(0xFF16A34A),
          const Color(0xFFDCFCE7))),
      (_Cat('Chung cư mini', Icons.apartment, const Color(0xFF7C3AED),
          const Color(0xFFEDE9FE))),
      (_Cat('Điện nước riêng', Icons.bolt, const Color(0xFFEA580C),
          const Color(0xFFFFEDD5))),
      (_Cat('Có chỗ để xe', Icons.two_wheeler, const Color(0xFF2563EB),
          const Color(0xFFDBEAFE))),
      (_Cat('Dưới 3 triệu', Icons.sell, const Color(0xFFDB2777),
          const Color(0xFFFCE7F3))),
    ];
    return SizedBox(
      height: 84,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final cat = categories[index];
          return SizedBox(
            width: 64,
            child: Column(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: cat.bg,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(cat.icon, color: cat.color, size: 24),
                ),
                const SizedBox(height: 6),
                Text(
                  cat.label,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: const TextStyle(
                      fontSize: 11, color: Color(0xFF374151), height: 1.1),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSortRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              Icon(Icons.sort, size: 18, color: Color(0xFF374151)),
              SizedBox(width: 6),
              Text('Mới nhất',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF374151))),
              Icon(Icons.keyboard_arrow_down, size: 20, color: Color(0xFF374151)),
            ],
          ),
          Row(
            children: const [
              Text('Bộ lọc',
                  style: TextStyle(fontSize: 14, color: Color(0xFF374151))),
              SizedBox(width: 6),
              Icon(Icons.filter_list, size: 18, color: Color(0xFF374151)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMapButton() {
    return Material(
      color: kPrimaryGreen,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: () {},
        child: Container(
          width: 60,
          height: 60,
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.map_outlined, color: Colors.white, size: 22),
              SizedBox(height: 2),
              Text('Bản đồ',
                  style: TextStyle(color: Colors.white, fontSize: 10)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    final items = [
      (_NavItem('Trang chủ', Icons.home)),
      (_NavItem('Tin nhắn', Icons.chat_bubble_outline)),
      (_NavItem('Đăng tin', Icons.add)),
      (_NavItem('Yêu thích', Icons.favorite_border)),
      (_NavItem('Tài khoản', Icons.person_outline)),
    ];
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (index) {
              final item = items[index];
              final isCenter = index == 2;
              final isActive = (_currentIndex ?? 0) == index;
              if (isCenter) {
                return GestureDetector(
                  onTap: () => setState(() => _currentIndex = index),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: const BoxDecoration(
                          color: kPrimaryGreen,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.add,
                            color: Colors.white, size: 26),
                      ),
                      const SizedBox(height: 2),
                      Text(item.label,
                          style: const TextStyle(
                              fontSize: 10, color: kPrimaryGreen)),
                    ],
                  ),
                );
              }
              return GestureDetector(
                onTap: () => setState(() => _currentIndex = index),
                behavior: HitTestBehavior.opaque,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(item.icon,
                        size: 24,
                        color: isActive
                            ? kPrimaryGreen
                            : const Color(0xFF9CA3AF)),
                    const SizedBox(height: 4),
                    Text(item.label,
                        style: TextStyle(
                            fontSize: 10,
                            color: isActive
                                ? kPrimaryGreen
                                : const Color(0xFF9CA3AF))),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _Cat {
  final String label;
  final IconData icon;
  final Color color;
  final Color bg;
  const _Cat(this.label, this.icon, this.color, this.bg);
}

class _NavItem {
  final String label;
  final IconData icon;
  const _NavItem(this.label, this.icon);
}
