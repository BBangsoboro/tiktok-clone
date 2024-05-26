import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tictok_clone/features/authentication/view_models/signup_view_model.dart';
import 'package:tictok_clone/features/users/models/user_profile_model.dart';
import 'package:tictok_clone/features/users/repos/user_repository.dart';

class UserProfileViewModel extends AsyncNotifier<UserProfileModel> {
  late final UserRepository _userRepository;
  late final AuthenticationRepository _authenticationRepository;

  @override
  FutureOr<UserProfileModel> build() async {
    _userRepository = ref.read(userRepo);
    _authenticationRepository = ref.read(authRepo);

    if (_authenticationRepository.isLoggedIn) {
      final profile = await _userRepository
          .findProfile(_authenticationRepository.user!.uid);
      if (profile != null) {
        return UserProfileModel.fromJson(profile);
      }
    }
    return UserProfileModel.empty();
  }

  Future<void> createProfile(UserCredential credential) async {
    if (credential.user == null) {
      throw Exception("Account not created");
    }

    state = const AsyncValue.loading();

    final additionalUserInfo = ref.read(signUpForm);

    final profile = UserProfileModel(
      hasAvatar: false,
      bio: "undefined",
      link: "undefined",
      email: credential.user!.email ?? "anon@anon.com",
      displayName: credential.user!.displayName ?? "Anon",
      uid: credential.user!.uid,
      username: additionalUserInfo['username'],
      birthday: additionalUserInfo['birthday'],
    );

    await _userRepository.createProfile(profile);

    state = AsyncValue.data(
      profile,
    );
  }

  Future<void> onAvatarUpload() async {
    if (state.value == null) return;

    state = AsyncValue.data(state.value!.copyWith(hasAvatar: true));
    await _userRepository.updateUser(state.value!.uid, {"hasAvatar": true});
  }

  Future<void> onProfileUpload(Map<String, dynamic> updateData) async {
    if (state.value == null) return;

    final newState = state.value!.toJson();

    for (var entry in updateData.entries) {
      newState[entry.key] = entry.value;
    }

    state = AsyncValue.data(UserProfileModel.fromJson(newState));
    await _userRepository.updateUser(state.value!.uid, updateData);
  }
}

final usersProvider =
    AsyncNotifierProvider<UserProfileViewModel, UserProfileModel>(
        () => UserProfileViewModel());
