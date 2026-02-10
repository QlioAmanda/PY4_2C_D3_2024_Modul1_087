// File: lib/main.dart
// Nama : Qlio Amanda Febriany
// Nim : 241511087
// Kelas : 2C

import 'package:flutter/material.dart';
import 'counter_view.dart'; // PENTING: Impor CounterView

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Menghilangkan banner debug (opsional)
      title: 'Flutter SRP Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CounterView(),
    );
  }
}