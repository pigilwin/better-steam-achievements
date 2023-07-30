import 'package:better_steam_achievements/achievements/bloc/achievement_bloc.dart';
import 'package:better_steam_achievements/achievements/bloc/achievement_state.dart';
import 'package:better_steam_achievements/achievements/features/homepage_with_config_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AchievementBloc, AchievementState>(
      builder: (BuildContext context, AchievementState state) {
        if (state.credentials.isEmpty) {
          return const HomePageWithConfigLink();
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text('Better Steam Achievements'),
          ),
          body: const Center(
            child: Text("Homepage will be here"),
          ),
        );
      },
    );
  }
}
