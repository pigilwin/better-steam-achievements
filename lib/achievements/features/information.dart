import 'package:better_steam_achievements/achievements/bloc/achievement_bloc.dart';
import 'package:better_steam_achievements/achievements/bloc/data/achievement.dart';
import 'package:better_steam_achievements/achievements/bloc/data/game.dart';
import 'package:better_steam_achievements/achievements/components/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InformationPage extends StatefulWidget {
  final int appId;

  const InformationPage({super.key, required this.appId});

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  late AchievementBloc achievementBloc;
  late Game game;
  late bool hidden = false;

  @override
  void initState() {
    super.initState();
    achievementBloc = context.read<AchievementBloc>();
    final state = achievementBloc.state as FullyLoadedGameState;
    game = state.findGameById(widget.appId);
    hidden = game.gameState == GameState.hidden;
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();

    final children = <Widget>[_generateInformationCard()];

    final achievements = game.achievements;
    achievements.sort((Achievement a, Achievement b) {
      if (!a.completed || !b.completed) {
        return 1;
      }
      return 0;
    });

    for (final Achievement achievement in achievements) {
      children.add(_addAchievement(achievement));
    }

    return Scaffold(
      key: scaffoldState,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(game.name),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            scaffoldState.currentState!.openDrawer();
          },
        ),
      ),
      drawer: const Menu(),
      body: ListView.builder(
        itemCount: children.length,
        itemBuilder: (context, i) {
          return children[i];
        },
      ),
    );
  }

  Widget _generateInformationCard() {
    final children = <Widget>[
      Stack(
        children: [
          Container(
            alignment: Alignment.center,
            child: Image.network(
              game.imageUrl(),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Image.network(game.logoUrl()),
          ),
        ],
      ),
    ];

    if (game.gameState != GameState.noachievements) {
      children.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SwitchListTile(
            title: const Text("Hide the game from the application?"),
            value: hidden,
            onChanged: (bool changed) {
              setState(() {
                hidden = changed;
              });
            },
          ),
        ),
      );
    }

    return Card(
      margin: const EdgeInsets.all(20),
      elevation: 8,
      child: Column(
        children: children,
      ),
    );
  }

  Widget _addAchievement(Achievement achievement) {
    var trailing = Image.network(achievement.grayIconUrl);
    if (achievement.completed) {
      trailing = Image.network(achievement.iconUrl);
    }

    return ListTile(
      title: Text(achievement.name),
      subtitle: Text(achievement.description),
      trailing: trailing,
    );
  }
}
