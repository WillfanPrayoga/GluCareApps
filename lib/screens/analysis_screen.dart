import 'package:flutter/material.dart';

class AnalysisScreen extends StatelessWidget {
  const AnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color mainBlue = Color(0xFF007BFF);
    const Color bgGray = Color(0xFFF8F9FA);

    return Scaffold(
      backgroundColor: bgGray,
      body: Column(
        children: [
          // --- HEADER BIRU ---
          Container(
            width: double.infinity,
            padding:
                const EdgeInsets.only(top: 60, left: 25, right: 25, bottom: 40),
            decoration: const BoxDecoration(
              color: mainBlue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Analisis Risiko",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Pilih metode untuk menghitung skor risikomu",
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // --- KARTU MODE KLINIS ---
                  _buildAnalysisCard(
                    context,
                    title: "Mode Klinis / Lab",
                    subtitle: "Input hasil lab untuk analisis paling akurat",
                    icon: Icons.biotech_outlined,
                    iconColor: Colors.blue,
                    tags: [
                      "Usia",
                      "IMT",
                      "Gula Darah",
                      "Tekanan darah",
                      "Kolestrol"
                    ],
                    recommendation: "Akurasi tertinggi — direkomendasikan",
                    onTap: () => Navigator.pushNamed(context, '/clinical-mode'),
                  ),

                  const SizedBox(height: 20),

                  // --- KARTU MODE KUESIONER ---
                  _buildAnalysisCard(
                    context,
                    title: "Mode Kuesioner",
                    subtitle:
                        "Jawab pertanyaan gaya hidup untuk pemeriksaan cepat",
                    icon: Icons.assignment_outlined,
                    iconColor: Colors.deepPurple,
                    tags: [
                      "Pola hidup",
                      "Pola makan",
                      "Gejala",
                      "Aktivitas",
                      "Keluarga"
                    ],
                    recommendation: "Cocok tanpa data lab",
                    isRecommended: false,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Fitur Kuesioner segera hadir!")),
                      );
                    },
                  ),

                  const SizedBox(height: 30),

                  // --- ILUSTRASI DOKTER ---
                  Center(
                    child: Image.asset(
                      'assets/doctors_illustration.png',
                      height: 180,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                          Icons.group,
                          size: 100,
                          color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),

      // --- BOTTOM NAVIGATION BAR ---
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: mainBlue,
        unselectedItemColor: Colors.grey,
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/dashboard');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/recommendation');
          }
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.analytics), label: "Analisis"),
          BottomNavigationBarItem(
              icon: Icon(Icons.lightbulb_outline), label: "Rekomendasi"),
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart), label: "Progres"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: "Profil"),
        ],
      ),
    );
  }

  Widget _buildAnalysisCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required List<String> tags,
    required String recommendation,
    bool isRecommended = true,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05), // FIXED
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: iconColor.withValues(alpha: 0.1), // FIXED
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: iconColor, size: 30),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(subtitle,
                          style: const TextStyle(
                              color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios,
                    size: 16, color: Colors.grey),
              ],
            ),
            const SizedBox(height: 15),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: tags
                  .map((tag) => Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.blue.withValues(alpha: 0.05), // FIXED
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color:
                                  Colors.blue.withValues(alpha: 0.1)), // FIXED
                        ),
                        child: Text(tag,
                            style: const TextStyle(
                                fontSize: 10,
                                color: Colors.blue,
                                fontWeight: FontWeight.w600)),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Icon(
                  isRecommended ? Icons.check_circle : Icons.info_outline,
                  size: 14,
                  color: isRecommended ? Colors.green : Colors.orange,
                ),
                const SizedBox(width: 5),
                Text(
                  recommendation,
                  style: TextStyle(
                    fontSize: 11,
                    color: isRecommended ? Colors.green : Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
