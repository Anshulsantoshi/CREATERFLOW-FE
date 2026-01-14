import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:iconsax/iconsax.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostDetailScreen extends StatelessWidget {
  final String postId;
  const PostDetailScreen({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    // Logic: 12 aur 13 locked hain (Aman), aur 22, 23 locked hain (Riya)
    final bool isLocked =
        postId == "12" || postId == "13" || postId == "22" || postId == "23";

    return Scaffold(
      backgroundColor: const Color(0xFF050505),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_2, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: Text(
          "Content Detail",
          style: GoogleFonts.outfit(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: -100,
            right: -50,
            child: _GlowOrb(color: Colors.cyan.withOpacity(0.1)),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: isLocked ? _buildLockedState(context) : _buildUnlockedState(),
          ),
        ],
      ),
    );
  }

  Widget _buildLockedState(BuildContext context) {
    return FadeInUp(
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red.withOpacity(0.1),
                    ),
                    child: const Icon(
                      Iconsax.lock5,
                      color: Colors.redAccent,
                      size: 50,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Premium Content",
                    style: GoogleFonts.outfit(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Ye content sirf premium members ke liye hai. Aaj hi subscribe karein aur access payein.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      color: Colors.white54,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 32),
                  _PremiumButton(
                    text: "Unlock with Subscription",
                    onTap: () => context.push('/subscribe/1'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUnlockedState() {
    return FadeIn(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 220,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: const LinearGradient(
                colors: [Color(0xFF151515), Color(0xFF252525)],
              ),
            ),
            child: const Center(
              child: Icon(Iconsax.video_play5, color: Colors.cyan, size: 60),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            "Free Training Basics",
            style: GoogleFonts.outfit(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Is video mein hum basics cover karenge jo har beginner ko pata hona chahiye. Enjoy your free session!",
            style: GoogleFonts.outfit(
              color: Colors.white70,
              fontSize: 16,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _PremiumInput extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool isPass;
  final bool? isPasswordVisible;
  final VoidCallback? onToggle;

  const _PremiumInput({
    required this.controller,
    required this.label,
    required this.icon,
    this.isPass = false,
    this.isPasswordVisible,
    this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: TextField(
            controller: controller,
            obscureText: isPass && !(isPasswordVisible ?? false),
            style: GoogleFonts.outfit(color: Colors.white),
            decoration: InputDecoration(
              labelText: label,
              labelStyle: GoogleFonts.outfit(color: Colors.white38),
              prefixIcon: Icon(icon, color: Colors.cyan, size: 20),
              suffixIcon: isPass
                  ? IconButton(
                      icon: Icon(
                        (isPasswordVisible ?? false)
                            ? Iconsax.eye
                            : Iconsax.eye_slash,
                        color: Colors.white38,
                      ),
                      onPressed: onToggle,
                    )
                  : null,
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
            ),
          ),
        ),
      ),
    );
  }
}

class _PremiumButton extends StatelessWidget {
  final String text;
  final bool isLoading;
  final VoidCallback onTap;

  const _PremiumButton({
    required this.text,
    this.isLoading = false, // ✅ FIX: Default value
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [Color(0xFF00F2FE), Color(0xFF4FACFE)],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.cyan.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : Text(
                  text,
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}

class _SocialCircle extends StatelessWidget {
  final IconData icon;
  final Color color;
  const _SocialCircle({required this.icon, required this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.05),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: FaIcon(icon, color: color, size: 20),
    );
  }
}

class _GlowOrb extends StatelessWidget {
  final Color color;
  const _GlowOrb({required this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 250,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
        child: Container(),
      ),
    );
  }
}

