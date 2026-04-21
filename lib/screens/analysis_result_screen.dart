import 'package:flutter/material.dart';

class AnalysisResultScreen extends StatelessWidget {
  const AnalysisResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color mainBlue = Color(0xFF007BFF);
    const Color bgGray = Color(0xFFF8F9FA);

    return Scaffold(
      backgroundColor: bgGray,
      appBar: AppBar(
        title: const Text("Hasil Analisis",
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Skor Utama
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withValues(alpha: 0.05), // Perbaikan warning
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                children: [
                  const Text("Skor Risiko Kamu",
                      style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 10),
                  Text(
                    "65/100",
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange
                          .withValues(alpha: 0.9), // Perbaikan warning
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Risiko Sedang",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.orange),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Card Detail
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: mainBlue.withValues(alpha: 0.05), // Perbaikan warning
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: mainBlue.withValues(alpha: 0.1)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info_outline, color: mainBlue),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Hasil ini menunjukkan kamu perlu memperhatikan pola makan dan aktivitas fisik lebih rutin.",
                      style: TextStyle(fontSize: 12, color: Colors.black87),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Tombol Rekomendasi
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: mainBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, '/recommendation'),
                child: const Text("Lihat Rencana Intervensi",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),

            const SizedBox(height: 15),

            // Tombol Kembali ke Dashboard
            TextButton(
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, '/dashboard'),
              child: const Text("Kembali ke Beranda",
                  style: TextStyle(color: Colors.grey)),
            ),
          ],
        ),
      ),
    );
  }
}
