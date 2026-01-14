// lib/features/home/screens/app_shell.dart mein ye badal:

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'home_screen.dart';
import 'explore_screen.dart';
// Sahi paths:
import '../../profile/screens/profile_screen.dart'; 
import '../../subscription/screens/my_subscriptions_screen.dart';
import 'fan_feed_screen.dart';
class AppShell extends StatefulWidget {
  const AppShell({super.key});
  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int index = 0;

 final pages = const [
  FanFeedScreen(),       // Pehla Tab ab Feed dikhayega (Instagram style)
  HomeScreen(),          // Doosra Tab 'Discover' (Creators list) dikhayega
  ExploreScreen(), 
  ProfileScreen(),
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050505),
      body: IndexedStack( // IndexedStack use karne se page state save rehti hai
        index: index,
        children: pages,
      ),
      bottomNavigationBar: Container(
        height: 85,
        margin: const EdgeInsets.fromLTRB(24, 0, 24, 30),
        decoration: BoxDecoration(
          color: const Color(0xFF151515),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5), 
              blurRadius: 20, 
              offset: const Offset(0, 10)
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItem(icon: Iconsax.home_1, active: index == 0, onTap: () => setState(() => index = 0)),
            _NavItem(icon: Iconsax.discover_1, active: index == 1, onTap: () => setState(() => index = 1)),
            _NavItem(icon: Iconsax.medal_star, active: index == 2, onTap: () => setState(() => index = 2)),
            _NavItem(icon: Iconsax.user, active: index == 3, onTap: () => setState(() => index = 3)),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final bool active;
  final VoidCallback onTap;
  const _NavItem({required this.icon, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon, 
            color: active ? Colors.cyan : Colors.white38, 
            size: 26
          ),
          const SizedBox(height: 4),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 4, 
            width: active ? 4 : 0,
            decoration: BoxDecoration(
              color: Colors.cyan, 
              shape: BoxShape.circle, 
              boxShadow: [
                BoxShadow(color: Colors.cyan.withOpacity(0.5), blurRadius: 10)
              ]
            ),
          ),
        ],
      ),
    );
  }
}