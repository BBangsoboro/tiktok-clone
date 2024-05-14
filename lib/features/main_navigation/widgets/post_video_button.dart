import 'package:flutter/material.dart';
import 'package:tictok_clone/constants/sizes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tictok_clone/features/utils.dart';

class PostVideoButton extends StatefulWidget {
  final Function onTap;
  final bool inverted;

  const PostVideoButton(
      {super.key, required this.onTap, required this.inverted});

  @override
  State<PostVideoButton> createState() => _PostVideoButtonState();
}

class _PostVideoButtonState extends State<PostVideoButton> {
  final GlobalKey _buttonGlobayKey = GlobalKey();
  double _scaleVal = 1.0;
  bool _isTapDown = false;
  bool _isInbox = false;

  void _onTapDown(TapDownDetails details) {
    _isTapDown = true;

    setState(() {
      _scaleVal = 1.2;
    });
  }

  void _onPanUdpate(DragUpdateDetails details) {
    if (!_isTapDown) return;

    final RenderBox renderBox =
        _buttonGlobayKey.currentContext!.findRenderObject() as RenderBox;

    final double width = renderBox.size.width;
    final double height = renderBox.size.height;
    final double panLocalDx = details.localPosition.dx;
    final double panLocalDy = details.localPosition.dy;

    final bool widthCondition = (panLocalDx > 0 && panLocalDx < width);
    final bool heightCondition = (panLocalDy > 0 && panLocalDy < height);

    (widthCondition && heightCondition) ? _isInbox = true : _isInbox = false;
  }

  void _onTapUp(TapUpDetails details) {
    if (!_isTapDown) return;
    _isTapDown = false;

    setState(() {
      _scaleVal = 1.0;
    });

    widget.onTap();
  }

  void _onPanEnd(DragEndDetails details) {
    if (!_isTapDown) return;
    _isTapDown = false;
    setState(() {
      _scaleVal = 1.0;
    });

    if (_isInbox) {
      widget.onTap();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: _buttonGlobayKey,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onPanUpdate: _onPanUdpate,
      onPanEnd: _onPanEnd,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 100),
        scale: _scaleVal,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              right: 17,
              child: Container(
                height: 30,
                width: 25,
                padding: const EdgeInsets.symmetric(horizontal: Sizes.size8),
                decoration: BoxDecoration(
                  color: const Color(0xFF61D4F0),
                  borderRadius: BorderRadius.circular(Sizes.size8),
                ),
              ),
            ),
            Positioned(
              left: 17,
              child: Container(
                height: 30,
                width: 25,
                padding: const EdgeInsets.symmetric(horizontal: Sizes.size8),
                decoration: BoxDecoration(
                  color: const Color(0xFFe5446c),
                  borderRadius: BorderRadius.circular(Sizes.size8),
                ),
              ),
            ),
            Container(
                height: 30,
                padding: const EdgeInsets.symmetric(horizontal: Sizes.size12),
                decoration: BoxDecoration(
                  color: widget.inverted
                      ? isDarkMode(context)
                          ? Colors.white
                          : Colors.black
                      : Colors.white,
                  borderRadius: BorderRadius.circular(Sizes.size6),
                ),
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.plus,
                    color: widget.inverted
                        ? isDarkMode(context)
                            ? Colors.black
                            : Colors.white
                        : Colors.black,
                    size: Sizes.size16,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
