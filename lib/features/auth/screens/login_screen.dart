import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  final String role;
  const LoginScreen({super.key, required this.role});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final pass = TextEditingController();
  bool _isLoading = false;
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050505),
      body: Stack(
        children: [
          Positioned(top: -100, right: -50, child: _GlowOrb(color: Colors.deepPurple.withOpacity(0.3))),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  FadeInDown(child: Center(child: CircleAvatar(radius: 50, backgroundColor: Colors.white10, child: Lottie.asset('assets/ai_brain.json', errorBuilder: (c,e,s) => const Icon(Iconsax.cpu, color: Colors.cyan, size: 40))))),
                  const SizedBox(height: 40),
                  Text("CREATERFLOW", style: GoogleFonts.outfit(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 4)),
                  Text("Login as ${widget.role.toUpperCase()}", style: GoogleFonts.outfit(color: Colors.cyan, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 50),
                  _PremiumInput(controller: email, label: "Email Address", icon: Iconsax.sms),
                  const SizedBox(height: 20),
                  _PremiumInput(controller: pass, label: "Password", icon: Iconsax.lock, isPass: true, isPasswordVisible: _isPasswordVisible, onToggle: () => setState(() => _isPasswordVisible = !_isPasswordVisible)),
                  const SizedBox(height: 30),
                  _AnimatedEliteButton(text: "Sign In", isLoading: _isLoading, onTap: () async {
                    setState(() => _isLoading = true);
                    await Future.delayed(const Duration(seconds: 2));
                    widget.role == 'creator' ? context.go('/creator-dashboard') : context.go('/home');
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedEliteButton extends StatefulWidget {
  final String text; final bool isLoading; final VoidCallback onTap;
  const _AnimatedEliteButton({required this.text, required this.isLoading, required this.onTap});
  @override
  State<_AnimatedEliteButton> createState() => _AnimatedEliteButtonState();
}

class _AnimatedEliteButtonState extends State<_AnimatedEliteButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() { _controller = AnimationController(vsync: this, duration: const Duration(seconds: 3))..repeat(); super.initState(); }
  @override
  void dispose() { _controller.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isLoading ? null : widget.onTap,
      child: AnimatedBuilder(animation: _controller, builder: (context, child) {
        return Container(height: 60, width: double.infinity, decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), gradient: SweepGradient(colors: const [Color(0xFF00F2FE), Color(0xFF7C3AED), Color(0xFF00F2FE)], transform: GradientRotation(_controller.value * 6.28))), child: Padding(padding: const EdgeInsets.all(1.5), child: Container(decoration: BoxDecoration(color: const Color(0xFF050505), borderRadius: BorderRadius.circular(28)), child: Center(child: widget.isLoading ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : Text(widget.text, style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.white))))));
      }),
    );
  }
}

class _PremiumInput extends StatelessWidget {
  final TextEditingController controller; final String label; final IconData icon; final bool isPass; final bool? isPasswordVisible; final VoidCallback? onToggle;
  const _PremiumInput({required this.controller, required this.label, required this.icon, this.isPass = false, this.isPasswordVisible, this.onToggle});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(borderRadius: BorderRadius.circular(20), child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), child: Container(decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white.withOpacity(0.1))), child: TextField(controller: controller, obscureText: isPass && !(isPasswordVisible ?? false), style: GoogleFonts.outfit(color: Colors.white), decoration: InputDecoration(labelText: label, labelStyle: GoogleFonts.outfit(color: Colors.white38), prefixIcon: Icon(icon, color: Colors.cyan, size: 20), suffixIcon: isPass ? IconButton(icon: Icon((isPasswordVisible ?? false) ? Iconsax.eye : Iconsax.eye_slash, color: Colors.white38), onPressed: onToggle) : null, border: InputBorder.none, contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20))))));
  }
}

class _GlowOrb extends StatelessWidget {
  final Color color; const _GlowOrb({required this.color});
  @override
  Widget build(BuildContext context) { return Container(width: 300, height: 300, decoration: BoxDecoration(shape: BoxShape.circle, color: color), child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100), child: Container())); }
}

class _SocialCircle extends StatelessWidget {
  final IconData icon; final Color color;
  const _SocialCircle({required this.icon, required this.color});
  @override
  Widget build(BuildContext context) { return Container(padding: const EdgeInsets.all(15), decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withOpacity(0.05), border: Border.all(color: Colors.white.withOpacity(0.1))), child: FaIcon(icon, color: color, size: 20)); }
}