import 'package:flutter/material.dart';

class ProgresScreen extends StatefulWidget {
  const ProgresScreen({super.key});

  @override
  State<ProgresScreen> createState() => _ProgresScreenState();
}

class _ProgresScreenState extends State<ProgresScreen> {
  int _selectedTab = 0; // 0=90Hari, 1=Pencapaian, 2=Evaluasi
  final List<bool> _taskDone = [false, false, false, false, false, false];
  final List<bool> _reminderOn = [false, false, false, false, false, false];

  // Data tugas harian
  final List<Map<String, dynamic>> _tasks = [
    {'icon': '🚶', 'title': 'Jalan kaki 30 menit', 'xp': 25},
    {'icon': '🩸', 'title': 'Batasi gula < 25g hari ini', 'xp': 30},
    {'icon': '💧', 'title': 'Minum air 8 gelas', 'xp': 15},
    {'icon': '💊', 'title': 'Konsumsi obat / suplemen', 'xp': 30},
    {'icon': '😴', 'title': 'Tidur 7-8jam malam ini', 'xp': 25},
    {'icon': '🥗', 'title': 'Makan sayur + protein tanpa goreng', 'xp': 30},
  ];

  // Data pengingat
  final List<Map<String, dynamic>> _reminders = [
    {
      'icon': '☀️',
      'title': 'Cek pagi',
      'sub': 'Log  glukosa & berat badan',
      'time': '07:00'
    },
    {
      'icon': '🏃',
      'title': 'Olahraga',
      'sub': 'Pengingat aktivitas fisik',
      'time': '07:30'
    },
    {
      'icon': '🥗',
      'title': 'Makan Sehat',
      'sub': 'Pilihan makan siang sehat',
      'time': '12:00'
    },
    {
      'icon': '💊',
      'title': 'Suplemen',
      'sub': 'Konsumsi suplemen harian',
      'time': '20:00'
    },
    {
      'icon': '😴',
      'title': 'Waktu tidur',
      'sub': 'Istirahat untuk metabolisme',
      'time': '22:00'
    },
    {
      'icon': '💧',
      'title': 'Minum Air',
      'sub': 'Target 8 gelas per hari',
      'time': '15:00'
    },
  ];

  // Chart data
  final List<double> _chartData = [40, 75, 30, 90, 55, 80, 45];
  final List<String> _chartDays = [
    'Sen',
    'Sel',
    'Rab',
    'Kam',
    'Jum',
    'Sab',
    'Min'
  ];

  int get _completedTasks => _taskDone.where((t) => t).length;
  int get _activeReminders => _reminderOn.where((r) => r).length;

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
                const Text('Progres & Evaluasi',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                const SizedBox(height: 4),
                const Text('Pantau intervensi metabolik harianmu',
                    style: TextStyle(color: Colors.white70, fontSize: 13)),
                const SizedBox(height: 20),

                // Streak / Level / Pencapaian
                Row(
                  children: [
                    _buildHeaderStat('🔥', '1 hari', 'Streak'),
                    const SizedBox(width: 12),
                    _buildHeaderStat('⚡', '8', 'Level'),
                    const SizedBox(width: 12),
                    _buildHeaderStat('🏅', '4', 'Pencapaian'),
                  ],
                ),
              ],
            ),
          ),

          // ── TAB BAR ──
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                _buildTab('📅 90 Hari', 0),
                const SizedBox(width: 10),
                _buildTab('🏆 Pencapaian', 1),
                const SizedBox(width: 10),
                _buildTab('📊 Evaluasi', 2),
              ],
            ),
          ),

          // ── CONTENT ──
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Intervensi 90 Hari progress card
                  _buildProgressCard(),
                  const SizedBox(height: 20),

                  // Target Hari Ini
                  _buildTargetSection(),
                  const SizedBox(height: 20),

                  // Fase Intervensi
                  _buildFaseSection(),
                  const SizedBox(height: 20),

                  // Level & XP
                  _buildLevelSection(),
                  const SizedBox(height: 20),

                  // Tugas Harian
                  _buildTugasSection(),
                  const SizedBox(height: 20),

                  // Aktivitas 7 Hari
                  _buildChartSection(),
                  const SizedBox(height: 20),

                  // Re-Assessment
                  _buildReAssessment(),
                  const SizedBox(height: 20),

                  // Pengingat
                  _buildPengingatSection(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: mainBlue,
        unselectedItemColor: Colors.grey,
        currentIndex: 3,
        onTap: (index) {
          if (index == 0) Navigator.pushReplacementNamed(context, '/dashboard');
          if (index == 1) Navigator.pushReplacementNamed(context, '/analysis');
          if (index == 2) {
            Navigator.pushReplacementNamed(context, '/recommendation');
          }
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.analytics_outlined), label: 'Analisis'),
          BottomNavigationBarItem(
              icon: Icon(Icons.lightbulb_outline), label: 'Rekomendasi'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart), label: 'Progres'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'Profil'),
        ],
      ),
    );
  }

  // ── HEADER STAT BOX ──
  Widget _buildHeaderStat(String emoji, String val, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 4),
            Text(val,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16)),
            Text(label,
                style: const TextStyle(color: Colors.white70, fontSize: 11)),
          ],
        ),
      ),
    );
  }

  // ── TAB ──
  Widget _buildTab(String label, int index) {
    final isActive = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 9),
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF007BFF) : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
                color:
                    isActive ? const Color(0xFF007BFF) : Colors.grey.shade300),
          ),
          child: Center(
            child: Text(label,
                style: TextStyle(
                    color: isActive ? Colors.white : Colors.black54,
                    fontSize: 12,
                    fontWeight:
                        isActive ? FontWeight.w600 : FontWeight.normal)),
          ),
        ),
      ),
    );
  }

  // ── PROGRESS CARD ──
  Widget _buildProgressCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8)
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: 0.05,
                  strokeWidth: 8,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: const AlwaysStoppedAnimation(Color(0xFF007BFF)),
                  strokeCap: StrokeCap.round,
                ),
                const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('5%',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    Text('selesai',
                        style: TextStyle(fontSize: 9, color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Intervensi 90 Hari',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(height: 4),
                const Text('Hari ke-5 dari 90',
                    style: TextStyle(color: Colors.grey, fontSize: 13)),
                const SizedBox(height: 4),
                const Text('85 hari tersisa · Fase 1/3',
                    style: TextStyle(
                        color: Color(0xFF007BFF),
                        fontSize: 12,
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: 0.05,
                    minHeight: 5,
                    backgroundColor: Colors.grey.shade200,
                    valueColor: const AlwaysStoppedAnimation(Color(0xFF007BFF)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── TARGET HARI INI ──
  Widget _buildTargetSection() {
    final targets = [
      {
        'icon': '🩸',
        'val': '18g',
        'target': '/ 40g',
        'label': 'Gula',
        'pct': 0.45,
        'color': Colors.blue
      },
      {
        'icon': '🏃',
        'val': '22 mnt',
        'target': '/ 21 mnt',
        'label': 'Aktivitas',
        'pct': 1.0,
        'color': Colors.blue
      },
      {
        'icon': '😴',
        'val': '6.5 jam',
        'target': '/ 8 jam',
        'label': 'Tidur',
        'pct': 0.81,
        'color': Colors.orange
      },
      {
        'icon': '💧',
        'val': '6 gelas',
        'target': '/ 8 gelas',
        'label': 'Air',
        'pct': 0.75,
        'color': Colors.blue
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Target Hari Ini',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF007BFF).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text('Hari 5',
                  style: TextStyle(
                      color: Color(0xFF007BFF),
                      fontSize: 12,
                      fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.5,
          children: targets.map((t) {
            final pct = (t['pct'] as double) * 100;
            final color = t['color'] as Color;
            return Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 6)
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(t['icon'] as String,
                          style: const TextStyle(fontSize: 18)),
                      Text('${pct.toInt()}%',
                          style: TextStyle(
                              color: pct >= 100 ? Colors.green : color,
                              fontWeight: FontWeight.bold,
                              fontSize: 13)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(t['val'] as String,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15)),
                  Text(t['target'] as String,
                      style: const TextStyle(color: Colors.grey, fontSize: 11)),
                  const Spacer(),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: t['pct'] as double,
                      minHeight: 5,
                      backgroundColor: Colors.grey.shade200,
                      valueColor: AlwaysStoppedAnimation(
                          pct >= 100 ? Colors.green : color),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(t['label'] as String,
                      style: const TextStyle(color: Colors.grey, fontSize: 11)),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // ── FASE INTERVENSI ──
  Widget _buildFaseSection() {
    final phases = [
      {
        'num': '1',
        'title': 'Stabilisasi Dasar',
        'active': true,
        'range': 'Hari 1– 30',
        'gula': '≤40g',
        'aktivitas': '150 mnt',
        'tidur': '7 jam'
      },
      {
        'num': '2',
        'title': 'Optimisasi Metabolik',
        'active': false,
        'range': 'Hari 31– 60',
        'gula': '<30g',
        'aktivitas': '200 mnt',
        'tidur': '7.5 jam'
      },
      {
        'num': '3',
        'title': 'Konsolidasi',
        'active': false,
        'range': 'Hari 61– 90',
        'gula': '≤25g',
        'aktivitas': '250 mnt',
        'tidur': '8 jam'
      },
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Fase Intervensi',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 14),
          ...phases.map((p) {
            final isActive = p['active'] as bool;
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isActive ? const Color(0xFFEBF4FF) : Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: isActive
                        ? const Color(0xFF007BFF)
                        : Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: isActive
                              ? const Color(0xFF007BFF)
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(p['num'] as String,
                              style: TextStyle(
                                  color: isActive ? Colors.white : Colors.grey,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(p['title'] as String,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isActive ? Colors.black87 : Colors.grey)),
                      const SizedBox(width: 8),
                      if (isActive)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFF007BFF),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text('AKTIF',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold)),
                        ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(p['range'] as String,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 12)),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            _buildPhaseBadge('🩸 ${p['gula']}'),
                            const SizedBox(width: 8),
                            _buildPhaseBadge('🏃 ${p['aktivitas']}'),
                            const SizedBox(width: 8),
                            _buildPhaseBadge('😴 ${p['tidur']}'),
                          ],
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          child: Text('Ketuk untuk detail →',
                              style: TextStyle(
                                  color: isActive
                                      ? const Color(0xFF007BFF)
                                      : Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildPhaseBadge(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.amber.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(label,
          style: const TextStyle(fontSize: 11, color: Colors.brown)),
    );
  }

  // ── LEVEL & XP ──
  Widget _buildLevelSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Level & XP',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.amber.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text('⚡ Level 8',
                    style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 13)),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: 2195 / 2400,
              minHeight: 12,
              backgroundColor: Colors.grey.shade200,
              valueColor: const AlwaysStoppedAnimation(Colors.amber),
            ),
          ),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('2195 / 2400 XP',
                  style: TextStyle(color: Colors.grey, fontSize: 12)),
              Text('205 XP lagi ke Level 9',
                  style: TextStyle(
                      color: Colors.orange,
                      fontSize: 12,
                      fontWeight: FontWeight.w500)),
            ],
          ),
        ],
      ),
    );
  }

  // ── TUGAS HARIAN ──
  Widget _buildTugasSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Tugas Harian',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text('$_completedTasks/${_tasks.length}',
                  style: const TextStyle(
                      color: Color(0xFF007BFF), fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          ...List.generate(_tasks.length, (i) {
            final task = _tasks[i];
            return GestureDetector(
              onTap: () => setState(() => _taskDone[i] = !_taskDone[i]),
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: _taskDone[i]
                      ? const Color(0xFFEBF4FF)
                      : Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: _taskDone[i]
                          ? const Color(0xFF007BFF).withValues(alpha: 0.3)
                          : Colors.grey.shade200),
                ),
                child: Row(
                  children: [
                    Icon(
                      _taskDone[i]
                          ? Icons.check_circle
                          : Icons.radio_button_unchecked,
                      color: _taskDone[i]
                          ? const Color(0xFF007BFF)
                          : Colors.grey.shade400,
                      size: 22,
                    ),
                    const SizedBox(width: 10),
                    Text(task['icon'] as String,
                        style: const TextStyle(fontSize: 20)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(task['title'] as String,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              decoration: _taskDone[i]
                                  ? TextDecoration.lineThrough
                                  : null,
                              color:
                                  _taskDone[i] ? Colors.grey : Colors.black87)),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.amber.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text('+ ${task['xp']} XP',
                          style: const TextStyle(
                              color: Colors.orange,
                              fontSize: 11,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  // ── CHART 7 HARI ──
  Widget _buildChartSection() {
    final maxVal = _chartData.reduce((a, b) => a > b ? a : b);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Aktivitas 7 Hari Terakhir',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          SizedBox(
            height: 100,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(_chartData.length, (i) {
                final h = (_chartData[i] / maxVal) * 100;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('${_chartData[i].toInt()}',
                            style: const TextStyle(
                                fontSize: 9, color: Colors.grey)),
                        const SizedBox(height: 3),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Container(
                            height: h * 0.8,
                            color: i == 3
                                ? const Color(0xFF007BFF)
                                : const Color(0xFF007BFF)
                                    .withValues(alpha: 0.45),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(_chartDays[i],
                            style: const TextStyle(
                                fontSize: 10, color: Colors.grey)),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 10),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Rendah',
                  style: TextStyle(fontSize: 11, color: Colors.grey)),
              Text('menit aktif/hari',
                  style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFF007BFF),
                      fontWeight: FontWeight.w500)),
              Text('Tinggi',
                  style: TextStyle(fontSize: 11, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }

  // ── RE-ASSESSMENT ──
  Widget _buildReAssessment() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.amber.shade50,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.amber.shade200),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Colors.amber.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child:
                const Center(child: Text('🔄', style: TextStyle(fontSize: 20))),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Re-Assessment Metabolik',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                Text('Belum pernah assessment',
                    style: TextStyle(color: Colors.orange, fontSize: 12)),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
        ],
      ),
    );
  }

  // ── PENGINGAT ──
  Widget _buildPengingatSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Pengingat',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text('$_activeReminders aktif',
                  style: const TextStyle(
                      color: Color(0xFF007BFF), fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 14),
          ...List.generate(_reminders.length, (i) {
            final r = _reminders[i];
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                        child: Text(r['icon'] as String,
                            style: const TextStyle(fontSize: 20))),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(r['title'] as String,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 14)),
                        Text(r['sub'] as String,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 11)),
                      ],
                    ),
                  ),
                  Text(r['time'] as String,
                      style: const TextStyle(color: Colors.grey, fontSize: 13)),
                  const SizedBox(width: 10),
                  Switch(
                    value: _reminderOn[i],
                    onChanged: (val) => setState(() => _reminderOn[i] = val),
                    activeThumbColor: const Color(0xFF007BFF),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
