import 'package:flutter/material.dart';

class ClinicalModeScreen extends StatefulWidget {
  const ClinicalModeScreen({super.key});

  @override
  State<ClinicalModeScreen> createState() => _ClinicalModeScreenState();
}

class _ClinicalModeScreenState extends State<ClinicalModeScreen> {
  // Controller untuk ambil data input
  final TextEditingController _hba1cController = TextEditingController();
  final TextEditingController _gulaDarahController = TextEditingController();
  final TextEditingController _beratController = TextEditingController();
  final TextEditingController _tinggiController = TextEditingController();

  @override
  void dispose() {
    _hba1cController.dispose();
    _gulaDarahController.dispose();
    _beratController.dispose();
    _tinggiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color mainBlue = Color(0xFF007BFF);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text("Mode Klinis",
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Masukkan Data Lab",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 25),

            // Panggil helper dengan parameter yang SUDAH didefinisikan di bawah
            _buildInputField(
                label: "HbA1c (%)",
                controller: _hba1cController,
                hint: "5.7",
                icon: Icons.biotech),
            _buildInputField(
                label: "Gula Darah (mg/dL)",
                controller: _gulaDarahController,
                hint: "140",
                icon: Icons.bloodtype),
            _buildInputField(
                label: "Berat Badan (kg)",
                controller: _beratController,
                hint: "70",
                icon: Icons.monitor_weight),
            _buildInputField(
                label: "Tinggi Badan (cm)",
                controller: _tinggiController,
                hint: "170",
                icon: Icons.height),

            const SizedBox(height: 30),

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
                    Navigator.pushNamed(context, '/analysis-result'),
                child: const Text("Mulai Analisis",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi Helper - Pastikan parameter ini ADA agar tidak error 'undefined_named_parameter'
  Widget _buildInputField(
      {required String label,
      required TextEditingController controller,
      required String hint,
      required IconData icon}) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 20), // Perbaikan dari .bottom ke .only
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: hint,
              prefixIcon: Icon(icon, color: Colors.blue),
              filled: true,
              fillColor: Colors.white,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
    );
  }
}
