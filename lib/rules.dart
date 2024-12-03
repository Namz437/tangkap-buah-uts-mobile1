import 'package:flutter/material.dart';
import 'package:flame_audio/flame_audio.dart'; 

class RulesPage extends StatelessWidget {
  void _playClickSound() {
    FlameAudio.play('Click.wav'); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/menu.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 100,
            left: 30,
            right: 30,
            child: Card(
              color: Colors.white.withOpacity(0.8), 
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cara Main',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 20),
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
          Positioned(
            bottom: 30,
            left: 30,
            child: GestureDetector(
              onTap: () {
                _playClickSound(); 
                
                Navigator.pop(context);
              },
              child: Image.asset(
                'assets/images/back.png',  
                width: 60, 
                height: 60,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
