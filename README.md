# LogBook App - Mobile Programming (Proyek 4)

**Nama:** Qlio Amanda Febriany  
**NIM:** 087  
**Kelas:** D3 Teknik Informatika - 2C  
**Modul:** 1 - Fondasi, Setup & Prinsip SRP

---

## 1. Self-Reflection: Prinsip SRP
**Pertanyaan:** "Bagaimana prinsip SRP membantu kalian saat harus menambah fitur History Logger tadi?"

**Jawaban:**
Penerapan *Single Responsibility Principle* (SRP) sangat membantu saya menjaga kebersihan kode. Saat menambahkan fitur History Logger, saya tidak perlu mengotori file UI (`counter_view.dart`) dengan logika bisnis.

Tanpa SRP, logika seperti format waktu (`DateTime`), penambahan data ke List, dan pembatasan jumlah riwayat (maksimal 5) akan menumpuk di file View, membuat kode sulit dibaca (*Spaghetti Code*). Dengan SRP, saya memisahkan tanggung jawab:
* **Controller (`counter_controller.dart`):** Fokus menangani logika data (List history, limit 5 data, dan format timestamp).
* **View (`counter_view.dart`):** Fokus hanya untuk menampilkan data yang sudah diolah oleh Controller.
Hal ini membuat debugging jauh lebih mudah; jika ada kesalahan logika hitungan atau format jam, saya hanya perlu memeriksa Controller tanpa takut merusak tampilan antarmuka.

---

## 2. Integritas AI: Log LLM (Wajib)
Berikut adalah bukti interaksi saya dengan AI sebagai *Reviewer* dan *Arsitek*, bukan sekadar *Copy-Paste*.

| Komponen | Isian Mahasiswa |
| :--- | :--- |
| **Pertanyaan (Prompt)** | "Saya punya `CounterController` di Dart. Saya ingin membuat fitur history log di mana data baru muncul paling atas, tapi daftarnya tidak boleh lebih dari 5 item. Tolong berikan logika murni Dart-nya saja tanpa UI." |
| **Jawaban AI (Intisari)** | AI menyarankan menggunakan `List.add()` untuk menambah data baru, dan menggunakan logika `if (list.length > 5) list.removeAt(0)` untuk menghapus data terlama. |
| **The Fact Check (Validasi)** | **Analisa:** Saya mengecek saran AI. Penggunaan `add()` ternyata menaruh data di urutan paling bawah (indeks terakhir). Padahal untuk Logbook, data terbaru harusnya muncul di paling atas agar User Experience (UX) lebih baik. <br>**Koreksi:** Saya menolak saran `add()` dan mengubahnya menjadi `insert(0, data)` agar data masuk ke indeks pertama. |
| **The Twist (Modifikasi)** | **Kreativitas SRP:** AI awalnya menyarankan untuk menaruh format `DateTime.now()` di dalam file View agar coding lebih cepat. Saya memodifikasinya dengan memindahkan seluruh logika format waktu ke dalam fungsi `_addHistory` di Controller. Ini saya lakukan demi mematuhi prinsip SRP agar View tetap bersih dari logika. |

---

## 3. Lesson Learnt (Refleksi Akhir)
Tiga poin utama yang saya pelajari dari pengerjaan Modul 1 ini:

1.  **Konsep Baru:** Saya memahami bahwa memisahkan "Otak" (Controller) dan "Wajah" (View) adalah kunci arsitektur aplikasi yang rapi dan *scalable*.
2.  **Kemenangan Kecil:** Berhasil mengimplementasikan logika *Smart Decrement* (nilai mentok di 0, tidak macet saat dikurang step besar) dan logika *History Limiter* (otomatis hapus data lama jika > 5) yang berjalan lancar di HP fisik.
3.  **Target Berikutnya:** Saya ingin mempelajari cara agar data riwayat ini bisa disimpan permanen (Persistence) di penyimpanan HP, agar data tidak hilang saat aplikasi ditutup total.