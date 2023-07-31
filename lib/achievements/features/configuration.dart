import 'package:better_steam_achievements/achievements/bloc/achievement_bloc.dart';
import 'package:better_steam_achievements/achievements/bloc/achievement_event.dart';
import 'package:better_steam_achievements/achievements/bloc/achievement_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ConfigurationPage extends StatefulWidget {
  const ConfigurationPage({super.key});

  @override
  State<ConfigurationPage> createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  late final TextEditingController steamIdController;
  late final TextEditingController steamApiKeyController;
  late final AchievementBloc achievementBloc;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    achievementBloc = context.read<AchievementBloc>();
    final state = achievementBloc.state as WithCredentials;
    final credentials = state.getCredentails();

    steamIdController = TextEditingController.fromValue(
      TextEditingValue(text: credentials.steamId),
    );
    steamApiKeyController = TextEditingController.fromValue(
      TextEditingValue(text: credentials.steamApiKey),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AchievementBloc, AchievementState>(
      builder: (BuildContext context, AchievementState state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text('BSA - Configuration'),
          ),
          body: Form(
            key: formKey,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      "Please enter your configuration details:",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    TextFormField(
                      controller: steamIdController,
                      decoration: const InputDecoration(
                        label: Text(
                          "Steam Id - The full url of your profile can be entered here",
                        ),
                      ),
                      validator: (String? url) {
                        if (url == null) {
                          return null;
                        }
                        if (url.isEmpty) {
                          return 'A value must be specified';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: steamApiKeyController,
                      decoration: const InputDecoration(
                        label: Text("Steam Api Key"),
                      ),
                      validator: (String? key) {
                        if (key == null) {
                          return null;
                        }
                        if (key.isEmpty) {
                          return 'A key must be specified';
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2),
                      child: ElevatedButton(
                        onPressed: _onSave,
                        child: const Text("Save"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _onSave() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final steamApiKey = steamApiKeyController.value.text;
    String steamId = steamIdController.value.text;
    final regex = RegExp('https://steamcommunity.com/profiles/(.+)/');
    if (regex.hasMatch(steamId)) {
      steamId = regex.firstMatch(steamId)!.group(1)!;
    }

    achievementBloc.add(SaveCredentialsEvent(steamApiKey, steamId));
    context.go('/');
  }
}
