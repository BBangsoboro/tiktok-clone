import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tictok_clone/features/users/view_models/avatar_view_model.dart';

class Avatar extends ConsumerWidget {
  final String name;
  final bool hasAvatar;
  final String uid;

  const Avatar({
    super.key,
    required this.name,
    required this.hasAvatar,
    required this.uid,
  });

  Future<void> _onAvatarTap(WidgetRef ref) async {
    final xfile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 40,
      maxHeight: 150,
      maxWidth: 150,
    );

    if (xfile != null) {
      final file = File(xfile.path);
      await ref.read(avatarProvider.notifier).uploadAvatar(file);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(avatarProvider).when(
          loading: () => Container(
            width: 50,
            height: 50,
            alignment: Alignment.center,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: const CircularProgressIndicator(),
          ),
          error: (error, stackTrace) => Center(child: Text(error.toString())),
          data: (data) => GestureDetector(
            onTap: () => _onAvatarTap(ref),
            child: CircleAvatar(
              radius: 50,
              foregroundColor: Colors.black,
              foregroundImage: hasAvatar
                  ? NetworkImage(
                      'https://firebasestorage.googleapis.com/v0/b/tic-tok-abc.appspot.com/o/avatars%2F$uid?alt=media&token=7a1d3a7f-d3af-4dac-a0e0-3edddb55f090&haha=${DateTime.now().toString()}')
                  : null,
              child: Text(name),
            ),
          ),
        );
  }
}
