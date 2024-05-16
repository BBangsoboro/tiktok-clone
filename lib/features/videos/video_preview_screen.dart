import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:video_player/video_player.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path/path.dart';

class VideoPreviewScreen extends StatefulWidget {
  final XFile video;
  final bool isPicked;

  const VideoPreviewScreen(
      {super.key, required this.video, required this.isPicked});

  @override
  State<VideoPreviewScreen> createState() => _VideoPreviewScreenState();
}

class _VideoPreviewScreenState extends State<VideoPreviewScreen> {
  late final VideoPlayerController _videoPlayerController;

  bool _saveVideo = false;

  Future<void> _initVideo() async {
    _videoPlayerController =
        VideoPlayerController.file(File(widget.video.path));

    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    await _videoPlayerController.play();

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initVideo();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  Future<String> convertTempToMp4(String tempFilePath) async {
    final outputFilePath = tempFilePath.replaceAll('.temp', '.mp4');
    final ffmpeg = FlutterFFmpeg();

    await ffmpeg.execute('-i $tempFilePath $outputFilePath');

    return outputFilePath;
  }

  Future<void> _saveToGallery() async {
    if (_saveVideo) {
      return;
    }

    final mp4FilePath = await convertTempToMp4(widget.video.path);

    await GallerySaver.saveVideo(
      mp4FilePath,
      albumName: "TIkTok Clone!",
    );

    _saveVideo = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text('Preview video'), actions: [
        if (!widget.isPicked)
          IconButton(
            onPressed: _saveToGallery,
            icon: FaIcon(
              _saveVideo ? FontAwesomeIcons.check : FontAwesomeIcons.download,
            ),
          )
      ]),
      body: _videoPlayerController.value.isInitialized
          ? VideoPlayer(_videoPlayerController)
          : null,
    );
  }
}
