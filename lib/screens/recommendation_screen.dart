import 'package:flutter/material.dart';

class RecommendationScreen extends StatefulWidget {
  const RecommendationScreen({super.key});

  @override
  State<RecommendationScreen> createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  int _selectedTab = 0;
  final List<String> _tabs = ['Aktivitas', 'Nutrisi', 'Tidur'];
  final List<int> _tabCounts = [2, 3, 2];

  final List<Map<String, dynamic>> _allItems = [
    // Aktivitas
    {
      'category': 'Aktivitas',
      'categoryColor': const Color(0xFF007BFF),
      'priority': true,
      'title': 'Jalan Kaki 30 Menit Setelah Makan',
      'icon': '🚶',
      'tab': 0,
    },
    {
      'category': 'Aktivitas',
      'categoryColor': const Color(0xFF007BFF),
      'priority': false,
      'title': 'Latihan Kekuatan 2x Seminggu',
      'icon': '🏋️',
      'tab': 0,
    },
    // Nutrisi
    {
      'category': 'Nutrisi',
      'categoryColor': const Color(0xFFFF9500),
      'priority': true,
      'title': 'Metode Piring Harvard (Plate Method)',
      'icon': '🍽️',
      'tab': 1,
    },
    {
      'category': 'Nutrisi',
      'categoryColor': const Color(0xFFFF9500),
      'priority': true,
      'title': 'Eliminasi Minuman Manis & Ultra-Processed Food',
      'icon': '🚫',
      'tab': 1,
    },
    {
      'category': 'Nutrisi',
      'categoryColor': const Color(0xFFFF9500),
      'priority': false,
      'title': 'Pilih Karbohidrat Indeks Glikemik Rendah',
      'icon': '🌾',
      'tab': 1,
    },
    // Tidur
    {
      'category': 'Tidur',
      'categoryColor': const Color(0xFF9B59B6),
      'priority': false,
      'title': 'Konsisten Jadwal Tidur 7-8 jam',
      'icon': '😴',
      'tab': 2,
    },
    {
      'category': 'Tidur',
      'categoryColor': const Color(0xFF9B59B6),
      'priority': false,
      'title': 'Hindari Layar 1 Jam Sebelum Tidur',
      'icon': '📵',
      'tab': 2,
    },
    // Terapi & Edukasi (selalu tampil di semua tab)
    {
      'category': 'Terapi',
      'categoryColor': const Color(0xFFE74C3C),
      'priority': true,
      'title': 'Rutin Minum Obat',
      'icon': '💊',
      'tab': -1,
    },
    {
      'category': 'Edukasi',
      'categoryColor': const Color(0xFF1ABC9C),
      'priority': false,
      'title': 'Memahami Resistensi Insulin',
      'icon': '🔬',
      'tab': -1,
    },
    {
      'category': 'Edukasi',
      'categoryColor': const Color(0xFF1ABC9C),
      'priority': false,
      'title': 'Target HbA1c untuk Fase Prediabetes',
      'icon': '📊',
      'tab': -1,
    },
  ];

  List<Map<String, dynamic>> get _filteredItems {
    return _allItems
        .where((item) => item['tab'] == _selectedTab || item['tab'] == -1)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    const Color mainBlue = Color(0xFF007BFF);

    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      body: Column(
        children: [
          // ── HEADER ──
          Container(
            width: double.infinity,
            padding:
                const EdgeInsets.only(top: 55, left: 20, right: 20, bottom: 20),
            color: mainBlue,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Rencana Intervensi",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Skor risiko prediabetes personalmu",
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
                const SizedBox(height: 20),

                // Stat boxes
                Row(
                  children: [
                    _buildStatBox("🔴", "18g", "Gula", Colors.redAccent),
                    const SizedBox(width: 10),
                    _buildStatBox("🏃", "22 mnt", "Aktivitas", Colors.orange),
                    const SizedBox(width: 10),
                    _buildStatBox("😴", "6.5 jam", "Tidur", Colors.amber),
                    const SizedBox(width: 10),
                    _buildStatBox(
                        "💧", "6 gelas", "Air", Colors.lightBlueAccent),
                  ],
                ),
                const SizedBox(height: 16),

                // Rencana 90 hari banner
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Text('📅', style: TextStyle(fontSize: 18)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Rencana 90 Hari — Hari 5",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                            Text(
                              "3 fase intervensi terstruktur",
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios,
                          color: Colors.white70, size: 14),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── TAB BAR ──
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: List.generate(_tabs.length, (i) {
                final isActive = _selectedTab == i;
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedTab = i),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: isActive ? mainBlue : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isActive ? mainBlue : Colors.grey.shade300,
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            _tabs[i],
                            style: TextStyle(
                              color: isActive ? Colors.white : Colors.black54,
                              fontSize: 13,
                              fontWeight: isActive
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 1),
                            decoration: BoxDecoration(
                              color: isActive
                                  ? Colors.white.withValues(alpha: 0.3)
                                  : Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              '${_tabCounts[i]}',
                              style: TextStyle(
                                fontSize: 11,
                                color: isActive ? Colors.white : Colors.black54,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),

          // ── LIST ──
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
              child: Column(
                children: [
                  ..._filteredItems.map((item) => _buildCard(item)),
                  const SizedBox(height: 16),

                  // Penting Diketahui
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F8F5),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                          color:
                              const Color(0xFF1ABC9C).withValues(alpha: 0.3)),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "📋 Penting Diketahui",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Color(0xFF1ABC9C),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Rekomendasi ini bersifat edukatif berdasarkan panduan klinis ADA dan WHO. Konsultasikan kondisi Anda dengan dokter atau ahli gizi terdaftar sebelum memulai program intervensi.",
                          style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF1ABC9C),
                              height: 1.5),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // ── BOTTOM NAV ──
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: mainBlue,
        unselectedItemColor: Colors.grey,
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/dashboard');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/analysis');
          }
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.analytics_outlined), label: "Analisis"),
          BottomNavigationBarItem(
              icon: Icon(Icons.lightbulb), label: "Rekomendasi"),
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart), label: "Progres"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: "Profil"),
        ],
      ),
    );
  }

  Widget _buildStatBox(
      String emoji, String val, String label, Color lineColor) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 4),
            Text(val,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12)),
            Text(label,
                style: const TextStyle(color: Colors.white70, fontSize: 10)),
            const SizedBox(height: 6),
            Container(
              height: 3,
              decoration: BoxDecoration(
                color: lineColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(Map<String, dynamic> item) {
    final Color catColor = item['categoryColor'] as Color;
    final bool hasPriority = item['priority'] as bool;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: catColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(item['icon'] as String,
                  style: const TextStyle(fontSize: 22)),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      item['category'] as String,
                      style: TextStyle(
                        color: catColor,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (hasPriority) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.red.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          "Prioritas Tinggi",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  item['title'] as String,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
        ],
      ),
    );
  }
}
