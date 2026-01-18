import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:iconsax/iconsax.dart';

class MyCollectionScreen extends StatelessWidget {
  const MyCollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock Data
    final courses = List.generate(12, (index) => "Course ${index + 1}");

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_2, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("My Collection", style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 items per row
          childAspectRatio: 0.75, // Height vs Width ratio
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: courses.length,
        itemBuilder: (context, index) {
          return FadeInUp(
            delay: Duration(milliseconds: index * 50),
            child: _CollectionCard(index: index),
          );
        },
      ),
    );
  }
}

class _CollectionCard extends StatelessWidget {
  final int index;
  const _CollectionCard({required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                image: DecorationImage(
                  image: NetworkImage("https://source.unsplash.com/random/300x300?fitness,gym&sig=$index"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Container(color: Colors.black.withOpacity(0.2)),
                  const Center(child: Icon(Iconsax.play_circle, color: Colors.white, size: 40)),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Course Title ${index + 1}",
                    style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                    maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Text("Completed: 40%", style: GoogleFonts.inter(color: Colors.white54, fontSize: 12)),
                const SizedBox(height: 8),
                LinearProgressIndicator(value: 0.4, color: const Color(0xFF8A2BE2), backgroundColor: Colors.white10, minHeight: 4, borderRadius: BorderRadius.circular(2)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}