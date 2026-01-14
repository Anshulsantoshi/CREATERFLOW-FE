import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:iconsax/iconsax.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final name = TextEditingController();
  final email = TextEditingController();
  final pass = TextEditingController();
  bool _isLoading = false;
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050505),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_2, color: Colors.white),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/login'); // Safe fallback
            }
          },
        ),
      ),
      body: Stack(
        children: [
          Positioned(top: 100, left: -50, child: _GlowOrb(color: Colors.cyan.withOpacity(0.15))),
          
          SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInLeft(
                  child: Text(
                    "Join the\nFuture.",
                    style: GoogleFonts.outfit(
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      height: 1.1,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                FadeInUp(child: _PremiumInput(controller: name, label: "Full Name", icon: Iconsax.user)),
                const SizedBox(height: 20),
                FadeInUp(delay: const Duration(milliseconds: 100), child: _PremiumInput(controller: email, label: "Email Address", icon: Iconsax.sms)),
                const SizedBox(height: 20),
                FadeInUp(
                  delay: const Duration(milliseconds: 200), 
                  child: _PremiumInput(
                    controller: pass, 
                    label: "Password", 
                    icon: Iconsax.lock, 
                    isPass: true,
                    isPasswordVisible: _isPasswordVisible,
                    onToggle: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                  )
                ),
                const SizedBox(height: 50),
                FadeInUp(
                  delay: const Duration(milliseconds: 300),
                  child: _PremiumButton(
                    text: "Create Account",
                    isLoading: _isLoading,
                    onTap: () async {
                      setState(() => _isLoading = true);
                      await Future.delayed(const Duration(seconds: 2));
                      setState(() => _isLoading = false);
                      context.go('/home');
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Same fixed Premium Widgets for consistency
class _PremiumInput extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool isPass;
  final bool? isPasswordVisible;
  final VoidCallback? onToggle;

  const _PremiumInput({required this.controller, required this.label, required this.icon, this.isPass = false, this.isPasswordVisible, this.onToggle});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white.withOpacity(0.1))),
          child: TextField(
            controller: controller,
            obscureText: isPass && !(isPasswordVisible ?? false),
            style: GoogleFonts.outfit(color: Colors.white),
            decoration: InputDecoration(
              labelText: label,
              labelStyle: GoogleFonts.outfit(color: Colors.white38),
              prefixIcon: Icon(icon, color: Colors.cyan, size: 20),
              suffixIcon: isPass ? IconButton(icon: Icon((isPasswordVisible ?? false) ? Iconsax.eye : Iconsax.eye_slash, color: Colors.white38), onPressed: onToggle) : null,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
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
  const _PremiumButton({required this.text, required this.isLoading, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        height: 60, width: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), gradient: const LinearGradient(colors: [Color(0xFF00F2FE), Color(0xFF4FACFE)]), boxShadow: [BoxShadow(color: Colors.cyan.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10))]),
        child: Center(child: isLoading ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)) : Text(text, style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white))),
      ),
    );
  }
}

class _GlowOrb extends StatelessWidget {
  final Color color;
  const _GlowOrb({required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(width: 250, height: 250, decoration: BoxDecoration(shape: BoxShape.circle, color: color), child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80), child: Container()));
  }
}