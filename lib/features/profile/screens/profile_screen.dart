import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:animate_do/animate_do.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050505),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            FadeInDown(
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(colors: [Color(0xFF7C3AED), Color(0xFF06B6D4)]),
                  boxShadow: [BoxShadow(color: Colors.cyan.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10))],
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.white24,
                      child: Icon(Iconsax.user, color: Colors.white, size: 30),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Anshul", style: GoogleFonts.outfit(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.white)),
                          Text("Premium Member", style: GoogleFonts.outfit(color: Colors.white70, fontSize: 14)),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(12)),
                      child: Text("PRO", style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            _ProfileTile(icon: Iconsax.setting_2, title: "Account Settings", delay: 100),
            _ProfileTile(icon: Iconsax.card_pos, title: "Billing & Payments", delay: 200),
            _ProfileTile(icon: Iconsax.security_safe, title: "Privacy Policy", delay: 300),
            _ProfileTile(icon: Iconsax.info_circle, title: "Help Support", delay: 400),
            const SizedBox(height: 20),
            _ProfileTile(icon: Iconsax.logout, title: "Logout", color: Colors.redAccent, delay: 500),
          ],
        ),
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final int delay;
  const _ProfileTile({required this.icon, required this.title, this.color = Colors.white, required this.delay});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      delay: Duration(milliseconds: delay),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Row(
          children: [
            Icon(icon, color: color.withOpacity(0.7), size: 22),
            const SizedBox(width: 16),
            Text(title, style: GoogleFonts.outfit(fontSize: 16, color: color, fontWeight: FontWeight.w500)),
            const Spacer(),
            Icon(Iconsax.arrow_right_3, color: Colors.white24, size: 16),
          ],
        ),
      ),
    );
  }
}