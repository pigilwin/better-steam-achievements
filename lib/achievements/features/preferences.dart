import 'package:better_steam_achievements/achievements/components/menu.dart';
import 'package:flutter/material.dart';

class PreferencesPage extends StatelessWidget {
  const PreferencesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldState,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Better Steam Achievements - Preferences'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            scaffoldState.currentState!.openDrawer();
          },
        ),
      ),
      drawer: const Menu(),
      body: const Text("Preferences"),
    );
  }
}
