import 'package:flutter/material.dart';

class GameOverMenu extends StatelessWidget {
  final VoidCallback onRestart;

  const GameOverMenu({Key? key, required this.onRestart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Game Over',
            style: TextStyle(
              fontSize: 48.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onRestart,
            child: const Text('Restart'),
          ),
        ],
      ),
    );
  }
}
