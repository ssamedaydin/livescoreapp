import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:livescoreapp/routing/app_router.dart';
import 'package:livescoreapp/ui/core/themes/theme_config.dart';
import 'package:livescoreapp/ui/favorite_matches/view_model/favorite_bloc.dart';
import 'package:livescoreapp/ui/favorite_matches/view_model/favorite_event.dart';
import 'package:livescoreapp/ui/fixturex/view_model/fixtures_bloc.dart';
import 'package:livescoreapp/ui/live_score/view_model/leauge_bloc.dart';
import 'package:livescoreapp/ui/live_score/view_model/leauge_event.dart';
import 'package:livescoreapp/ui/live_score/view_model/live_score_bloc.dart';
import 'package:livescoreapp/ui/live_score/view_model/live_score_event.dart';
import 'data/di/service_locator.dart';
import 'data/repositories/leauges_repository.dart';
import 'data/repositories/live_score_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LiveScoreBloc>(
          create: (context) => LiveScoreBloc(repository: getIt<LiveScoreRepository>())..add(const FetchLiveScores()),
        ),
        BlocProvider(
          create: (context) => LeagueBloc(repository: getIt<LeagueRepository>())..add(const FetchLeagues()),
        ),
        BlocProvider(
          create: (context) => getIt<FixturesBloc>(),
        ),
        BlocProvider(
          create: (context) => FavoritesBloc()..add(LoadFavorites()),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (context, child) => MaterialApp.router(
              routerConfig: appRouter,
              debugShowCheckedModeBanner: false,
              theme: ThemeConfig.lightTheme,
            ));
  }
}
