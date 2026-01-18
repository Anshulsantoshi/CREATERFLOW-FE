import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:animate_do/animate_do.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  bool isUploading = false;
  bool isTrailer = false;

  void _startUpload() async {
    setState(() => isUploading = true);
    // Simulate upload delay
    await Future.delayed(const Duration(seconds: 3));
    if(mounted) Navigator.pop(context); // Close after upload
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Iconsax.close_circle, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("New Drop", style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: isUploading ? _buildUploadingState() : _buildFormState(),
    );
  }

  Widget _buildFormState() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // MEDIA SELECTOR
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white10, style: BorderStyle.solid),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Iconsax.video_add, color: Color(0xFF8A2BE2), size: 40),
                const SizedBox(height: 12),
                Text("Tap to select Video/PDF", style: GoogleFonts.inter(color: Colors.white54)),
              ],
            ),
          ),
          const SizedBox(height: 30),

          // INPUTS
          _buildTextField("Title", "e.g., 30 Day Shred"),
          const SizedBox(height: 20),
          _buildTextField("Price (₹)", "499", isNumber: true),

          const SizedBox(height: 30),

          // TRAILER SWITCH
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Is this a Trailer?", style: GoogleFonts.inter(color: Colors.white, fontSize: 16)),
              Switch(
                value: isTrailer,
                onChanged: (val) => setState(() => isTrailer = val),
                activeColor: const Color(0xFF8A2BE2),
                activeTrackColor: const Color(0xFF8A2BE2).withOpacity(0.3),
              ),
            ],
          ),

          const Spacer(),

          // UPLOAD BUTTON
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _startUpload,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8A2BE2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                shadowColor: const Color(0xFF8A2BE2).withOpacity(0.5),
                elevation: 10,
              ),
              child: Text("Upload to Store", style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ROCKET ANIMATION (Using Icon + Animation for now)
          FadeInUp(
            duration: const Duration(seconds: 1),
            child: const Icon(Iconsax.airplane, size: 80, color: Color(0xFF8A2BE2)),
          ),
          const SizedBox(height: 30),
          FadeIn(
            delay: const Duration(milliseconds: 500),
            child: Text("Uploading to the moon... 🚀",
                style: GoogleFonts.inter(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String hint, {bool isNumber = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.inter(color: Colors.white70, fontSize: 14)),
        const SizedBox(height: 8),
        TextField(
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.2)),
            filled: true,
            fillColor: Colors.white.withOpacity(0.05),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF8A2BE2)),
            ),
          ),
        ),
      ],
    );
  }
}