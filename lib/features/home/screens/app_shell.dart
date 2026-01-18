import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart'; // Ensure this exists (maybe renamed later if needed)
import 'fan_feed_screen.dart';
import 'learning_hub_screen.dart'; // NEW IMPORT
import '../../profile/screens/profile_screen.dart'; // Apne hisab se path set kar lena

class AppShell extends StatefulWidget {
  const AppShell({super.key});
  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int index = 0;

  final pages = const [
    FanFeedScreen(),       // 0: Reels/Discovery (TikTok Style)
    LearningHubScreen(),   // 1: My Learning (Purchased Content)
    // HomeScreen(),       // 2: Option: Creator List (Agar chahiye toh)
    ProfileScreen(),       // 3: User Profile
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: IndexedStack(
        index: index,
        children: pages,
      ),
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.black,
          border: const Border(top: BorderSide(color: Colors.white10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItem(icon: Iconsax.video_play, label: "Feed", active: index == 0, onTap: () => setState(() => index = 0)),
            _NavItem(icon: Iconsax.book_1, label: "Library", active: index == 1, onTap: () => setState(() => index = 1)),
            _NavItem(icon: Iconsax.user, label: "Profile", active: index == 2, onTap: () => setState(() => index = 2)),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;
  const _NavItem({required this.icon, required this.label, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: active ? const Color(0xFF8A2BE2) : Colors.white38, size: 26),
          const SizedBox(height: 4),
          Text(label, style: GoogleFonts.inter(color: active ? Colors.white : Colors.white38, fontSize: 10)),
        ],
      ),
    );
  }
}