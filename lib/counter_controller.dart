// File: lib/counter_controller.dart
// Nama : Qlio Amanda Febriany
// Nim : 241511087
// Kelas : 2C

class CounterController {
  int _counter = 0;
  int _step = 1; // Task 1: Variabel Step
  final List<String> _history = []; // Task 2: List Riwayat

  // Getter
  int get value => _counter;
  int get step => _step;
  List<String> get history => _history;

  // Setter untuk Slider (Task 1)
  void setStep(int value) {
    _step = value;
  }

  // Logika History (Task 2)
  void _addHistory(String message) {
    String timestamp = "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}";
      
    // Insert di indeks 0 agar muncul paling atas
    _history.insert(0, "[$timestamp] $message");

    // Batasi hanya 5 data
    if (_history.length > 5) {
      _history.removeLast();
    }
  }

  void increment() {
    _counter += _step;
    _addHistory("Ditambah $_step");
  }

  void decrement() {
    // Opsional: Mencegah nilai minus
    if (_counter >= _step) {
      _counter -= _step;
      _addHistory("Dikurang $_step");
    }
  }

  void reset() {
    _counter = 0;
    _addHistory("Data di-reset");
  }
}