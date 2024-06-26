import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:tictok_clone/common/widgets/video_configuration/video_config.dart';
import 'package:tictok_clone/constants/gaps.dart';
import 'package:tictok_clone/constants/sizes.dart';
import 'package:tictok_clone/features/videos/view_models/playback_config_vm.dart';
import 'package:tictok_clone/features/videos/widgets/video_button.dart';
import 'package:tictok_clone/features/videos/widgets/video_comments.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VideoPost extends ConsumerStatefulWidget {
  final Function onVideoFinished;
  final int index;

  const VideoPost(
      {super.key, required this.onVideoFinished, required this.index});

  @override
  ConsumerState<VideoPost> createState() => VideoPostState();
}

class VideoPostState extends ConsumerState<VideoPost>
    with SingleTickerProviderStateMixin {
  late final VideoPlayerController _videoPlayerController;
  final Duration _animatedDuration = const Duration(milliseconds: 200);
  late final AnimationController _animationController;

  bool _isPaused = false;
  bool _isSeeMore = false;
  bool _isMute = false;
  bool _muteInput = false;

  // bool _isMute = false;

  // void _onMute() async {
  //   setState(() {
  //     _isMute = !_isMute;
  //   });

  //   if (_isMute) {
  //     await _videoPlayerController.setVolume(50);
  //   } else {
  //     await _videoPlayerController.setVolume(0);
  //   }
  // }

  void _onVideoChange() {
    if (_videoPlayerController.value.isInitialized) {
      if (_videoPlayerController.value.duration ==
          _videoPlayerController.value.position) {
        widget.onVideoFinished();
      }
    }
  }

  void _initVideoPlayer() async {
    _videoPlayerController =
        VideoPlayerController.asset("assets/videos/video.mp4");
    await _videoPlayerController.initialize();
    setState(() {});
    await _videoPlayerController.setLooping(true);
    if (kIsWeb) {
      await _videoPlayerController.setVolume(0);
    }
    _videoPlayerController.addListener(_onVideoChange);
  }

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
    _animationController = AnimationController(
      vsync: this,
      duration: _animatedDuration,
      lowerBound: 1.0,
      upperBound: 1.5,
      value: 1.5,
    );
  }

  Future<void> _onPlaybackConfigChanged() async {
    if (!mounted) return;

    final muted = ref.read(playbackConfigProvider).muted;
    ref.read(playbackConfigProvider.notifier).setMuted(!muted);

    if (muted) {
      _videoPlayerController.setVolume(0.0);
    } else {
      _videoPlayerController.setVolume(1.0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (!mounted) return;
    if (info.visibleFraction == 1 &&
        !_isPaused &&
        !_videoPlayerController.value.isPlaying) {
      if (ref.read(playbackConfigProvider).autoplay) {
        _videoPlayerController.play();
      }
    }

    if (_videoPlayerController.value.isPlaying && info.visibleFraction == 0) {
      _onTogglePause();
    }
  }

  void _onTogglePause() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      _animationController.reverse();
    } else {
      _videoPlayerController.play();
      _animationController.forward();
    }
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  void _onTapSeeMore() {
    setState(() {
      _isSeeMore = !_isSeeMore;
    });
  }

  void _onCommentsTap() async {
    if (_videoPlayerController.value.isPlaying) {
      _onTogglePause();
    }

    await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (context) => const VideoComments(),
    );

    _onTogglePause();
  }

  void _userChangedVolume() async {
    _muteInput = true;
    _isMute = !_isMute;

    if (_isMute) {
      await _videoPlayerController.setVolume(0.0);
    } else {
      await _videoPlayerController.setVolume(1.0);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key("${widget.index}"),
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
        children: [
          Positioned.fill(
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(_videoPlayerController)
                : Container(color: Colors.black),
          ),
          Positioned.fill(
              child: GestureDetector(
            onTap: _onTogglePause,
          )),
          Positioned.fill(
            child: IgnorePointer(
              child: Center(
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animationController.value,
                      child: child,
                    );
                  },
                  child: AnimatedOpacity(
                    opacity: _isPaused ? 1 : 0,
                    duration: _animatedDuration,
                    child: const FaIcon(
                      FontAwesomeIcons.play,
                      color: Colors.white,
                      size: Sizes.size52,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: Sizes.size20,
            top: Sizes.size40,
            child: IconButton(
              onPressed: () {
                _userChangedVolume();
              },
              icon: FaIcon(
                !_muteInput
                    ? (ref.watch(playbackConfigProvider).muted
                        ? FontAwesomeIcons.volumeXmark
                        : FontAwesomeIcons.volumeHigh)
                    : (_isMute
                        ? FontAwesomeIcons.volumeXmark
                        : FontAwesomeIcons.volumeHigh),
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 10,
            right: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "@gmapsfun",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Sizes.size20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v10,
                const Text(
                  'This is my house in Thailand!!!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Sizes.size16,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        "#googleearth #googlemaps #googlefoods",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: Sizes.size16,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: _isSeeMore
                            ? TextOverflow.visible
                            : TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: _onTapSeeMore,
                        child: Container(
                          child: Text(
                            _isSeeMore ? "Hide" : "See more",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: Sizes.size16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
              bottom: 80,
              right: 20,
              child: Column(
                children: [
                  // GestureDetector(
                  //   onTap: _onMute,
                  //   child: AnimatedCrossFade(
                  //     crossFadeState: _isMute
                  //         ? CrossFadeState.showSecond
                  //         : CrossFadeState.showFirst,
                  //     duration: const Duration(milliseconds: 300),
                  //     firstChild: const VideoButton(
                  //       icon: FontAwesomeIcons.volumeXmark,
                  //       text: "",
                  //     ),
                  //     secondChild: const VideoButton(
                  //       icon: FontAwesomeIcons.volumeHigh,
                  //       text: "",
                  //     ),
                  //   ),
                  // ),
                  const Column(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        foregroundImage:
                            AssetImage("assets/images/BBansoboro.jpg"),
                        child: Text("test"),
                      ),
                      Text(
                        "test",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Sizes.size16,
                        ),
                      ),
                    ],
                  ),
                  Gaps.v16,
                  const VideoButton(
                    icon: FontAwesomeIcons.solidHeart,
                    text: "2.9M",
                  ),
                  Gaps.v16,
                  GestureDetector(
                    onTap: _onCommentsTap,
                    child: const VideoButton(
                      icon: FontAwesomeIcons.solidComment,
                      text: "33.0K",
                    ),
                  ),
                  Gaps.v16,
                  const VideoButton(
                    icon: FontAwesomeIcons.share,
                    text: "Share",
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
