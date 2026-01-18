import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:iconsax/iconsax.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});
  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  String selectedRole = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050505),
      body: Stack(
        children: [
          Positioned(top: -100, right: -50, child: _GlowOrb(color: Colors.purple.withOpacity(0.2))),
          Positioned(bottom: -100, left: -50, child: _GlowOrb(color: Colors.cyan.withOpacity(0.2))),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  FadeInDown(child: Text("Welcome to\nCREATERFLOW", style: GoogleFonts.outfit(fontSize: 40, fontWeight: FontWeight.w900, color: Colors.white, height: 1.1))),
                  const SizedBox(height: 50),

                  // CREATOR CARD (Purple)
                  _RoleCard(
                      title: "I'm a Creator",
                      subtitle: "Monetize content & grow community.",
                      icon: Iconsax.video_tick,
                      color: const Color(0xFF7C3AED), // Explicit Purple
                      isSelected: selectedRole == "creator",
                      onTap: () => setState(() => selectedRole = "creator")
                  ),

                  const SizedBox(height: 20),

                  // FAN CARD (Cyan/Blue)
                  _RoleCard(
                      title: "I'm a Fan",
                      subtitle: "Access exclusive creator content.",
                      icon: Iconsax.heart5,
                      color: const Color(0xFF06B6D4), // Explicit Cyan
                      isSelected: selectedRole == "user",
                      onTap: () => setState(() => selectedRole = "user")
                  ),

                  const Spacer(),
                  FadeInUp(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: GestureDetector(
                        onTap: selectedRole.isEmpty ? null : () => context.push('/login/$selectedRole'),
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 300),
                          opacity: selectedRole.isEmpty ? 0.3 : 1.0,
                          child: Container(
                            height: 65, width: double.infinity,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(32), gradient: const LinearGradient(colors: [Color(0xFF00F2FE), Color(0xFF4FACFE)]), boxShadow: [BoxShadow(color: const Color(0xFF00F2FE).withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10))]),
                            child: Center(child: Text("Continue", style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white))),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final String title, subtitle; final IconData icon; final Color color; final bool isSelected; final VoidCallback onTap;
  const _RoleCard({required this.title, required this.subtitle, required this.icon, required this.color, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          // Background: Thoda colored tint jab select ho
            color: isSelected ? color.withOpacity(0.15) : Colors.white.withOpacity(0.03),
            borderRadius: BorderRadius.circular(30),
            // Border: Select hone par solid color, nahi toh halka transparent
            border: Border.all(
                color: isSelected ? color : Colors.white.withOpacity(0.1),
                width: isSelected ? 2 : 1
            ),
            boxShadow: isSelected ? [BoxShadow(color: color.withOpacity(0.2), blurRadius: 20)] : []
        ),
        child: Row(
            children: [
              Container(
                  height: 60, width: 60,
                  decoration: BoxDecoration(
                      color: isSelected ? color : Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(20)
                  ),
                  // Icon: Select hone par White, nahi toh uska Color (Purple/Blue)
                  child: Icon(icon, color: isSelected ? Colors.white : color, size: 30)
              ),
              const SizedBox(width: 20),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                        Text(subtitle, style: GoogleFonts.outfit(fontSize: 14, color: Colors.white54))
                      ]
                  )
              )
            ]
        ),
      ),
    );
  }
}

class _GlowOrb extends StatelessWidget {
  final Color color; const _GlowOrb({required this.color});
  @override
  Widget build(BuildContext context) { return Container(width: 400, height: 400, decoration: BoxDecoration(shape: BoxShape.circle, color: color), child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100), child: Container())); }
}