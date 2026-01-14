import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:iconsax/iconsax.dart';
import 'package:go_router/go_router.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050505),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 80),
            // Hero Section
            FadeInDown(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(color: Colors.cyan.withOpacity(0.1), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.cyan.withOpacity(0.3))),
                      child: Text("CREATORS KI APNI DUNIYA", style: GoogleFonts.outfit(color: Colors.cyan, fontWeight: FontWeight.bold, fontSize: 12)),
                    ),
                    const SizedBox(height: 20),
                    Text("Turn Your Content Into\nReal Income 💰", textAlign: TextAlign.center, style: GoogleFonts.outfit(fontSize: 38, fontWeight: FontWeight.w900, color: Colors.white, height: 1.1)),
                    const SizedBox(height: 20),
                    Text("The most creator-friendly platform with only 2% commission and instant UPI payouts.", textAlign: TextAlign.center, style: GoogleFonts.outfit(color: Colors.white54, fontSize: 16)),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 50),

            // Features Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  _MarketingCard(icon: Iconsax.percentage_circle, title: "2% Commission", desc: "Keep 98% of what you earn. No hidden charges."),
                  const SizedBox(height: 16),
                  _MarketingCard(icon: Iconsax.flash_1, title: "Instant UPI Payouts", desc: "Get your money in your bank account within seconds."),
                  const SizedBox(height: 16),
                  _MarketingCard(icon: Iconsax.security_user, title: "Fan Verification", desc: "Elite privacy for your premium content and subscribers."),
                ],
              ),
            ),

            const SizedBox(height: 60),

            // Call to Action
            FadeInUp(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: GestureDetector(
                  onTap: () => context.push('/role-selection'),
                  child: Container(
                    height: 65, width: double.infinity,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), gradient: const LinearGradient(colors: [Color(0xFF7C3AED), Color(0xFF06B6D4)])),
                    child: Center(child: Text("Get Started Now", style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18))),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _MarketingCard extends StatelessWidget {
  final IconData icon; final String title, desc;
  const _MarketingCard({required this.icon, required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.03), borderRadius: BorderRadius.circular(24), border: Border.all(color: Colors.white.withOpacity(0.05))),
      child: Row(
        children: [
          Icon(icon, color: Colors.cyan, size: 30),
          const SizedBox(width: 20),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)), const SizedBox(height: 4), Text(desc, style: GoogleFonts.outfit(color: Colors.white54, fontSize: 14))])),
        ],
      ),
    );
  }
}