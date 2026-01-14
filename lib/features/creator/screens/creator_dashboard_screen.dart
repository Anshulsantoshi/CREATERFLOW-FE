import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:iconsax/iconsax.dart';

class CreatorDashboardScreen extends StatelessWidget {
  const CreatorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050505),
      floatingActionButton: _CreatePostFAB(onTap: () {}),
      body: Stack(
        children: [
          // Background Aesthetic Glows
          Positioned(top: -100, right: -50, child: _GlowOrb(color: Colors.purple.withOpacity(0.15))),
          Positioned(bottom: -100, left: -50, child: _GlowOrb(color: Colors.cyan.withOpacity(0.1))),

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
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Dashboard", 
                              style: GoogleFonts.outfit(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.white)),
                            Text("Your performance this month", 
                              style: GoogleFonts.outfit(color: Colors.white38, fontSize: 14)),
                          ],
                        ),
                        const Spacer(),
                        const CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white10,
                          child: Icon(Iconsax.user, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // --- ANIMATED EARNINGS CARD ---
                  const _AnimatedEarningsCard(),

                  const SizedBox(height: 30),
                  
                  // Quick Stats Grid
                  Row(
                    children: [
                      Expanded(child: _StatCard(title: "New Fans", value: "+124", icon: Iconsax.user_add, color: Colors.cyan)),
                      const SizedBox(width: 16),
                      Expanded(child: _StatCard(title: "Views", value: "45.2k", icon: Iconsax.eye, color: Colors.purpleAccent)),
                    ],
                  ),

                  const SizedBox(height: 40),

                  // Recent Subscribers Section
                  FadeInLeft(
                    child: Text("Recent Subscribers", 
                      style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                  const SizedBox(height: 20),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      final names = ["Rahul S.", "Sneha W.", "Amit K.", "Priya M."];
                      return FadeInUp(
                        delay: Duration(milliseconds: index * 100),
                        child: _SubscriberTile(name: names[index], date: "Today, 2:40 PM"),
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

// --- LIVE ANIMATED EARNINGS CARD ---
class _AnimatedEarningsCard extends StatefulWidget {
  const _AnimatedEarningsCard();

  @override
  State<_AnimatedEarningsCard> createState() => _AnimatedEarningsCardState();
}

class _AnimatedEarningsCardState extends State<_AnimatedEarningsCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 4))..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: const [Color(0xFF1A1A1A), Color(0xFF0D0D0D)],
            ),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 20)],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: Stack(
              children: [
                // Animated Liquid Background Effect
                Positioned(
                  right: -50, top: -50,
                  child: Container(
                    width: 200, height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [const Color(0xFF00F2FE).withOpacity(0.15 * _controller.value), Colors.transparent],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Total Earnings", 
                        style: GoogleFonts.outfit(color: Colors.white54, fontSize: 16, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 8),
                      Text("₹45,280.00", 
                        style: GoogleFonts.outfit(color: Colors.white, fontSize: 42, fontWeight: FontWeight.w900, letterSpacing: -1)),
                      const Spacer(),
                      Row(
                        children: [
                          const Icon(Iconsax.arrow_up_3, color: Colors.greenAccent, size: 18),
                          const SizedBox(width: 4),
                          Text("12% since last month", 
                            style: GoogleFonts.outfit(color: Colors.greenAccent, fontSize: 14, fontWeight: FontWeight.bold)),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// --- STAT CARD COMPONENT ---
class _StatCard extends StatelessWidget {
  final String title, value;
  final IconData icon;
  final Color color;
  const _StatCard({required this.title, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(14)),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 16),
          Text(value, style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.white)),
          Text(title, style: GoogleFonts.outfit(fontSize: 13, color: Colors.white38)),
        ],
      ),
    );
  }
}

// --- SUBSCRIBER TILE COMPONENT ---
class _SubscriberTile extends StatelessWidget {
  final String name, date;
  const _SubscriberTile({required this.name, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white.withOpacity(0.05),
            child: Text(name[0], style: const TextStyle(color: Colors.cyan)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                Text(date, style: GoogleFonts.outfit(color: Colors.white38, fontSize: 12)),
              ],
            ),
          ),
          Text("₹299", style: GoogleFonts.outfit(color: Colors.cyan, fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }
}

// --- STYLISH FAB ---
class _CreatePostFAB extends StatelessWidget {
  final VoidCallback onTap;
  const _CreatePostFAB({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return FadeInRight(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: const LinearGradient(colors: [Color(0xFF7C3AED), Color(0xFF06B6D4)]),
            boxShadow: [BoxShadow(color: Colors.purple.withOpacity(0.4), blurRadius: 20, offset: const Offset(0, 8))],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Iconsax.add_square, color: Colors.white, size: 24),
              const SizedBox(width: 12),
              Text("Create Post", style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}

class _GlowOrb extends StatelessWidget {
  final Color color;
  const _GlowOrb({required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(width: 350, height: 350, decoration: BoxDecoration(shape: BoxShape.circle, color: color), child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100), child: Container()));
  }
}