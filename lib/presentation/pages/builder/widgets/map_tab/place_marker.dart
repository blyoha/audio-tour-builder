import 'package:flutter/material.dart';

import '../../../../../theme/theme_constants.dart';

class PlaceMarker extends StatelessWidget {
  const PlaceMarker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.circle_rounded,
      shadows: [
        Shadow(
          color: Colors.black54,
          blurRadius: 4,
          offset: Offset(0, 1),
        )
      ],
      color: primaryColor,
    );
  }
}
