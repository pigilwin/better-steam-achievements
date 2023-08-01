import 'package:better_steam_achievements/achievements/components/menu.dart';
import 'package:flutter/material.dart';

class LessThanTenPage extends StatefulWidget {
  const LessThanTenPage({super.key});

  @override
  State<LessThanTenPage> createState() => _LessThanTenPageState();
}

class _LessThanTenPageState extends State<LessThanTenPage> {
  final GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Better Steam Achievements - Less than 10 to go'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            scaffoldState.currentState!.openDrawer();
          },
        ),
      ),
      drawer: const Menu(),
      body: const Center(
        child: Text("Less than 10"),
      ),
    );
  }
}
