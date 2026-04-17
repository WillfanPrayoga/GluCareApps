import 'package:flutter/material.dart';
import 'package:glucare/screens/analysis_result_screen.dart';

class ClinicalModeScreen extends StatefulWidget {
  const ClinicalModeScreen({super.key});

  @override
  State<ClinicalModeScreen> createState() => _ClinicalModeScreenState();
}

class _ClinicalModeScreenState extends State<ClinicalModeScreen> {
  final TextEditingController _hba1c = TextEditingController();
  final TextEditingController _gula = TextEditingController();
  final TextEditingController _berat = TextEditingController();
  final TextEditingController _tinggi = TextEditingController();
  String _selectedHistory = 'Tidak';

  @override
  Widget build(BuildContext context) {
    const Color mainBlue = Color(0xFF007BFF);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text("Analisis Risiko",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: mainBlue,
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // HEADER BIRU
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: const BoxDecoration(
                color: mainBlue,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Lengkapi Data Lab",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                  const SizedBox(height: 15),
                  LinearProgressIndicator(
                      value: 0.5,
                      backgroundColor: Colors.white24,
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(10)),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _field("HbA1c (%)", "Contoh: 6.5", _hba1c),
                  _field("Gula Darah (mg/dL)", "Contoh: 120", _gula),
                  _field("Berat Badan (kg)", "Contoh: 70", _berat),
                  _field("Tinggi Badan (cm)", "Contoh: 170", _tinggi),
                  const SizedBox(height: 10),
                  const Text("Riwayat Keluarga Diabetes?",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Row(children: [_chip("Ya"), _chip("Tidak"), _chip("Tahu")]),
                  const SizedBox(height: 40),
                  // TOMBOL KIRIM DATA
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AnalysisResultScreen(
                                      hba1c:
                                          double.tryParse(_hba1c.text) ?? 0.0,
                                      gulaDarah: int.tryParse(_gula.text) ?? 0,
                                      berat:
                                          double.tryParse(_berat.text) ?? 0.0,
                                      tinggi:
                                          double.tryParse(_tinggi.text) ?? 0.0,
                                    )));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mainBlue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      child: const Text("ANALISIS SEKARANG",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(String label, String hint, TextEditingController ctrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          controller: ctrl,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none)),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _chip(String label) {
    bool sel = _selectedHistory == label;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedHistory = label),
        child: Container(
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: sel ? Colors.blue : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue)),
          child: Center(
              child: Text(label,
                  style: TextStyle(
                      color: sel ? Colors.white : Colors.blue,
                      fontWeight: FontWeight.bold))),
        ),
      ),
    );
  }
}
