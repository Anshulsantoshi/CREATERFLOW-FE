import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:iconsax/iconsax.dart';
import 'upload_screen.dart'; // Ensure this file exists
import 'creator_profile_screen.dart'; // Ensure this file exists

class CreatorDashboardScreen extends StatelessWidget {
  const CreatorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Deep Pure Black
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _CreatePostFAB(onTap: () {
        // Upload Screen Open karega
        Navigator.push(context, MaterialPageRoute(builder: (context) => const UploadScreen()));
      }),
      body: Stack(
        children: [
          // Background Aesthetic Glows
          Positioned(top: -100, right: -50, child: _GlowOrb(color: const Color(0xFF8A2BE2).withOpacity(0.2))), // Electric Purple
          Positioned(bottom: -100, left: -50, child: _GlowOrb(color: Colors.blueAccent.withOpacity(0.15))),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  // Header
                  FadeInDown(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("The Empire",
                                style: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.white)),
                            Text("Welcome back, Anshul",
                                style: GoogleFonts.inter(color: Colors.white54, fontSize: 14)),
                          ],
                        ),
                        // --- PROFILE CLICK ACTION ADDED HERE ---
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const CreatorProfileScreen(creatorId: '1'))
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: const Color(0xFF8A2BE2), width: 2), // Purple Border
                            ),
                            child: const CircleAvatar(
                              radius: 22,
                              backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=11"), // Placeholder
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // --- HERO SECTION: TOTAL EARNINGS ---
                  const _EmpireEarningsCard(),

                  const SizedBox(height: 30),

                  // --- STORAGE METER (GAMIFICATION) ---
                  FadeInUp(delay: const Duration(milliseconds: 200), child: const _StorageMeter()),

                  const SizedBox(height: 40),

                  // --- RECENT ACTIVITY (SALES) ---
                  FadeInLeft(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Recent Sales",
                            style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                        Text("See All",
                            style: GoogleFonts.inter(fontSize: 14, color: const Color(0xFF8A2BE2), fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      final sales = [
                        {"name": "Rahul bought Abs Workout", "earn": "+₹499", "time": "2 mins ago"},
                        {"name": "Sneha bought Diet Plan", "earn": "+₹299", "time": "15 mins ago"},
                        {"name": "Amit bought Kotlin Course", "earn": "+₹1,200", "time": "1 hour ago"},
                        {"name": "Priya bought Lightroom Presets", "earn": "+₹150", "time": "3 hours ago"},
                      ];
                      return FadeInUp(
                        delay: Duration(milliseconds: index * 100),
                        child: _SaleTile(data: sales[index]),
                      );
                    },
                  ),
                  const SizedBox(height: 100), // Space for FAB
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- EMPIRE EARNINGS CARD ---
class _EmpireEarningsCard extends StatelessWidget {
  const _EmpireEarningsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white.withOpacity(0.05), // Glassy
        border: Border.all(color: Colors.white.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(color: const Color(0xFF8A2BE2).withOpacity(0.1), blurRadius: 20, spreadRadius: -5),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total Earnings", style: GoogleFonts.inter(color: Colors.white54, fontSize: 14)),
              const Icon(Iconsax.wallet_3, color: Colors.white, size: 24),
            ],
          ),
          const SizedBox(height: 10),
          Text("₹12,450",
              style: GoogleFonts.inter(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w900)),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.greenAccent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Iconsax.arrow_up_3, color: Colors.greenAccent, size: 14),
                const SizedBox(width: 4),
                Text("+₹1,200 Today 🚀",
                    style: GoogleFonts.inter(color: Colors.greenAccent, fontSize: 12, fontWeight: FontWeight.bold)),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// --- STORAGE METER (GAMIFICATION) ---
class _StorageMeter extends StatelessWidget {
  const _StorageMeter();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
            colors: [const Color(0xFF1A1A1A), Colors.black],
            begin: Alignment.topLeft, end: Alignment.bottomRight
        ),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Storage Used", style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold)),
              Text("1.2 GB / 2 GB", style: GoogleFonts.inter(color: Colors.white54, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 12),
          // Custom Progress Bar
          Stack(
            children: [
              Container(height: 8, width: double.infinity, decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(4))),
              Container(
                height: 8, width: 200, // Dynamic width based on percentage
                decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [Color(0xFF8A2BE2), Colors.blueAccent]),
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [BoxShadow(color: const Color(0xFF8A2BE2).withOpacity(0.5), blurRadius: 10)]
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text("Sell ₹500 more to unlock 1GB space.",
              style: GoogleFonts.inter(color: Colors.white38, fontSize: 12, fontStyle: FontStyle.italic)),
        ],
      ),
    );
  }
}

// --- SALE TILE COMPONENT ---
class _SaleTile extends StatelessWidget {
  final Map<String, String> data;
  const _SaleTile({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF8A2BE2).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Iconsax.bag_tick, color: Color(0xFF8A2BE2), size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data['name']!,
                    style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
                Text(data['time']!,
                    style: GoogleFonts.inter(color: Colors.white38, fontSize: 12)),
              ],
            ),
          ),
          Text(data['earn']!,
              style: GoogleFonts.inter(color: Colors.greenAccent, fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }
}

// --- BIG NEON FAB ---
class _CreatePostFAB extends StatelessWidget {
  final VoidCallback onTap;
  const _CreatePostFAB({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 70, height: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFF8A2BE2), // Electric Purple
          boxShadow: [
            BoxShadow(color: const Color(0xFF8A2BE2).withOpacity(0.6), blurRadius: 25, spreadRadius: 5),
          ],
        ),
        child: const Icon(Iconsax.add, color: Colors.white, size: 32),
      ),
    );
  }
}

class _GlowOrb extends StatelessWidget {
  final Color color;
  const _GlowOrb({required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(width: 300, height: 300, decoration: BoxDecoration(shape: BoxShape.circle, color: color), child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100), child: Container()));
  }
}