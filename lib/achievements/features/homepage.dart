import 'package:better_steam_achievements/achievements/bloc/achievement_bloc.dart';
import 'package:better_steam_achievements/achievements/bloc/data/game.dart';
import 'package:better_steam_achievements/achievements/components/front_page_slider.dart';
import 'package:better_steam_achievements/achievements/components/menu.dart';
import 'package:better_steam_achievements/achievements/features/homepage_with_config_link.dart';
import 'package:better_steam_achievements/achievements/features/homepage_with_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final AnimationController progressBarController;
  late final AchievementBloc achievementBloc;
  late final FullyLoadedGameState achievementState;
  late final Games fullyCompletedGames;

  @override
  void initState() {
    super.initState();
    progressBarController = AnimationController(vsync: this);
    achievementBloc = context.read<AchievementBloc>();
    achievementState = achievementBloc.state as FullyLoadedGameState;
    fullyCompletedGames = achievementState.fullyCompletedGames();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();

    return BlocBuilder<AchievementBloc, AchievementState>(
      builder: (BuildContext context, AchievementState state) {
        if (state is InitialAchievementState ||
            state is FailedToLoadCredentailsState) {
          return const HomePageWithConfigLink();
        }

        if (state is LoadGamesWithoutAchievementsState) {
          return const HomePageWithLoading();
        }

        return Scaffold(
          key: scaffoldState,
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(
              "Better Steam Achievements - Fully completed ${fullyCompletedGames.length}",
            ),
            leading: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                scaffoldState.currentState!.openDrawer();
              },
            ),
          ),
          drawer: const Menu(),
          body: FrontPageSlider(
            fullyCompletedGames: fullyCompletedGames,
          ),
        );
      },
    );
  }
}
