import 'package:better_steam_achievements/achievements/bloc/achievement_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  late final AchievementBloc achievementBloc;
  late final FullyLoadedGameState state;

  @override
  void initState() {
    super.initState();
    achievementBloc = context.read<AchievementBloc>();
    state = achievementBloc.state as FullyLoadedGameState;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final gamesWithLessThanTenAchivementsToGo =
        state.gamesWithLessThanTenAchivementsToGo();
    final children = [
      Text(
        "BSA",
        style: textTheme.headlineLarge,
      ),
      ListTile(
        title: const Text("Home"),
        trailing: const Icon(Icons.home),
        onTap: () {
          context.go('/');
        },
      ),
    ];

    if (gamesWithLessThanTenAchivementsToGo.isNotEmpty) {
      children.add(
        ListTile(
          title: const Text("Less than 10 Achivements"),
          trailing: const Text("10"),
          onTap: () {
            context.go('/less-than-ten');
          },
        ),
      );
    }

    children.add(
      ListTile(
        title: const Text("Preferences"),
        trailing: const Icon(Icons.settings),
        onTap: () {
          context.go('/preferences');
        },
      ),
    );

    return Drawer(
      backgroundColor: theme.drawerTheme.backgroundColor,
      child: Column(
        children: children,
      ),
    );
  }
}
