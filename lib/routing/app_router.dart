import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:livescoreapp/ui/favorite_matches/widgets/favorite_matches_screen.dart';
import '../ui/fixturex/widgets/fixtures_screen.dart';
import '../ui/general/general_view.dart';
import '../ui/live_score/widgets/live_score_screen.dart';

final _routerKey = GlobalKey<NavigatorState>();

class AppRouters {
  AppRouters._();
  static const String liveScore = '/livescore';
  static const String fixtures = '/fixtures';
  static const String favorite = '/favorite';
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRouters.liveScore,
  navigatorKey: _routerKey,
  routes: [
    StatefulShellRoute.indexedStack(builder: (context, state, navigationShell) => GeneralView(navigationShell: navigationShell), branches: [
      StatefulShellBranch(routes: [
        GoRoute(
          path: AppRouters.liveScore,
          builder: (context, state) => const LiveScoreScreen(),
        ),
      ]),
      StatefulShellBranch(routes: [
        GoRoute(
          path: AppRouters.fixtures,
          builder: (context, state) => const FixturesScreen(),
        ),
      ]),
      StatefulShellBranch(routes: [
        GoRoute(
          path: AppRouters.favorite,
          builder: (context, state) => FavoritesScreen(),
        ),
      ]),
    ])
  ],
);
