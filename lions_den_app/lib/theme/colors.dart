import 'package:flutter/material.dart';

final shaderPrimary = gradientPrimary.createShader(
  const Rect.fromLTWH(
    0.0,
    0.0,
    200.0,
    70.0,
  ),
);

const gradientPrimary = LinearGradient(
  colors: [
    lightGreen,
    gradientBlue,
    // gradientGreen,
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
const gradientAccept = LinearGradient(
  colors: [
    greenLight,
    green,
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
const gradientDecline = LinearGradient(
  colors: [
    redLight,
    red,
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const gunMetal = Color(0xff252627);
const gradientGreen = Color(0xffA6CFAD);
const gradientBlue = Color(0xff28AFB0);

const red = Color(0xffFB4D3D);
const redLight = Color(0xffEB7F75);
const green = Color(0xff599B64);
const greenLight = Color(0xff6AC178);

const unbleachedSilk = Color(0xfff9dec9);
const melon = Color(0xffe9afa3);
const slateGray = Color(0xff607d8b);
const electricBlue = Color(0xff90f1ef);
const electricBlue2 = Color(0xff47C9C6);
const lightGreen = Color(0xff7bf1a8);
