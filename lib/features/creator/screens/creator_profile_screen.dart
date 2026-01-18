import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:iconsax/iconsax.dart';

class CreatorProfileScreen extends StatelessWidget {
  final String creatorId; // Pass ID appropriately
  const CreatorProfileScreen({super.key, required this.creatorId});

  @override
  Widget build(BuildContext context) {
    // Grid Data Mock
    final posts = List.generate(6, (index) => {
      "title": "Course ${index + 1}",
      "price": "₹${(index + 1) * 200}",
      "image": "https://source.unsplash.com/random/300x300?gym,fitness&sig=$index"
    });

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text("My Store", style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Iconsax.setting_2, color: Colors.white)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // PROFILE INFO
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 45,
                    backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=11"),
                  ),
                  const SizedBox(height: 12),
                  Text("Anshul Santoshi", style: GoogleFonts.inter(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900)),
                  Text("@anshul_dev", style: GoogleFonts.inter(color: Colors.white54)),
                  const SizedBox(height: 20),

                  // SHARE STORE BUTTON
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [const Color(0xFF8A2BE2).withOpacity(0.2), Colors.black]),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: const Color(0xFF8A2BE2)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Iconsax.share, color: Colors.white, size: 18),
                        const SizedBox(width: 8),
                        Text("Share Store to Story", style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 30),
            const Divider(color: Colors.white10),
            const SizedBox(height: 20),

            // GRID VIEW OF COURSES
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return _GridItem(data: posts[index]);
                },
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

class _GridItem extends StatelessWidget {
  final Map data;
  const _GridItem({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                color: Colors.grey.shade900, // Placeholder for image
              ),
              child: const Center(child: Icon(Iconsax.image, color: Colors.white24)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data['title'], style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold)),
                Text(data['price'], style: GoogleFonts.inter(color: const Color(0xFF8A2BE2), fontWeight: FontWeight.w900)),
              ],
            ),
          )
        ],
      ),
    );
  }
}