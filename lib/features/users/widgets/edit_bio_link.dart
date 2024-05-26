import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictok_clone/constants/gaps.dart';
import 'package:tictok_clone/constants/sizes.dart';
import 'package:tictok_clone/features/users/view_models/user_view_model.dart';
import 'package:tictok_clone/features/utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EditBioLinkBottomSheet extends ConsumerStatefulWidget {
  final String bio;
  final String link;

  const EditBioLinkBottomSheet({
    super.key,
    required this.bio,
    required this.link,
  });

  @override
  EditBioLinkBottomSheetState createState() => EditBioLinkBottomSheetState();
}

class EditBioLinkBottomSheetState
    extends ConsumerState<EditBioLinkBottomSheet> {
  late final TextEditingController _bioTextController;
  late final TextEditingController _linkTextController;

  @override
  void initState() {
    super.initState();
    _bioTextController = TextEditingController(text: widget.bio);
    _linkTextController = TextEditingController(text: widget.link);
  }

  void closeModalBottomSheet() {
    Navigator.of(context).pop();
  }

  void _onStopWriting() {
    FocusScope.of(context).unfocus();
  }

  Future<void> _onSaveProfile() async {
    final newBio = _bioTextController.text;
    final newLink = _linkTextController.text;

    await ref.read(usersProvider.notifier).onProfileUpload({
      "bio": newBio,
      "link": newLink,
    });

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: _onStopWriting,
      child: Container(
        height: size.height * 0.8,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizes.size10),
        ),
        child: Scaffold(
          backgroundColor:
              isDarkMode(context) ? Colors.grey.shade900 : Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text(
              "Edit Profile",
              style: TextStyle(
                fontSize: Sizes.size18,
                color:
                    isDarkMode(context) ? Colors.white : Colors.grey.shade900,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => _onSaveProfile(),
                child: Text(
                  "Save",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.v10,
                const Text(
                  "🙂 Bio",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gaps.v10,
                SizedBox(
                  height: 120,
                  child: TextField(
                    controller: _bioTextController,
                    maxLines: null,
                    minLines: null,
                    expands: true,
                    textInputAction: TextInputAction.newline,
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(Sizes.size10),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                      ),
                      focusColor: Theme.of(context).primaryColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          Sizes.size4,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ),
                  ),
                ),
                Gaps.v10,
                const Text(
                  "🔗 Link",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gaps.v10,
                SizedBox(
                  height: 70,
                  child: TextField(
                    controller: _linkTextController,
                    maxLines: null,
                    minLines: null,
                    expands: true,
                    textInputAction: TextInputAction.newline,
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(Sizes.size10),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                      ),
                      focusColor: Theme.of(context).primaryColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          Sizes.size4,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
