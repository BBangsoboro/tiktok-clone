import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraFlashButton extends StatelessWidget {
  final CameraController cameraController;
  final FlashMode flashMode;

  const CameraFlashButton(
      {super.key, required this.cameraController, required this.flashMode});

  Future<void> _setFlashMode(FlashMode newFlashMode) async {
    await cameraController.setFlashMode(newFlashMode);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _setFlashMode(FlashMode.off),
      color: true ? Colors.amber.shade200 : Colors.white,
      icon: const Icon(Icons.flash_off_rounded),
    );
  }
}
