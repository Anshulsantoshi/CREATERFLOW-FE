import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:iconsax/iconsax.dart';

class CreatorProfileScreen extends StatelessWidget {
  final String creatorId;
  const CreatorProfileScreen({super.key, required this.creatorId});

  @override
  Widget build(BuildContext context) {
    // --- MOCK DATA MAP ---
    // Asali app mein ye data API se aayega, abhi ke liye hum id ke hisaab se content badlenge
    final Map<String, dynamic> creatorData = {
      "1": {
        "name": "Fitness with Aman",
        "username": "@aman_fitness",
        "tag": "Gym Trainer",
        "followers": "12.4k",
        "subscribers": "1.2k",
        "posts_count": "48",
        "posts": [
          {"id": "11", "title": "Free Workout Tips", "locked": false, "date": "2 hours ago"},
          {"id": "12", "title": "Premium Diet Plan PDF", "locked": true, "date": "1 day ago"},
          {"id": "13", "title": "Premium Video Session", "locked": true, "date": "3 days ago"},
        ]
      },
      "2": {
        "name": "Art by Riya",
        "username": "@riya_art",
        "tag": "Sketch Artist",
        "followers": "9.8k",
        "subscribers": "850",
        "posts_count": "32",
        "posts": [
          {"id": "21", "title": "Basic Sketching 101", "locked": false, "date": "5 hours ago"},
          {"id": "22", "title": "Portrait Masterclass", "locked": true, "date": "2 days ago"},
          {"id": "23", "title": "Procreate Brush Set", "locked": true, "date": "5 days ago"},
        ]
      }
    };

    // Current creator ka data nikalna, agar id nahi mili toh Aman ka dikhana (fallback)
    final currentCreator = creatorData[creatorId] ?? creatorData["1"];
    final List posts = currentCreator["posts"];

    return Scaffold(
      backgroundColor: const Color(0xFF050505),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_2, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: Stack(
        children: [
          Positioned(top: -50, left: -50, child: _GlowOrb(color: Colors.purple.withOpacity(0.2))),
          Positioned(top: 200, right: -50, child: _GlowOrb(color: Colors.cyan.withOpacity(0.15))),

          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 100),
                
                // --- PROFILE HEADER SECTION ---
                FadeInDown(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(colors: [Colors.cyan, Colors.purpleAccent]),
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey.shade900,
                          child: const Icon(Iconsax.user, size: 50, color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        currentCreator["name"], // Dynamic Name
                        style: GoogleFonts.outfit(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.white),
                      ),
                      Text(
                        "${currentCreator["username"]} • ${currentCreator["tag"]}", // Dynamic Tag
                        style: GoogleFonts.outfit(fontSize: 16, color: Colors.white54, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // --- STATS ROW ---
                FadeInUp(
                  delay: const Duration(milliseconds: 200),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildStat(currentCreator["followers"], "Followers"),
                      _buildDivider(),
                      _buildStat(currentCreator["posts_count"], "Posts"),
                      _buildDivider(),
                      _buildStat(currentCreator["subscribers"], "Subscribers"),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                FadeInUp(
                  delay: const Duration(milliseconds: 300),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: _PremiumPillButton(
                      text: "Subscribe to ${currentCreator["name"].split(' ')[0]}",
                      onTap: () => context.push('/subscribe/$creatorId'),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // --- POSTS SECTION ---
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeInLeft(
                        child: Text("Exclusive Content", style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                      ),
                      const SizedBox(height: 20),
                      
                      ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          final p = posts[index];
                          return FadeInUp(
                            delay: Duration(milliseconds: 400 + (index * 100)),
                            child: _PostCard(
                              title: p["title"],
                              date: p["date"],
                              isLocked: p["locked"],
                              onTap: () => context.push('/post/${p["id"]}'),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Helper Widgets ---
  Widget _buildStat(String value, String label) {
    return Column(
      children: [
        Text(value, style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
        Text(label, style: GoogleFonts.outfit(fontSize: 14, color: Colors.white38)),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(height: 30, width: 1, margin: const EdgeInsets.symmetric(horizontal: 25), color: Colors.white10);
  }
}

// --- Card Widgets (Same as before but kept for copy-paste) ---
class _PostCard extends StatelessWidget {
  final String title, date;
  final bool isLocked;
  final VoidCallback onTap;
  const _PostCard({required this.title, required this.date, required this.isLocked, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: InkWell(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(24), border: Border.all(color: Colors.white.withOpacity(0.1))),
              child: Row(
                children: [
                  Container(
                    height: 50, width: 50,
                    decoration: BoxDecoration(color: isLocked ? Colors.red.withOpacity(0.1) : Colors.cyan.withOpacity(0.1), borderRadius: BorderRadius.circular(15)),
                    child: Icon(isLocked ? Iconsax.lock_1 : Iconsax.play, color: isLocked ? Colors.redAccent : Colors.cyan),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                        Text(date, style: GoogleFonts.outfit(fontSize: 12, color: Colors.white38)),
                      ],
                    ),
                  ),
                  const Icon(Iconsax.arrow_right_3, color: Colors.white24, size: 18),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PremiumPillButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const _PremiumPillButton({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(28), gradient: const LinearGradient(colors: [Color(0xFF00F2FE), Color(0xFF4FACFE)]), boxShadow: [BoxShadow(color: Colors.cyan.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 8))]),
        child: Center(child: Text(text, style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white))),
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