import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:animate_do/animate_do.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SubscriptionsScreen extends StatelessWidget {
  final String creatorId;
  const SubscriptionsScreen({super.key, required this.creatorId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050505),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_2, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInLeft(
              child: Text(
                "Choose Your\nPlan 🔥",
                style: GoogleFonts.outfit(
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  height: 1.1,
                ),
              ),
            ),
            const SizedBox(height: 30),

            const _PlanTile(
              title: "Monthly Access",
              price: "₹299",
              sub: "Billed monthly",
              isPopular: false,
            ),

            const SizedBox(height: 16),

            const _PlanTile(
              title: "Quarterly Pro",
              price: "₹799",
              sub: "Save 15% yearly",
              isPopular: true,
            ),

            const SizedBox(height: 16),

            const _PlanTile(
              title: "Lifetime Elite",
              price: "₹2499",
              sub: "Pay once, access forever",
              isPopular: false,
            ),

            const Spacer(),

            FadeInUp(
              child: _PremiumButton(
                text: "Proceed to Checkout",
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Connecting to Razorpay... 💳"),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlanTile extends StatelessWidget {
  final String title, price, sub;
  final bool isPopular;
  const _PlanTile({
    required this.title,
    required this.price,
    required this.sub,
    required this.isPopular,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isPopular
            ? Colors.cyan.withOpacity(0.05)
            : Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isPopular ? Colors.cyan : Colors.white.withOpacity(0.1),
          width: isPopular ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isPopular)
                  Text(
                    "MOST POPULAR",
                    style: GoogleFonts.outfit(
                      color: Colors.cyan,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                Text(
                  title,
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  sub,
                  style: GoogleFonts.outfit(
                    fontSize: 13,
                    color: Colors.white38,
                  ),
                ),
              ],
            ),
          ),
          Text(
            price,
            style: GoogleFonts.outfit(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: Colors.white,
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
    super.key,
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
    this.isLoading = false, // ✅ FIX: Default
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
  const _SocialCircle({
    required this.icon,
    required this.color,
    super.key,
  });

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
