import 'package:better_steam_achievements/achievements/bloc/achievement_bloc.dart';
import 'package:better_steam_achievements/achievements/components/front_page_slider.dart';
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

  @override
  void initState() {
    super.initState();
    progressBarController = AnimationController(vsync: this);
    achievementBloc = context.read<AchievementBloc>();
  }

  @override
  Widget build(BuildContext context) {
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
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text('Better Steam Achievements'),
          ),
          body: const Center(
            child: FrontPageSlider(),
          ),
        );
      },
    );
  }
}
