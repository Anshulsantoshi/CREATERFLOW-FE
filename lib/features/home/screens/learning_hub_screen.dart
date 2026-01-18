import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:iconsax/iconsax.dart';
import 'package:go_router/go_router.dart'; // Import go_router

class LearningHubScreen extends StatelessWidget {
  const LearningHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("My Learning", style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(icon: const Icon(Iconsax.search_normal, color: Colors.white), onPressed: (){}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // CONTINUE WATCHING
            Text("Continue Watching", style: GoogleFonts.inter(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            Container(
              height: 200, width: double.infinity,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), image: const DecorationImage(image: NetworkImage("https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?w=800"), fit: BoxFit.cover)),
              child: Stack(
                children: [
                  Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.black.withOpacity(0.3))),
                  const Center(child: Icon(Iconsax.play_circle, color: Colors.white, size: 50)),
                  Positioned(bottom: 20, left: 20, right: 20, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("Advanced Cardio Day 4", style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold)), const SizedBox(height: 8), LinearProgressIndicator(value: 0.7, color: const Color(0xFF8A2BE2), backgroundColor: Colors.white24)])),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // MY COLLECTION SECTION HEADER
            _SectionHeader(
                title: "My Collection",
                onViewAllTap: () {
                  // View All Logic
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Opening Full Collection...")));
                }
            ),

            const SizedBox(height: 15),

            SizedBox(
              height: 160,
              child: ListView.builder(
                scrollDirection: Axis.horizontal, itemCount: 4,
                itemBuilder: (context, index) {
                  return FadeInRight(delay: Duration(milliseconds: index * 100), child: _CourseCard(index: index));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onViewAllTap; // Added Callback
  const _SectionHeader({required this.title, required this.onViewAllTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: GoogleFonts.inter(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),

        // Make View All Clickable
        GestureDetector(
          onTap: onViewAllTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            color: Colors.transparent, // Increases touch area
            child: Text("View All", style: GoogleFonts.inter(color: const Color(0xFF8A2BE2), fontSize: 12, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }
}

class _CourseCard extends StatelessWidget {
  final int index; const _CourseCard({required this.index});
  @override
  Widget build(BuildContext context) {
    final images = ["https://images.unsplash.com/photo-1599058917212-d750089bc07e?w=500", "https://images.unsplash.com/photo-1513364776144-60967b0f800f?w=500", "https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?w=500", "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500"];
    return Container(
      width: 120, margin: const EdgeInsets.only(right: 15),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(height: 120, decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), image: DecorationImage(image: NetworkImage(images[index]), fit: BoxFit.cover))),
        const SizedBox(height: 8),
        Text("Course Title ${index+1}", style: GoogleFonts.inter(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
      ]),
    );
  }
}