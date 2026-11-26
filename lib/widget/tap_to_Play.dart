
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class TapToPlay extends StatelessWidget {
  final bool animatePrompt;

  const TapToPlay({
    super.key,
    this.animatePrompt = true,
  });

  @override
  Widget build(BuildContext context) {
    final prompt = const IgnorePointer(
      child: Text(
        'TAP TO PLAY',
        style: TextStyle(
          color: Color(0xFF2387FC),
          fontWeight: FontWeight.bold,
          fontSize: 38,
          letterSpacing: 4,
        ),
      ),
    );

    if (!animatePrompt) {
      return prompt;
    }

    return prompt
        .animate(
      onPlay: (controller) => controller.repeat(reverse: true),
    )
        .scale(
      begin: const Offset(1.0, 1.0),
      end: const Offset(1.2, 1.2),
      duration: const Duration(milliseconds: 500),
    );
  }
}
