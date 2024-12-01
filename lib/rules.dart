import 'package:flutter/material.dart';
import 'package:flame_audio/flame_audio.dart'; // Untuk menambahkan suara

class RulesPage extends StatelessWidget {
  // Fungsi untuk memainkan suara klik
  void _playClickSound() {
    FlameAudio.play('Click.wav'); // Memainkan suara klik
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background yang sama dengan menu utama
          Positioned.fill(
            child: Image.asset(
              'assets/images/menu.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Menambahkan Card yang berisi peraturan permainan
          Positioned(
            top: 100,
            left: 30,
            right: 30,
            child: Card(
              color: Colors.white.withOpacity(0.8), // Warna kartu dengan transparansi
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Judul kartu
                    Text(
                      'Cara Main',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 20),
                    // Teks peraturan permainan
                    Text(
                      '• Ambil semua buah, hindari buah jatuh\n'
                      '• Cetak score tertinggi\n'
                      '• Have fun!',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Tombol kembali ke menu utama menggunakan gambar back.png
          Positioned(
            bottom: 30,
            left: 30,
            child: GestureDetector(
              onTap: () {
                _playClickSound(); // Memainkan suara klik
                // Navigasi kembali ke halaman utama
                Navigator.pop(context);
              },
              child: Image.asset(
                'assets/images/back.png',  // Gambar untuk tombol kembali
                width: 60,  // Ukuran gambar back
                height: 60,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
