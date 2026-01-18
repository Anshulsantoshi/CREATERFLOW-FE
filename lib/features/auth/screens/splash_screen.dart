import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:iconsax/iconsax.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // 3 Second baad Landing Page par bhej dega
    Timer(const Duration(seconds: 3), () {
      context.go('/landing'); // Router set karna mat bhulna
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Pure Black
      body: Stack(
        children: [
          // Center Pulsing Logo
          Center(
            child: Pulse(
              infinite: true, // Hamesha dhadkega dil ki tarah
              duration: const Duration(seconds: 2),
              child: Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF7C3AED).withOpacity(0.1),
                    border: Border.all(color: const Color(0xFF7C3AED).withOpacity(0.5), width: 2),
                    boxShadow: [
                      BoxShadow(color: const Color(0xFF7C3AED).withOpacity(0.4), blurRadius: 40, spreadRadius: 10)
                    ]
                ),
                child: const Icon(Iconsax.activity, size: 60, color: Colors.white), // C-F Wave Placeholder
              ),
            ),
          ),

          // Bottom Tagline
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: FadeInUp(
              delay: const Duration(milliseconds: 500),
              child: Column(
                children: [
                  Text("CREATERFLOW",
                      style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 5)),
                  const SizedBox(height: 10),
                  Text("Your Content. Your Wealth.",
                      style: GoogleFonts.outfit(color: Colors.white54, fontSize: 14, letterSpacing: 1)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}