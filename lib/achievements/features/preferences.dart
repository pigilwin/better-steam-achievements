import 'package:better_steam_achievements/achievements/components/menu.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PreferencesPage extends StatefulWidget {
  const PreferencesPage({super.key});

  @override
  State<PreferencesPage> createState() => _PreferencesPage();
}

class _PreferencesPage extends State<PreferencesPage> {
  final Map<int, bool> expanded = {0: false};

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
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.go('/config');
              },
              child: const Text("Change credentials"),
            ),
          ],
        ),
      ),
    );
  }
}
