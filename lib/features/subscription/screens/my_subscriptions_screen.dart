import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:animate_do/animate_do.dart';

class MySubscriptionsScreen extends StatelessWidget {
  const MySubscriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final subs = [
      {"name": "Fitness with Aman", "status": "Active", "renew": "12 days left", "img": "https://images.unsplash.com/photo-1599058917212-d750089bc07e?w=500"},
      {"name": "Math with Raj", "status": "Active", "renew": "28 days left", "img": "https://images.unsplash.com/photo-1523240795612-9a054b0db644?w=500"},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF050505),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            FadeInDown(
              child: Text("Subscriptions", style: GoogleFonts.outfit(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.white)),
            ),
            const SizedBox(height: 24),
            ...subs.asMap().entries.map((e) => FadeInUp(
              delay: Duration(milliseconds: e.key * 100),
              child: _SubscriptionCard(data: e.value),
            )),
          ],
        ),
      ),
    );
  }
}

class _SubscriptionCard extends StatelessWidget {
  final Map<String, String> data;
  const _SubscriptionCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(data["img"]!, height: 70, width: 70, fit: BoxFit.cover),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data["name"]!, style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Iconsax.timer_1, size: 14, color: Colors.cyan),
                    const SizedBox(width: 4),
                    Text(data["renew"]!, style: GoogleFonts.outfit(color: Colors.white38, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(color: Colors.cyan.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
            child: Text("Manage", style: GoogleFonts.outfit(color: Colors.cyan, fontWeight: FontWeight.bold, fontSize: 12)),
          )
        ],
      ),
    );
  }
}