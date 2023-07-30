import 'package:better_steam_achievements/achievements/features/homepage.dart';
import 'package:go_router/go_router.dart';

class ApplicationRouter {
  static GoRouter router() {
    return GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomePage(),
        ),
      ],
      initialLocation: '/',
    );
  }
}