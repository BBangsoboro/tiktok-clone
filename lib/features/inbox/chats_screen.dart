import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tictok_clone/constants/sizes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tictok_clone/features/inbox/chat_detail_screen.dart';

class ChatsScreen extends StatefulWidget {
  static const String routeName = "chat";
  static const String routeURL = "/chat";
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();

  final List<int> _items = [];

  final Duration _duration = const Duration(milliseconds: 300);

  void _addItem() {
    if (_key.currentState != null) {
      _key.currentState!.insertItem(
        0,
        duration: _duration,
      );
      _items.add(_items.length);
    }
  }

  void _deleteItem(int index) {
    if (_key.currentState != null) {
      _key.currentState!.removeItem(
        index,
        (context, animation) => SizeTransition(
          sizeFactor: animation,
          child: _makeTile(index),
        ),
        duration: _duration,
      );
      _items.removeAt(index);
    }
  }

  void _onChatTap(int index) {
    // Navigator.of(context).push(
    //   PageRouteBuilder(
    //     pageBuilder: (context, animation, secondaryAnimation) =>
    //         const ChatDetailScreen(),
    //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //       var curve = Curves.ease;
    //       var curveTween = CurveTween(curve: curve);

    //       const begin = Offset(1.0, 0.0);
    //       const end = Offset(0.0, 0.0);

    //       final tween = Tween(begin: begin, end: end).chain(curveTween);

    //       return SlideTransition(
    //           position: animation.drive(tween), child: child);
    //     },
    //     fullscreenDialog: true,
    //   ),
    // );
    context.pushNamed(
      ChatDetailScreen.routeName,
      params: {"chatId": "$index"},
    );
  }

  Widget _makeTile(int index) {
    return ListTile(
      onLongPress: () => {_deleteItem(index)},
      onTap: () => {_onChatTap(index)},
      leading: const CircleAvatar(
        radius: 30,
        foregroundImage: AssetImage("assets/images/BBansoboro.jpg"),
        child: Text("Me"),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "Lynn ($index)",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "2:16 PM",
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: Sizes.size12,
            ),
          ),
        ],
      ),
      subtitle: const Text("Don't forget to make video."),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.grey.shade200,
        elevation: 1,
        title: const Text("Direct Messages"),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const FaIcon(FontAwesomeIcons.plus),
          ),
        ],
        centerTitle: true,
      ),
      body: AnimatedList(
        key: _key,
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size10,
        ),
        itemBuilder: (BuildContext context, int index, animation) {
          return FadeTransition(
            key: UniqueKey(),
            opacity: animation,
            child: SizeTransition(
              sizeFactor: animation,
              child: _makeTile(index),
            ),
          );
        },
      ),
    );
  }
}
