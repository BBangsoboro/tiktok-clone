import 'package:flutter/widgets.dart';

// class VideoConfig extends ChangeNotifier {
//   bool autoMute = true;

//   void toggleAutoMute() {
//     autoMute = !autoMute;
//     notifyListeners();
//   }
// }

// final videoConfig = VideoConfig();

// final videoConfig = ValueNotifier(false);

class VideoConfig extends ChangeNotifier {
  bool isMute = false;
  bool isAutoplay = false;

  void toggleIsMute() {
    isMute = !isMute;
    notifyListeners();
  }

  void toggleAutoplay() {
    isAutoplay = !isAutoplay;
    notifyListeners();
  }
}
