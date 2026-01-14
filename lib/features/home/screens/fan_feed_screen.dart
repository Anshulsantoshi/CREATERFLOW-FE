
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:iconsax/iconsax.dart';
import 'package:go_router/go_router.dart';

class FanFeedScreen extends StatelessWidget {
  const FanFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock Data for the Feed
    final posts = [
      {
        "creator": "Fitness with Aman",
        "avatar": "https://images.unsplash.com/photo-1599058917212-d750089bc07e?w=200",
        "image": "https://images.unsplash.com/photo-1517836357463-d25dfeac3438?w=800",
        "caption": "Pehla workout session free hai dosto! Dekho aur seekho. 💪",
        "isPremium": false,
        "price": "0"
      },
      {
        "creator": "Art by Riya",
        "avatar": "https://images.unsplash.com/photo-1513364776144-60967b0f800f?w=200",
        "image": "https://images.unsplash.com/photo-1513364776144-60967b0f800f?w=800",
        "caption": "My secret portrait techniques. Exclusive for Pro members only. 🎨",
        "isPremium": true,
        "price": "199"
      },
      {
        "creator": "Tech with Karan",
        "avatar": "https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?w=200",
        "image": "https://images.unsplash.com/photo-1526374965328-7f61d4dc18c5?w=800",
        "caption": "Next-level Flutter UI secrets revealed in this premium post.",
        "isPremium": true,
        "price": "499"
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF050505),
      body: ListView.builder(
        itemCount: posts.length,
        // Bottom padding ensures the last post isn't hidden behind the Nav Bar
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 120), 
        itemBuilder: (context, index) {
          return FadeInUp(
            duration: const Duration(milliseconds: 500),
            delay: Duration(milliseconds: index * 150),
            child: _FeedPostCard(post: posts[index]),
          );
        },
      ),
    );
  }
}

class _FeedPostCard extends StatelessWidget {
  final Map<String, dynamic> post;
  const _FeedPostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    bool isPremium = post['isPremium'];

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white.withOpacity(0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // Prevents unnecessary stretching
        children: [
          // --- POST HEADER ---
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.white10,
                  backgroundImage: NetworkImage(post['avatar']),
                ),
                const SizedBox(width: 12),
                Text(
                  post['creator'], 
                  style: GoogleFonts.outfit(
                    color: Colors.white, 
                    fontWeight: FontWeight.bold, 
                    fontSize: 15
                  )
                ),
                const Spacer(),
                const Icon(Iconsax.more, color: Colors.white38, size: 18),
              ],
            ),
          ),
          
          // --- IMAGE SECTION (SIZE ADJUSTED) ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Stack(
                children: [
                  AspectRatio(
                    // Adjusted from 1.0 (Square) to 1.3 (Slightly wider/smaller height)
                    aspectRatio: 1.3, 
                    child: Image.network(
                      post['image'], 
                      fit: BoxFit.cover,
                      // Error handling for dead links like in Riya's case
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.white.withOpacity(0.05),
                        child: const Icon(Iconsax.image, color: Colors.white24, size: 30),
                      ),
                    ),
                  ),
                  
                  // --- PREMIUM PARDA (BLUR OVERLAY) ---
                  if (isPremium)
                    Positioned.fill(
                      child: ClipRRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                          child: Container(
                            color: Colors.black.withOpacity(0.45),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Iconsax.lock5, color: Colors.white, size: 40),
                                const SizedBox(height: 12),
                                ElevatedButton(
                                  onPressed: () => context.push('/subscribe/1'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.cyan,
                                    foregroundColor: Colors.black,
                                    elevation: 10,
                                    shadowColor: Colors.cyan.withOpacity(0.4),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  ),
                                  child: Text(
                                    "Unlock for ₹${post['price']}", 
                                    style: GoogleFonts.outfit(fontWeight: FontWeight.w900, fontSize: 13)
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          // --- ACTION BUTTONS (LIKE, COMMENT, SEND) ---
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
            child: Row(
              children: [
                const Icon(Iconsax.heart, color: Colors.white, size: 22),
                const SizedBox(width: 18),
                const Icon(Iconsax.message, color: Colors.white, size: 22),
                const SizedBox(width: 18),
                const Icon(Iconsax.send_1, color: Colors.white, size: 22),
                const Spacer(),
                const Icon(Iconsax.archive_1, color: Colors.white, size: 22),
              ],
            ),
          ),

          // --- CAPTION SECTION ---
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "${post['creator']} ", 
                    style: GoogleFonts.outfit(fontWeight: FontWeight.w900, color: Colors.white, fontSize: 14)
                  ),
                  TextSpan(
                    text: post['caption'], 
                    style: GoogleFonts.outfit(color: Colors.white70, fontWeight: FontWeight.w300, fontSize: 13)
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}