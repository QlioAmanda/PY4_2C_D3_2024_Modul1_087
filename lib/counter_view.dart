// Nama : Qlio Amanda Febriany
// Nim : 241511087
// Kelas : 2C

import 'package:flutter/material.dart';
import 'counter_controller.dart';

class CounterView extends StatefulWidget {
  const CounterView({super.key});

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  // 1. Dependency Injection
  final CounterController _controller = CounterController();

  // 2. Helper Method
  void _updateState(VoidCallback action) => setState(action);

  // 3. UI Logic
  Color _getHistoryColor(String item) {
    if (item.contains("Ditambah")) return const Color(0xFF689F38);
    if (item.contains("Dikurang")) return const Color(0xFFC62828);
    if (item.contains("reset")) return const Color(0xFFF9A825);
    return Colors.blueGrey; 
  }

  // 4. UX Improvement: Dialog konfirmasi
  void _showResetConfirmation() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Konfirmasi Reset"),
        content: const Text("Yakin ingin hapus semua data?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx), 
            child: const Text("Batal")
          ),
          TextButton(
            onPressed: () {
              _updateState(() => _controller.reset());
              Navigator.pop(ctx); 
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Data di-reset!"), 
                  backgroundColor: Colors.orange
                )
              );
            },
            child: const Text("Ya, Reset", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2E3138), 
      appBar: AppBar(
        title: const Text(
          "LogBook: Task 1 & 2 - 087", 
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontFamily: 'serif')
        ),
        centerTitle: true, 
        backgroundColor: const Color(0xFFB0BEC5), 
        toolbarHeight: 45, 
        elevation: 2,
      ),
      // --- PERBAIKAN UTAMA DI SINI ---
      // Menggunakan Center & ConstrainedBox agar rapi di Laptop
      // Menggunakan SingleChildScrollView agar tidak error overflow (kuning-hitam)
      body: SingleChildScrollView( 
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              _buildTotalPanel(),
              const SizedBox(height: 10),
              _buildSliderPanel(),
              const SizedBox(height: 10),
              _buildActionButtons(),
              const SizedBox(height: 15),
              
              // Panel Riwayat
              SizedBox(
                height: 265, // Tinggi tetap aman
                child: _buildHistoryPanel()
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- WIDGET COMPONENTS ---
  Widget _buildTotalPanel() {
    return Container(
      width: double.infinity, 
      padding: const EdgeInsets.symmetric(vertical: 50),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.grey.shade300, const Color.fromARGB(255, 174, 203, 218)]),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: Colors.black45, blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: Column(children: [
        const Text("TOTAL HITUNGAN", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2, fontFamily: 'serif')),
        Text('${_controller.value}', style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, fontFamily: 'serif')),
      ]),
    );
  }

  Widget _buildSliderPanel() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFCFD8DC), 
        borderRadius: BorderRadius.circular(15),
        border: Border(top: BorderSide(color: Colors.blueGrey.shade700, width: 25)),
      ),
      child: Column(children: [
        Transform.translate(
          offset: const Offset(0, -30), 
          child: const Text(
            "ATUR LANGKAH (STEP)", 
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10, fontFamily: 'serif')
          )
        ),
        Row(children: [
          Expanded(
            child: Slider(
              value: _controller.step.toDouble(), 
              min: 1, 
              max: 10, 
              divisions: 9,
              activeColor: const Color(0xFF546E7A), 
              inactiveColor: const Color.fromARGB(31, 250, 246, 246),
              onChanged: (v) => _updateState(() => _controller.setStep(v.toInt())),
            )
          ),
          Text("${_controller.step}/10", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'serif')),
        ]),
      ]),
    );
  }

  Widget _buildActionButtons() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      _circleBtn(Icons.remove, const Color(0xFFB71C1C), () => _updateState(() => _controller.decrement())),
      _circleBtn(Icons.refresh, const Color(0xFFAFB42B), _showResetConfirmation),
      _circleBtn(Icons.add, const Color(0xFF388E3C), () => _updateState(() => _controller.increment())),
    ]);
  }

  Widget _buildHistoryPanel() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF90A4AE), 
        borderRadius: BorderRadius.circular(15), 
        boxShadow: const [BoxShadow(color: Colors.black38, blurRadius: 4, offset: Offset(0, 2))],
      ),
      clipBehavior: Clip.antiAlias, 
      child: Column(
        children: [
          Container(
            width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 8),
            color: Colors.white,
            child: const Text("RIWAYAT AKTIVITAS", textAlign: TextAlign.center, 
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, fontFamily: 'serif')),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10), 
              itemCount: _controller.history.length,
              itemBuilder: (context, index) {
                final item = _controller.history[index];
                IconData icon = item.contains("Ditambah") ? Icons.arrow_upward : 
                                item.contains("Dikurang") ? Icons.arrow_downward : Icons.restore;
                
                return Container(
                  margin: const EdgeInsets.only(bottom: 6), padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: _getHistoryColor(item), 
                    borderRadius: BorderRadius.circular(10), 
                    boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 1, offset: Offset(0, 1))],
                  ),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Icon(icon, color: Colors.black54, size: 16),
                    const SizedBox(width: 8),
                    Text(item, style: const TextStyle(fontFamily: 'serif', fontWeight: FontWeight.bold, fontSize: 12)),
                  ]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _circleBtn(IconData icon, Color color, VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle, 
        color: color, 
        border: Border.all(color: Colors.white24, width: 2), 
        boxShadow: const [BoxShadow(color: Colors.black38, blurRadius: 4, offset: Offset(0, 2))]
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white70, size: 24), 
        onPressed: onTap, 
        padding: const EdgeInsets.all(10)
      ),
    );
  }
}