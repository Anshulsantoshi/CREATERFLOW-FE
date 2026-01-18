import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:go_router/go_router.dart';
import 'package:confetti/confetti.dart'; // IMPORT CONFETTI

void showPaymentModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) => const _PaymentBottomSheet(),
  );
}

class _PaymentBottomSheet extends StatefulWidget {
  const _PaymentBottomSheet();

  @override
  State<_PaymentBottomSheet> createState() => _PaymentBottomSheetState();
}

class _PaymentBottomSheetState extends State<_PaymentBottomSheet> with TickerProviderStateMixin {
  late AnimationController _blinkController;
  late ConfettiController _confettiController; // Controller define kiya
  bool isProcessing = false;
  bool isSuccess = false;

  @override
  void initState() {
    _blinkController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800))..repeat(reverse: true);
    _confettiController = ConfettiController(duration: const Duration(seconds: 3)); // 3 sec tak udega
    super.initState();
  }

  @override
  void dispose() {
    _blinkController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  void _processPayment() async {
    setState(() => isProcessing = true);
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isProcessing = false;
      isSuccess = true;
    });

    // --- BLAST THE CONFETTI ---
    _confettiController.play();
    // --------------------------

    await Future.delayed(const Duration(seconds: 3)); // Thoda zyada wait taaki confetti dikhe
    if(mounted) {
      context.pop();
      context.push('/learning-hub');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.green,
          content: Text("Course Unlocked! Welcome to the club 🚀")
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    // Agar Success hai, toh Confetti Stack return karega
    if (isSuccess) return _buildSuccessView();

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Color(0xFF101010),
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        border: Border(top: BorderSide(color: Color(0xFF7C3AED), width: 1)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ... (Baaki poora purana code same rahega)
          // HEADER & IMPULSE TRIGGER
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Checkout", style: GoogleFonts.outfit(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
              FadeTransition(
                opacity: _blinkController,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(color: Colors.amber.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      const Icon(Iconsax.flash_1, color: Colors.amber, size: 14),
                      const SizedBox(width: 4),
                      Text("Instant Access", style: GoogleFonts.outfit(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 12)),
                    ],
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 30),
          // Price Summary
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(16)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("30-Day Shred Program", style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.bold)), Text("Fitness with Aman", style: GoogleFonts.outfit(color: Colors.white54, fontSize: 12))]),
                Text("₹499", style: GoogleFonts.outfit(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900)),
              ],
            ),
          ),
          const SizedBox(height: 30),
          // Button
          SizedBox(
            width: double.infinity, height: 60,
            child: ElevatedButton(
              onPressed: isProcessing ? null : _processPayment,
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF7C3AED), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
              child: isProcessing ? const CircularProgressIndicator(color: Colors.white) : Text("Pay ₹499 Securely", style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessView() {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: 400, padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(color: Color(0xFF101010), borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [const Icon(Iconsax.verify5, color: Colors.greenAccent, size: 80), const SizedBox(height: 20), Text("Payment Successful!", style: GoogleFonts.outfit(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)), Text("Redirecting...", style: GoogleFonts.outfit(color: Colors.white54))]),
        ),

        // --- CONFETTI WIDGET ---
        ConfettiWidget(
          confettiController: _confettiController,
          blastDirectionality: BlastDirectionality.explosive, // Chaaro taraf phatega
          shouldLoop: false,
          colors: const [Colors.green, Colors.blue, Colors.pink, Colors.orange, Colors.purple],
          numberOfParticles: 20,
          gravity: 0.3,
        ),
      ],
    );
  }
}