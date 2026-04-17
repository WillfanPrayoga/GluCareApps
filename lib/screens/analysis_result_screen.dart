import 'package:flutter/material.dart';

class AnalysisResultScreen extends StatelessWidget {
  final double hba1c;
  final int gulaDarah;
  final double berat;
  final double tinggi;

  const AnalysisResultScreen(
      {super.key,
      required this.hba1c,
      required this.gulaDarah,
      required this.berat,
      required this.tinggi});

  @override
  Widget build(BuildContext context) {
    const Color mainBlue = Color(0xFF007BFF);
    const Color dangerRed = Color(0xFFDC3545);
    const Color successGreen = Color(0xFF28A745);

    double bmi = berat / ((tinggi / 100) * (tinggi / 100));
    bool isDanger = hba1c >= 6.5 || gulaDarah >= 126;
    Color statusColor = isDanger ? dangerRed : successGreen;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text("Hasil Analisis AI",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: mainBlue,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            // KARTU SKOR UTAMA
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.05), blurRadius: 20)
                ],
                border:
                    Border.all(color: statusColor.withOpacity(0.3), width: 2),
              ),
              child: Column(
                children: [
                  Icon(isDanger ? Icons.warning_rounded : Icons.check_circle,
                      size: 60, color: statusColor),
                  const SizedBox(height: 15),
                  Text(isDanger ? "68%" : "12%",
                      style: TextStyle(
                          fontSize: 65,
                          fontWeight: FontWeight.bold,
                          color: statusColor)),
                  Text("● ${isDanger ? 'Risiko Tinggi' : 'Risiko Normal'}",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: statusColor)),
                  const SizedBox(height: 20),
                  LinearProgressIndicator(
                      value: isDanger ? 0.68 : 0.12,
                      minHeight: 12,
                      borderRadius: BorderRadius.circular(10),
                      color: statusColor,
                      backgroundColor: statusColor.withOpacity(0.1)),
                  const SizedBox(height: 35),
                  // ROW METRIC (BMI, HbA1c, Gula)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _metricBox("BMI", bmi.toStringAsFixed(1)),
                      _metricBox("HbA1c", "$hba1c%"),
                      _metricBox("Gula", "$gulaDarah"),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // DETAIL INTERPRETASI
            Align(
                alignment: Alignment.centerLeft,
                child: const Text("Interpretasi Medis",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
            const SizedBox(height: 15),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  _infoRow("Status Lab:", hba1c >= 6.5 ? "Diabetes" : "Normal",
                      hba1c >= 6.5),
                  const Divider(height: 30),
                  _infoRow("Berat Badan:", bmi >= 25 ? "Obesitas" : "Ideal",
                      bmi >= 25),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // TOMBOL RENCANA
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: mainBlue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                child: const Text("RENCANA INTERVENSI",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Assessment Ulang",
                    style: TextStyle(color: Colors.grey))),
          ],
        ),
      ),
    );
  }

  Widget _metricBox(String label, String val) {
    return Column(children: [
      Text(val,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12))
    ]);
  }

  Widget _infoRow(String label, String val, bool isDanger) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 14)),
        Text(val,
            style: TextStyle(
                color: isDanger ? Colors.red : Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 14)),
      ],
    );
  }
}
