import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:iconsax/iconsax.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = const [
      {"title": "Fitness", "subtitle": "Workouts", "img": "https://images.unsplash.com/photo-1517836357463-d25dfeac3438?w=500&q=80"},
      {"title": "Digital Art", "subtitle": "Sketching", "img": "https://images.unsplash.com/photo-1520697222865-7b8b0bb3f8f5?w=500&q=80"},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF050505),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            FadeInDown(
              child: Text("Explore", 
                style: GoogleFonts.outfit(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.white)),
            ),
            const SizedBox(height: 20),
            
            // Horizontal Categories
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, i) => FadeInRight(
                  delay: Duration(milliseconds: i * 150),
                  child: _CategoryCard(data: categories[i]),
                ),
              ),
            ),

            const SizedBox(height: 30),
            FadeInUp(
              child: Text("🔥 Trending Right Now", 
                style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
            const SizedBox(height: 20),

            _TrendingTile(title: "Creator of the Week", sub: "Top performance", icon: Iconsax.crown_1),
            const SizedBox(height: 15),
            _TrendingTile(title: "Best Tutorials", sub: "Handpicked for you", icon: Iconsax.video_play),
          ],
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final Map<String, String> data;
  const _CategoryCard({required this.data});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        image: DecorationImage(image: NetworkImage(data["img"]!), fit: BoxFit.cover),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26),
          gradient: LinearGradient(colors: [Colors.black.withOpacity(0.8), Colors.transparent], begin: Alignment.bottomCenter, end: Alignment.topCenter),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(data["title"]!, style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
            Text(data["subtitle"]!, style: GoogleFonts.outfit(fontSize: 14, color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}

class _TrendingTile extends StatelessWidget {
  final String title, sub;
  final IconData icon;
  const _TrendingTile({required this.title, required this.sub, required this.icon});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(22), border: Border.all(color: Colors.white.withOpacity(0.05))),
      child: Row(
        children: [
          Container(
            height: 50, width: 50,
            decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF7C3AED), Color(0xFF06B6D4)]), borderRadius: BorderRadius.circular(15)),
            child: Icon(icon, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              Text(sub, style: GoogleFonts.outfit(fontSize: 13, color: Colors.white38)),
            ],
          ),
          const Spacer(),
          const Icon(Iconsax.arrow_right_3, color: Colors.white24, size: 18),
        ],
      ),
    );
  }
}