import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

class MyDecoration {
  // 
  static BoxDecoration backGroundGradiant() => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            SCREENCOLA,
            SCREENCOLB,
            SCREENCOLC,
            SCREENCOLD,
          ],
          stops: [0.1, 0.4, 0.7, 0.9],
        ),
      );
}
