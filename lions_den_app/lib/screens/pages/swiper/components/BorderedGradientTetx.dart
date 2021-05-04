import 'package:flutter/material.dart';
import 'package:lions_den_app/theme/colors.dart';

class GradientTextWithBorder extends StatelessWidget {
  final String text;
  final double fontSize;
  const GradientTextWithBorder({
    this.text,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => shaderPrimary,
      child: Text(
        text,
        style: TextStyle(
          letterSpacing: 1,
          shadows: [
            Shadow(blurRadius: 0, color: gunMetal, offset: Offset(1, 1))
          ],
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: fontSize ?? 30,
        ),
      ),
    );
    return Stack(
      children: [
        Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: fontSize ?? 30,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 4
              ..color = gunMetal
              ..style = PaintingStyle.stroke,
          ),
        ),
        ShaderMask(
          shaderCallback: (bounds) => shaderPrimary,
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: fontSize ?? 30,
            ),
          ),
        ),
      ],
    );
  }
}
