import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final creators = const [
    {
      "id": "1",
      "name": "Fitness with Aman",
      "tag": "Gym • Fat Loss",
      "price": "₹299/mo",
      "followers": "12.4k",
      "img": "https://images.unsplash.com/photo-1599058917212-d750089bc07e?w=500"
    },
    {
      "id": "2",
      "name": "Art by Riya",
      "tag": "Sketch • Tutorials",
      "price": "₹199/mo",
      "followers": "9.8k",
      "img": "https://images.unsplash.com/photo-1513364776144-60967b0f800f?w=500"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050505),
      body: Stack(
        children: [
          // Background Depth
          Positioned(top: -100, left: -50, child: _GlowOrb(color: Colors.cyan.withOpacity(0.15))),
          Positioned(bottom: 200, right: -50, child: _GlowOrb(color: Colors.purple.withOpacity(0.1))),
          
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: [
                const SizedBox(height: 20),
                // Header
                FadeInDown(
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Discover", 
                            style: GoogleFonts.outfit(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.white)),
                          Text("Premium creators for you", 
                            style: GoogleFonts.outfit(color: Colors.white38, fontSize: 14)),
                        ],
                      ),
                      const Spacer(),
                      _GlassIconButton(icon: Iconsax.notification, onTap: () {}),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                
                // --- THE LIVE ANIMATED FEATURED CARD ---
                const _EliteAnimatedFeaturedCard(),
                
                const SizedBox(height: 30),
                FadeInLeft(
                  child: Text("Top Creators", 
                    style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
                const SizedBox(height: 15),

                ...creators.asMap().entries.map((entry) {
                  return FadeInUp(
                    delay: Duration(milliseconds: 400 + (entry.key * 100)),
                    child: _CreatorCard(
                      onTap: () => context.push('/creator/${entry.value["id"]}'),
                      data: entry.value,
                    ),
                  );
                }).toList(),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// --- ELITE LIVE ANIMATED CARD COMPONENT ---
class _EliteAnimatedFeaturedCard extends StatefulWidget {
  const _EliteAnimatedFeaturedCard();

  @override
  State<_EliteAnimatedFeaturedCard> createState() => _EliteAnimatedFeaturedCardState();
}

class _EliteAnimatedFeaturedCardState extends State<_EliteAnimatedFeaturedCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
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
          height: 190,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            // Layer 1: Moving Background Gradient
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: const [Color(0xFF6A11CB), Color(0xFF2575FC), Color(0xFF00F2FE)],
              stops: [0.0, 0.3 + (_controller.value * 0.4), 1.0],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF2575FC).withOpacity(0.3),
                blurRadius: 30,
                offset: const Offset(0, 15),
              ),
            ],
            border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: Stack(
              children: [
                // Layer 2: Animated Glass Shine (The "Live" Effect)
                Transform.translate(
                  offset: Offset(_controller.value * 500 - 250, -100),
                  child: Transform.rotate(
                    angle: 0.5,
                    child: Container(
                      width: 100,
                      height: 400,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.0),
                            Colors.white.withOpacity(0.2),
                            Colors.white.withOpacity(0.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                
                // Layer 3: Content
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white24),
                        ),
                        child: Text("TRENDING", 
                          style: GoogleFonts.outfit(fontSize: 10, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 1)),
                      ),
                      const SizedBox(height: 15),
                      Text("Creator of\nthe Week", 
                        style: GoogleFonts.outfit(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.white, height: 1)),
                      const Spacer(),
                      Row(
                        children: [
                          Text("Explore Community", style: GoogleFonts.outfit(fontWeight: FontWeight.bold, color: Colors.white)),
                          const SizedBox(width: 10),
                          const Icon(Iconsax.arrow_right_1, color: Colors.white, size: 20),
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

// --- SUPPORTING WIDGETS ---

class _CreatorCard extends StatelessWidget {
  final Map<String, String> data;
  final VoidCallback onTap;
  const _CreatorCard({required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.04),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                data["img"]!, 
                height: 75, width: 75, fit: BoxFit.cover,
                errorBuilder: (c,e,s) => Container(color: Colors.white10, child: const Icon(Iconsax.image)),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data["name"]!, style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                  Text(data["tag"]!, style: GoogleFonts.outfit(fontSize: 13, color: Colors.white38)),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _SmallChip(text: data["price"]!, icon: Iconsax.lock, color: Colors.cyan),
                      const SizedBox(width: 8),
                      _SmallChip(text: data["followers"]!, icon: Iconsax.user, color: Colors.purpleAccent),
                    ],
                  )
                ],
              ),
            ),
            const Icon(Iconsax.arrow_right_3, color: Colors.white24, size: 18),
          ],
        ),
      ),
    );
  }
}

class _SmallChip extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  const _SmallChip({required this.text, required this.icon, required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(text, style: GoogleFonts.outfit(fontSize: 11, color: color, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class _GlassIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _GlassIconButton({required this.icon, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(18), border: Border.all(color: Colors.white.withOpacity(0.1))),
        child: Icon(icon, color: Colors.white, size: 22),
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