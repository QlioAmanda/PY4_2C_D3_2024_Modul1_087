# LogBook App - Mobile Programming (Proyek 4)

**Nama:** Qlio Amanda Febriany
**NIM:** 241511087
**Kelas:** 2C - D3 Teknik Informatika
**Tanggal:** 10 Februari 2026

---

## 🏗️ Struktur Proyek (SRP)
Proyek ini menerapkan **Single Responsibility Principle (SRP)** untuk memisahkan logika bisnis dari antarmuka pengguna:
* **`counter_controller.dart` (Otak):** Menangani logika perhitungan angka, manipulasi list riwayat (tambah/hapus limit 5), dan pengaturan nilai step. Tidak ada kode UI di sini.
* **`counter_view.dart` (Wajah):** Bertugas menampilkan data, menangani interaksi pengguna (tombol, slider), validasi input (peringatan jika angka 0), dan menampilkan dialog/snack bar.
* **`main.dart` (Pintu Masuk):** Titik awal aplikasi yang memuat konfigurasi tema dan memanggil `CounterView`.

---

## 📝 Self-Reflection
**Pertanyaan:** "Bagaimana prinsip SRP membantu kalian saat harus menambah fitur History Logger tadi?"

**Jawaban:**
Penerapan SRP membuat proses penambahan fitur menjadi sangat terstruktur. Saat saya diminta menambahkan fitur *History Logger*, saya tidak perlu mengubah satu baris pun kode tampilan di `counter_view.dart` untuk urusan penyimpanan datanya.
Saya cukup fokus bekerja di `counter_controller.dart` untuk membuat List dan fungsi `_addHistory`. View hanya bertugas "meminta" data tersebut untuk ditampilkan. Hal ini membuat debugging jauh lebih mudah; jika data riwayat salah, saya tahu pasti kesalahannya ada di Controller, bukan di View.

---

## 🧠 Lesson Learnt (Refleksi Akhir)
3 Poin utama yang saya pelajari dari pengerjaan Modul 1:

1.  **Konsep Baru:** Saya memahami bahwa memisahkan "Otak" (Controller) dan "Wajah" (View) bukan hanya soal kerapian, tapi juga soal keamanan logika. Validasi interaksi sebaiknya dilakukan di View sebelum data dikirim ke Controller.
2.  **Kemenangan Kecil:** Berhasil mengimplementasikan logika *Smart Decrement* (validasi agar tidak minus) dengan dua lapisan: validasi visual di View (muncul peringatan) dan validasi logika di Controller.
3.  **Target Berikutnya:** Saya ingin mempelajari cara agar data riwayat ini bisa disimpan permanen (*Persistence*) di penyimpanan lokal HP, agar data tidak hilang saat aplikasi ditutup total.

---

## 🤖 Integritas AI: Log LLM
Berikut adalah rekam jejak penggunaan AI sebagai asisten coding yang kritis (sesuai aturan modul).

| Komponen | Isian Mahasiswa |
| :--- | :--- |
| **Pertanyaan (Prompt)** | "Bagaimana cara membuat validasi agar tombol kurang tidak berfungsi jika nilai 0 atau sisa nilai lebih kecil dari step, dan berikan peringatan pop-up UI?" |
| **Jawaban AI (Intisari)** | AI menyarankan menggunakan logika `if (value > 0)` sederhana di dalam fungsi tombol, lalu menggunakan widget `ScaffoldMessenger` standar. |
| **The Fact Check (Validasi)** | **Analisa:** Saya mengecek logika saran AI. Ternyata jika hanya mengecek `if (value > 0)`, pengguna masih bisa mendapatkan nilai minus (contoh: sisa saldo 3, tapi dikurang step 5). Logic AI kurang lengkap.<br>**Koreksi:** Saya menambahkan kondisi `else if (step > value)` agar tombol benar-benar aman dari nilai negatif dan memberikan pesan error yang spesifik. |
| **The Twist (Modifikasi)** | **Kreativitas:** Saya memodifikasi warna SnackBar menjadi **Oranye** (Peringatan 0) dan **Merah** (Error Step) agar pengguna langsung paham jenis kesalahannya secara visual. |
| --- | --- |
| **Pertanyaan (Prompt)** | "Bagaimana cara membuat Slider di Flutter untuk mengubah angka penambahan (step) dari 1 sampai 10?" |
| **Jawaban AI (Intisari)** | AI memberikan contoh kode Slider di mana variabel `_step` ditaruh di dalam `State` widget (View) dan langsung diubah pakai `setState`. |
| **The Fact Check (Validasi)** | **Analisa:** Saran AI berhasil secara visual, tapi melanggar prinsip SRP karena variabel `_step` (data logika) disimpan di file View, bukan di Controller.<br>**Koreksi:** Saya memindahkan variabel `int _step` ke dalam `CounterController` dan membuat fungsi setter `setStep(int value)` di sana agar View tetap bersih. |
| **The Twist (Modifikasi)** | **Kreativitas:** Saya memodifikasi tampilan Slider dengan menambahkan angka indikator di sebelahnya (contoh: '5/10') agar user tahu persis angka yang sedang dipilih, bukan sekadar menggeser bulatan. |
| --- | --- |
| **Pertanyaan (Prompt)** | "File View saya sudah 300 baris dan susah dibaca. Bagaimana cara memecahnya biar rapi tanpa merusak logic?" |
| **Jawaban AI (Intisari)** | AI menyarankan teknik *Extract Widget*, yaitu memecah bagian UI (seperti tombol dan kartu) menjadi class widget terpisah di file baru. |
| **The Fact Check (Validasi)** | **Analisa:** Ide bagus, tapi AI awalnya membuat widget baru di file terpisah-pisah yang bikin navigasi file jadi ribet buat tugas sekecil ini.<br>**Koreksi:** Saya memutuskan membuat widget-widget kecil tersebut (`TotalCard`, `HistoryList`) di file yang sama tapi di bagian bawah, agar kode tetap terorganisir namun tidak kebanyakan file. |
| **The Twist (Modifikasi)** | **Kreativitas:** Saya mengelompokkan widget berdasarkan fungsinya secara visual (Bagian Atas, Tengah, Bawah) dan memberi nama class yang deskriptif (bukan `Widget1`, tapi `StepControlCard`) supaya mudah dimengerti orang lain. |

---