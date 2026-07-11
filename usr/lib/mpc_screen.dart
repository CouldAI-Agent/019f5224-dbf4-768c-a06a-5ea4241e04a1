import 'package:flutter/material.dart';

class MpcScreen extends StatefulWidget {
  const MpcScreen({super.key});

  @override
  State<MpcScreen> createState() => _MpcScreenState();
}

class _MpcScreenState extends State<MpcScreen> {
  final List<String> padLabels = [
    'KICK', 'SNARE', 'HI-HAT', 'OPEN HAT',
    'CRASH', 'RIDE', 'CLAP', 'SNAP',
    'SAMPLE 1', 'SAMPLE 2', 'SAMPLE 3', 'SAMPLE 4',
    'CHORD 1', 'CHORD 2', 'BASS', 'SUB'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2B2B2B), // Vintage hardware grey
      appBar: AppBar(
        title: const Text(
          'BOOM BAP MACHINE',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
            color: Color(0xFFE0E0E0),
          ),
        ),
        backgroundColor: const Color(0xFF1E1E1E),
        centerTitle: true,
        elevation: 4,
        shadowColor: Colors.black,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Top Control Panel
            Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.black45, width: 2),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black54,
                    offset: Offset(0, 4),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildDisplayScreen('BPM: 85', 'SWING: 60%'),
                  Column(
                    children: [
                      _buildKnob('VOL'),
                      const SizedBox(height: 8),
                      _buildKnob('PITCH'),
                    ],
                  ),
                ],
              ),
            ),
            
            // Pad Grid
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: GridView.builder(
                    padding: const EdgeInsets.all(16.0),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 12.0,
                      mainAxisSpacing: 12.0,
                    ),
                    itemCount: 16,
                    itemBuilder: (context, index) {
                      return DrumPad(label: padLabels[index]);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDisplayScreen(String line1, String line2) {
    return Container(
      width: 140,
      height: 80,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: const Color(0xFF90A4AE), // Retro LCD screen color
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            line1,
            style: const TextStyle(
              fontFamily: 'Courier',
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            line2,
            style: const TextStyle(
              fontFamily: 'Courier',
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKnob(String label) {
    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF424242),
            boxShadow: [
              BoxShadow(
                color: Colors.black54,
                offset: Offset(2, 2),
                blurRadius: 2,
              )
            ],
          ),
          child: const Center(
            child: Icon(Icons.circle, size: 8, color: Colors.white54),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class DrumPad extends StatefulWidget {
  final String label;

  const DrumPad({super.key, required this.label});

  @override
  State<DrumPad> createState() => _DrumPadState();
}

class _DrumPadState extends State<DrumPad> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 50),
        decoration: BoxDecoration(
          color: _isPressed ? const Color(0xFFFF5252) : const Color(0xFFE0E0E0),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: Colors.black54,
            width: 2,
          ),
          boxShadow: _isPressed
              ? []
              : const [
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(0, 4),
                    blurRadius: 0,
                  ),
                ],
        ),
        transform: Matrix4.translationValues(
          0,
          _isPressed ? 4.0 : 0.0,
          0,
        ),
        child: Stack(
          children: [
            if (_isPressed)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x66FF5252),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
            Center(
              child: Text(
                widget.label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: _isPressed ? Colors.white : Colors.black54,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
