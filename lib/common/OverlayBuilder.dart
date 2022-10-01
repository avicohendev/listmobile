import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:listmobile/common/widgets/overlaySpinner.dart';

class OverlayBuilder {
  static OverlayEntry? entry;
  static void showOverlay(BuildContext context) {
    final overlay = Overlay.of(context);
    final width = MediaQuery.of(context).size.width;
    entry = OverlayEntry(
      builder: ((context) => Positioned(
            width: width,
            height: MediaQuery.of(context).size.height,
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 2,
                sigmaY: 2,
              ),
              child: const OverlaySpinner(),
            ),
          )),
    );

    overlay!.insert(entry!);
  }

  static void hideOverlay() {
    entry?.remove();
  }
}
