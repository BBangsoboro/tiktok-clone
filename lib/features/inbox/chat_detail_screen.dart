import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tictok_clone/constants/gaps.dart';
import 'package:tictok_clone/constants/sizes.dart';
import 'package:tictok_clone/features/utils.dart';

class ChatDetailScreen extends StatefulWidget {
  static const String routeName = "chatDetail";
  static const String routeURL = ":chatId";

  final String chatId;

  const ChatDetailScreen({super.key, required this.chatId});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final ScrollController _scrollController = ScrollController();

  void _onTap() {
    FocusScope.of(context).unfocus();
  }

  void _onSubmitted(String value) {}

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: Sizes.size10,
          leading: Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                radius: Sizes.size20,
                foregroundImage:
                    const AssetImage('assets/images/BBansoboro.jpg'),
                child: Text("Me (${widget.chatId})"),
              ),
              Positioned(
                bottom: -2,
                right: -3,
                child: Container(
                  height: Sizes.size18,
                  width: Sizes.size18,
                  decoration: BoxDecoration(
                    color: Colors.lightGreenAccent.shade700,
                    shape: BoxShape.circle,
                    border: const Border(
                      top: BorderSide(color: Colors.white, width: Sizes.size3),
                      bottom:
                          BorderSide(color: Colors.white, width: Sizes.size3),
                      left: BorderSide(color: Colors.white, width: Sizes.size3),
                      right:
                          BorderSide(color: Colors.white, width: Sizes.size3),
                    ),
                  ),
                ),
              ),
            ],
          ),
          title: Text(
            "me (${widget.chatId})",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text("Active now",
              style: TextStyle(
                color: Colors.grey.shade400,
              )),
          trailing: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                FontAwesomeIcons.flag,
                size: Sizes.size20,
              ),
              Gaps.h28,
              FaIcon(
                FontAwesomeIcons.ellipsis,
                size: Sizes.size20,
              )
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          GestureDetector(
            onTap: _onTap,
            child: Scrollbar(
              controller: _scrollController,
              child: ListView.separated(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(
                  vertical: Sizes.size20,
                  horizontal: Sizes.size14,
                ),
                itemBuilder: (context, index) {
                  final isMine = index % 2 == 0;
                  return Row(
                    key: UniqueKey(),
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: isMine
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(Sizes.size14),
                        decoration: BoxDecoration(
                          color: isMine
                              ? Colors.blue
                              : Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(
                              Sizes.size20,
                            ),
                            topRight: const Radius.circular(
                              Sizes.size20,
                            ),
                            bottomLeft: Radius.circular(
                              isMine ? Sizes.size20 : Sizes.size5,
                            ),
                            bottomRight: Radius.circular(
                              isMine ? Sizes.size5 : Sizes.size20,
                            ),
                          ),
                        ),
                        child: const Text(
                          "This is a message!",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Sizes.size16,
                          ),
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) => Gaps.v10,
                itemCount: 10,
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              width: MediaQuery.of(context).size.width,
              child: BottomAppBar(
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: Sizes.size48,
                        child: TextField(
                          onSubmitted: _onSubmitted,
                          minLines: null,
                          maxLines: null,
                          expands: true,
                          textInputAction: TextInputAction.newline,
                          cursorColor: Theme.of(context).primaryColor,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: Sizes.size6,
                                  horizontal: Sizes.size20),
                              filled: true,
                              fillColor: isDarkMode(context)
                                  ? Colors.grey.shade900
                                  : Colors.white,
                              hintText: "Send a message...",
                              hintStyle: TextStyle(
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.normal,
                              ),
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                    Sizes.size20,
                                  ),
                                  topRight: Radius.circular(
                                    Sizes.size20,
                                  ),
                                  bottomLeft: Radius.circular(
                                    Sizes.size20,
                                  ),
                                  bottomRight: Radius.circular(
                                    Sizes.size5,
                                  ),
                                ),
                              ),
                              suffixIcon: const Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(right: Sizes.size12),
                                    child: FaIcon(
                                      FontAwesomeIcons.faceLaugh,
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                    ),
                    Gaps.h10,
                    Container(
                      alignment: Alignment.center,
                      width: Sizes.size32,
                      height: Sizes.size32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isDarkMode(context)
                            ? Colors.grey.shade900
                            : Colors.grey.shade300,
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: FaIcon(
                          FontAwesomeIcons.solidPaperPlane,
                          size: Sizes.size16,
                          color: isDarkMode(context)
                              ? Colors.grey.shade300
                              : Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
