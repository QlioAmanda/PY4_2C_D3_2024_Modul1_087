//File counter_view.dart
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
  final CounterController _controller = CounterController();

  void _updateState(VoidCallback action) {
    setState(() {
      action();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LogBook: Task 1 & 2 - 087"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // --- BAGIAN 1: TOTAL HITUNGAN ---
            const Text("Total Hitungan:", style: TextStyle(fontSize: 18)),
            Text(
              '${_controller.value}',
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            
            const SizedBox(height: 10),

            // --- BAGIAN 2: SLIDER STEP ---
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [
                  const Text("Atur Jumlah Step:", style: TextStyle(fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      const Text("1"),
                      Expanded(
                        child: Slider(
                          value: _controller.step.toDouble(),
                          min: 1,
                          max: 10,
                          divisions: 9,
                          label: _controller.step.toString(),
                          onChanged: (value) {
                            _updateState(() => _controller.setStep(value.toInt()));
                          },
                        ),
                      ),
                      Text(
                        "${_controller.step}", 
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // --- BAGIAN 3: TOMBOL AKSI ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // 1. Tombol Kurang (Merah) 
                ElevatedButton(
                  onPressed: () => _updateState(() => _controller.decrement()),
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(), // Membuat tombol jadi bulat
                    padding: const EdgeInsets.all(20), // Ukuran tombol
                    backgroundColor: const Color.fromARGB(255, 201, 151, 178), // Warna background
                    foregroundColor: Colors.white, // Warna ikon
                  ),
                  child: const Icon(Icons.remove, size: 30),
                ),

                // 2. Tombol Reset (Oranye) 
                ElevatedButton(
                  onPressed: () => _updateState(() => _controller.reset()),
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(20),
                    backgroundColor: const Color.fromARGB(255, 146, 157, 171),
                    foregroundColor: Colors.white,
                  ),
                  child: const Icon(Icons.refresh, size: 30),
                ),

                // 3. Tombol Tambah (Hijau)
                ElevatedButton(
                  onPressed: () => _updateState(() => _controller.increment()),
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(20),
                    backgroundColor: const Color.fromARGB(255, 154, 184, 179),
                    foregroundColor: Colors.white,
                  ),
                  child: const Icon(Icons.add, size: 30),
                ),
              ],
            ),

            const Divider(thickness: 2, height: 40),

            // --- BAGIAN 4: RIWAYAT AKTIVITAS ---
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Riwayat Aktivitas (Max 5):", 
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
              ),
            ),
            const SizedBox(height: 10),
            
            Expanded(
              child: ListView.builder(
                itemCount: _controller.history.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 1,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      leading: const Icon(Icons.access_time_filled, color: Colors.blueGrey),
                      title: Text(
                        _controller.history[index],
                        style: const TextStyle(fontSize: 13, fontFamily: 'Monospace'),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
