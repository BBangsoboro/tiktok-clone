import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tictok_clone/constants/gaps.dart';
import 'package:tictok_clone/constants/sizes.dart';
import 'package:tictok_clone/features/videos/views/video_preview_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VideoRecordingScreen extends StatefulWidget {
  static const String routeName = "postVideo";
  static const String routeURL = "/upload";
  const VideoRecordingScreen({super.key});

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  bool _hasPermission = false;
  bool _isSelfieMode = false;
  late CameraController _cameraController;
  late final AnimationController _buttonAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 200,
    ),
  );

  late final Animation<double> _buttonAnimation =
      Tween(begin: 1.0, end: 1.3).animate(_buttonAnimationController);

  late final AnimationController _progressAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(seconds: 10),
    lowerBound: 0.0,
    upperBound: 1.0,
  );

  late FlashMode _flashMode;

  // code challenge
  late double _minZoomLevel;
  late double _maxZoomLevel;

  double _zoomCurrentLevel = 1.0;

  late final bool _noCamera = kDebugMode && Platform.isIOS;

  Future<void> initCamera() async {
    final cameras = await availableCameras();

    if (cameras.isEmpty) {
      return;
    }

    _cameraController = CameraController(
      cameras[_isSelfieMode ? 1 : 0],
      ResolutionPreset.ultraHigh,
      enableAudio: false,
    );

    await _cameraController.initialize();

    await _cameraController.prepareForVideoRecording();

    _flashMode = _cameraController.value.flashMode;

    _maxZoomLevel = await _cameraController.getMaxZoomLevel();
    _minZoomLevel = await _cameraController.getMinZoomLevel();

    _zoomCurrentLevel = _minZoomLevel;

    await _cameraController.setZoomLevel(5.0);
  }

  Future<void> _toggleSelfieMode() async {
    _isSelfieMode = !_isSelfieMode;
    await initCamera();
    setState(() {});
  }

  Future<void> _setFlashMode(FlashMode newFlashMode) async {
    await _cameraController.setFlashMode(newFlashMode);

    _flashMode = newFlashMode;
    setState(() {});
  }

  Future<void> initPermission() async {
    final cameraPermission = await Permission.camera.request();
    final micPermission = await Permission.microphone.request();

    final cameraDenied =
        cameraPermission.isDenied || cameraPermission.isPermanentlyDenied;
    final micDenied =
        micPermission.isDenied || micPermission.isPermanentlyDenied;

    if (!cameraDenied && !micDenied) {
      _hasPermission = true;
      await initCamera();
    } else {
      _hasPermission = false;
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    if (!_noCamera) {
      initPermission();
    } else {
      setState(() {
        _hasPermission = true;
      });
    }
    WidgetsBinding.instance.addObserver(this);
    _progressAnimationController.addListener(() {
      setState(() {});
    });
    _progressAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _stopRecording();
      }
    });
  }

  @override
  void dispose() {
    if (!_noCamera) {
      _cameraController.dispose();
    }
    _buttonAnimationController.dispose();
    _progressAnimationController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (_noCamera) return;
    if (!_hasPermission) return;
    if (state == AppLifecycleState.inactive) {
      if (!_cameraController.value.isInitialized) return;
      _cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      await initCamera();
      setState(() {});
    }
  }

  Future<void> _onPanZoomUpdate(DragUpdateDetails details) async {
    final zoomMoveDy = details.delta.dy;

    if (zoomMoveDy > 0) {
      _zoomCurrentLevel = _zoomCurrentLevel <= _minZoomLevel
          ? _minZoomLevel
          : _zoomCurrentLevel - 0.05;
    } else if (zoomMoveDy < 0) {
      _zoomCurrentLevel = _zoomCurrentLevel >= _maxZoomLevel
          ? _maxZoomLevel
          : _zoomCurrentLevel + 0.05;
    } else {
      return;
    }

    await _cameraController.setZoomLevel(_zoomCurrentLevel);

    setState(() {});

    print("_zoomCurrentLevel : $_zoomCurrentLevel");
  }

  Future<void> _startRecording(TapDownDetails details) async {
    if (_cameraController.value.isRecordingVideo) return;

    await _cameraController.startVideoRecording();
    _buttonAnimationController.forward();
    _progressAnimationController.forward();
  }

  Future<void> _stopRecording() async {
    if (!_cameraController.value.isRecordingVideo) return;

    _progressAnimationController.reset();
    _buttonAnimationController.reverse();

    final file = await _cameraController.stopVideoRecording();

    if (!mounted) return;

    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            VideoPreviewScreen(
          video: file,
          isPicked: false,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final tween =
              Tween(begin: const Offset(1.0, 0.0), end: const Offset(0.0, 0.0))
                  .chain(CurveTween(curve: Curves.ease));

          return SlideTransition(
              position: animation.drive(tween), child: child);
        },
      ),
    );

    print("=====================================================");
    print(file.name);
    print(file.path);
  }

  Future<void> _onPickVideoPressed() async {
    final video = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (video == null) return;

    if (!mounted) return;

    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            VideoPreviewScreen(
          video: video,
          isPicked: true,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final tween =
              Tween(begin: const Offset(1.0, 0.0), end: const Offset(0.0, 0.0))
                  .chain(CurveTween(curve: Curves.ease));

          return SlideTransition(
              position: animation.drive(tween), child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: !_hasPermission
            ? const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Initializing...",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Sizes.size20,
                    ),
                  ),
                  Gaps.v20,
                  CircularProgressIndicator.adaptive()
                ],
              )
            : Stack(
                alignment: Alignment.center,
                children: [
                  if (!_noCamera && _cameraController.value.isInitialized)
                    CameraPreview(_cameraController),
                  const Positioned(
                    top: Sizes.size28,
                    left: Sizes.size10,
                    child: CloseButton(
                      color: Colors.white,
                    ),
                  ),
                  if (!_noCamera)
                    Positioned(
                      top: Sizes.size80,
                      right: 0,
                      child: Column(
                        children: [
                          IconButton(
                            onPressed: _toggleSelfieMode,
                            color: Colors.white,
                            icon: const Icon(Icons.cameraswitch),
                          ),
                          Gaps.v10,
                          IconButton(
                            onPressed: () => _setFlashMode(FlashMode.off),
                            color: _flashMode == FlashMode.off
                                ? Colors.amber.shade200
                                : Colors.white,
                            icon: const Icon(Icons.flash_off_rounded),
                          ),
                          Gaps.v10,
                          IconButton(
                            onPressed: () => _setFlashMode(FlashMode.always),
                            color: _flashMode == FlashMode.always
                                ? Colors.amber.shade200
                                : Colors.white,
                            icon: const Icon(Icons.flash_on_rounded),
                          ),
                          Gaps.v10,
                          IconButton(
                            onPressed: () => _setFlashMode(FlashMode.auto),
                            color: _flashMode == FlashMode.auto
                                ? Colors.amber.shade200
                                : Colors.white,
                            icon: const Icon(Icons.flash_auto_rounded),
                          ),
                          Gaps.v10,
                          IconButton(
                            onPressed: () => _setFlashMode(FlashMode.torch),
                            color: _flashMode == FlashMode.torch
                                ? Colors.amber.shade200
                                : Colors.white,
                            icon: const Icon(Icons.flashlight_on_rounded),
                          ),
                        ],
                      ),
                    ),
                  Positioned(
                    bottom: Sizes.size40,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        const Spacer(),
                        GestureDetector(
                          onPanUpdate: (details) => {_onPanZoomUpdate(details)},
                          onTapDown: _startRecording,
                          onTapUp: (details) => _stopRecording(),
                          onPanEnd: (details) => _stopRecording(),
                          child: ScaleTransition(
                            scale: _buttonAnimation,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: Sizes.size80 + Sizes.size10,
                                  height: Sizes.size80 + Sizes.size10,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: Sizes.size6,
                                    value: _progressAnimationController.value,
                                  ),
                                ),
                                Container(
                                  width: Sizes.size80,
                                  height: Sizes.size80,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red.shade400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: IconButton(
                              onPressed: () => _onPickVideoPressed(),
                              icon: const FaIcon(
                                FontAwesomeIcons.image,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
