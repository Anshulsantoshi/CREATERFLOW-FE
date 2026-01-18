import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:iconsax/iconsax.dart';

import 'payment_modal.dart';

class CourseDetailsScreen extends StatelessWidget {
  const CourseDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // 1. VIDEO HEADER (Sliver)
              SliverAppBar(
                expandedHeight: 300,
                backgroundColor: Colors.black,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network("https://images.unsplash.com/photo-1517836357463-d25dfeac3438?w=800", fit: BoxFit.cover),
                      Container(color: Colors.black.withOpacity(0.4)),
                      const Center(
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white24,
                          child: Icon(Iconsax.play, color: Colors.white, size: 30),
                        ),
                      )
                    ],
                  ),
                ),
                leading: IconButton(
                  icon: const Icon(Iconsax.arrow_left_2, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),

              // 2. DETAILS CONTENT
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeInUp(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("30-Day Shred", style: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.white)),
                            const Icon(Iconsax.bookmark, color: Colors.white, size: 24),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Iconsax.star1, color: Colors.amber, size: 18),
                          const SizedBox(width: 4),
                          Text("4.8 (120 Reviews)", style: GoogleFonts.inter(color: Colors.white70)),
                        ],
                      ),
                      const SizedBox(height: 30),

                      // WHAT YOU GET
                      Text("What you get", style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                      const SizedBox(height: 15),
                      _FeatureRow(icon: Iconsax.video_play, text: "45 Premium HD Videos"),
                      _FeatureRow(icon: Iconsax.document_text, text: "Custom Diet PDF Plan"),
                      _FeatureRow(icon: Iconsax.message_question, text: "Priority Support from Aman"),

                      const SizedBox(height: 30),
                      Text("Description", style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                      const SizedBox(height: 10),
                      Text(
                        "Transform your body in just 30 days with this intensive program designed for home workouts. No equipment needed.",
                        style: GoogleFonts.inter(color: Colors.white54, height: 1.5),
                      ),
                      const SizedBox(height: 100), // Spacing for sticky button
                    ],
                  ),
                ),
              ),
            ],
          ),

          // 3. STICKY BOTTOM BUTTON
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                border: const Border(top: BorderSide(color: Colors.white10)),
              ),
              child: ClipRRect( // Backdrop blur
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Total Price", style: GoogleFonts.inter(color: Colors.white54, fontSize: 12)),
                          Text("₹499", style: GoogleFonts.inter(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900)),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Ensure this function is imported correctly
                            showPaymentModal(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF8A2BE2),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            elevation: 10,
                            shadowColor: const Color(0xFF8A2BE2).withOpacity(0.5),
                          ),
                          child: Text("Buy Now", style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _FeatureRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: Colors.cyan, size: 18),
          ),
          const SizedBox(width: 15),
          Text(text, style: GoogleFonts.inter(color: Colors.white, fontSize: 16)),
        ],
      ),
    );
  }
}