import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tictok_clone/common/widgets/video_configuration/video_config.dart';
import 'package:tictok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tictok_clone/features/videos/view_models/playback_config_vm.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Localizations.override(
      context: context,
      locale: const Locale("ko"),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Settings"),
        ),
        body: ListView(
          children: [
            // ValueListenableBuilder(
            //   valueListenable: videoConfig,
            //   builder: (context, value, child) => SwitchListTile.adaptive(
            //     activeColor: Theme.of(context).primaryColor,
            //     value: value,
            //     onChanged: (value) {
            //       videoConfig.value = !videoConfig.value;
            //     },
            //     title: const Text("Auto Mute"),
            //     subtitle: const Text("Video will be muted by default."),
            //   ),
            // ),
            // ListenableBuilder(
            //   listenable: videoConfig,
            //   builder: (context, child) => SwitchListTile.adaptive(
            //     activeColor: Theme.of(context).primaryColor,
            //     value: videoConfig.value,
            //     onChanged: (value) {
            //       videoConfig.value = !videoConfig.value;
            //     },
            //     title: const Text("Auto Mute"),
            //     subtitle: const Text("Video will be muted by default."),
            //   ),
            // ),
            SwitchListTile.adaptive(
              value: ref.watch(playbackConfigProvider).muted,
              onChanged: (value) {
                ref.read(playbackConfigProvider.notifier).setMuted(value);
              },
              title: const Text("Mute video"),
              subtitle: const Text("Video will be muted by default."),
            ),
            SwitchListTile.adaptive(
              value: ref.watch(playbackConfigProvider).autoplay,
              onChanged: (value) {
                ref.read(playbackConfigProvider.notifier).setAutoplay(value);
              },
              title: const Text("Autoplay"),
              subtitle: const Text("Video will start playing automatically."),
            ),
            SwitchListTile.adaptive(
              value: false,
              onChanged: (value) {},
              title: const Text("Enable notifications"),
            ),
            CheckboxListTile.adaptive(
                value: false,
                onChanged: (value) {},
                title: const Text("Enable notifications")),
            ListTile(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1980),
                  lastDate: DateTime(2030),
                );
                if (kDebugMode) {
                  print(date);
                }
                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (kDebugMode) {
                  print(time);
                }
                final booking = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime(1980),
                  lastDate: DateTime(2030),
                  builder: (context, child) {
                    return Theme(
                        data: ThemeData(
                          appBarTheme: const AppBarTheme(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.black,
                          ),
                        ),
                        child: child!);
                  },
                );
                if (kDebugMode) {
                  print(booking);
                }
              },
              title: const Text("What is your birthday?"),
            ),
            ListTile(
                title: const Text("Log out (iOS)"),
                textColor: Colors.red,
                onTap: () {
                  showCupertinoDialog(
                    context: context,
                    builder: (context) => CupertinoAlertDialog(
                      title: const Text("Are you sure"),
                      content: const Text('Plx dont go'),
                      actions: [
                        CupertinoDialogAction(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text(
                            'No',
                          ),
                        ),
                        CupertinoDialogAction(
                          onPressed: () {
                            ref.read(authRepo).signOut();
                            context.go("/");
                          },
                          child: const Text(
                            'Yes',
                          ),
                        ),
                      ],
                    ),
                  );
                }),
            ListTile(
                title: const Text("Log out (Android)"),
                textColor: Colors.red,
                onTap: () {
                  showCupertinoDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      icon: const FaIcon(FontAwesomeIcons.marker),
                      title: const Text("Are you sure"),
                      content: const Text('Plx dont go'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text(
                            'No',
                          ),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text(
                            'Yes',
                          ),
                        ),
                      ],
                    ),
                  );
                }),
            ListTile(
                title: const Text("Log out (iOS / Bottom)"),
                textColor: Colors.red,
                onTap: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) => CupertinoActionSheet(
                      title: const Text("Are you sure"),
                      message: const Text("Plx dont go"),
                      actions: [
                        CupertinoActionSheetAction(
                          isDefaultAction: true,
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text("Not log out"),
                        ),
                        CupertinoActionSheetAction(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text("Yes please"),
                        ),
                      ],
                    ),
                  );
                }),
            const AboutListTile(),
          ],
        ),
      ),
    );
  }
}
