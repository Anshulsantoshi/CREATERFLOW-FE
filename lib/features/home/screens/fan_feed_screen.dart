import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:animate_do/animate_do.dart';
import 'course_detail_screen.dart'; // Ensure import

class FanFeedScreen extends StatelessWidget {
  const FanFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock Data for Reels
    final reels = [
      {
        "title": "30-Day Shred Transformation",
        "creator": "Fitness with Aman",
        "price": "499",
        "image": "https://images.unsplash.com/photo-1517836357463-d25dfeac3438?w=800&q=80",
        "tag": "Fitness"
      },
      {
        "title": "Master Procreate in 1 Week",
        "creator": "Art by Riya",
        "price": "299",
        "image": "https://images.unsplash.com/photo-1513364776144-60967b0f800f?w=800&q=80",
        "tag": "Art"
      },
      {
        "title": "Cinematic Editing Secrets",
        "creator": "Rahul Edits",
        "price": "999",
        "image": "https://images.unsplash.com/photo-1536240478700-b869070f9279?w=800&q=80",
        "tag": "Photography"
      },
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        scrollDirection: Axis.vertical, // TikTok Style
        itemCount: reels.length,
        itemBuilder: (context, index) {
          return _ReelItem(data: reels[index]);
        },
      ),
    );
  }
}

class _ReelItem extends StatelessWidget {
  final Map<String, String> data;
  const _ReelItem({required this.data});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // 1. BACKGROUND IMAGE (Simulating Video)
        Image.network(
          data['image']!,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(child: CircularProgressIndicator(color: Color(0xFF8A2BE2)));
          },
        ),

        // 2. GRADIENT OVERLAY (Readability ke liye)
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.3),
                Colors.transparent,
                Colors.black.withOpacity(0.9), // Bottom dark for text
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
        ),

        // 3. CONTENT OVERLAY
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tag
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: Text(
                    data['tag']!,
                    style: GoogleFonts.inter(color: Colors.white, fontSize: 12),
                  ),
                ),
                const SizedBox(height: 10),

                // Title & Creator
                Text(
                  data['title']!,
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      height: 1.1
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const CircleAvatar(radius: 10, backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=12")),
                    const SizedBox(width: 8),
                    Text(
                      data['creator']!,
                      style: GoogleFonts.inter(color: Colors.white70, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 25),

                // 4. CTA BUTTON (Impulse Buy) & ACTIONS
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // Navigate to Product Page
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const CourseDetailsScreen()));
                        },
                        child: Container(
                          height: 55,
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(colors: [Color(0xFF8A2BE2), Color(0xFF00B4DB)]),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(color: const Color(0xFF8A2BE2).withOpacity(0.5), blurRadius: 20, offset: const Offset(0, 5))
                              ]
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Iconsax.unlock, color: Colors.white, size: 20),
                              const SizedBox(width: 10),
                              Text(
                                "Unlock Full Course @ ₹${data['price']}",
                                style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    // Like/Share Column
                    Column(
                      children: [
                        _SideAction(icon: Iconsax.heart, label: "1.2k"),
                        const SizedBox(height: 15),
                        _SideAction(icon: Iconsax.share, label: "Share"),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 40), // Bottom TabBar space
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SideAction extends StatelessWidget {
  final IconData icon;
  final String label;
  const _SideAction({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withOpacity(0.1)),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
        const SizedBox(height: 4),
        Text(label, style: GoogleFonts.inter(color: Colors.white, fontSize: 10)),
      ],
    );
  }
}