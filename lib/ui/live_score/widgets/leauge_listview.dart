import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livescoreapp/domain/models/leauges_model.dart';
import 'package:livescoreapp/ui/core/ui/shared_widgets/cached_image_widget.dart';
import 'package:livescoreapp/utils/strings.dart';
import 'package:shimmer/shimmer.dart';
import '../../../utils/responsive.dart';
import '../../fixturex/view_model/fixtures_bloc.dart';
import '../../fixturex/view_model/fixtures_event.dart';
import '../view_model/leauge_bloc.dart';
import '../view_model/leauge_event.dart';
import '../view_model/leauge_state.dart';
import '../view_model/live_score_bloc.dart';
import '../view_model/live_score_event.dart';

class LeaugeListView extends StatefulWidget {
  bool isTablet;
  LeaugeListView({required this.isTablet});
  @override
  _LeaugeListViewState createState() => _LeaugeListViewState();
}

class _LeaugeListViewState extends State<LeaugeListView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeagueBloc, LeagueState>(
      builder: (context, state) {
        if (state is LeagueLoading) {
          return LeaugesShimmerEffect(
            isTablet: widget.isTablet,
          );
        } else if (state is LeagueLoaded) {
          return Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: SizedBox(
              width: double.infinity,
              height: ResponsiveHelper.height(40),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.leagues.length,
                  itemBuilder: (BuildContext context, int index) {
                    final league = state.leagues[index];
                    bool isSelected = (index == 0 && league.leagueKey.toString() == "-1")
                        ? true
                        : (state.selectedLeagueId.toString() == league.leagueKey.toString());
                    return InkWell(
                      onTap: () {
                        context.read<LeagueBloc>().add(
                              SelectLeagueLx(leagueId: league.leagueKey == -1 ? "" : league.leagueKey.toString()),
                            );
                        context.read<LiveScoreBloc>().add(
                              SelectLeague(leagueId: league.leagueKey == -1 ? "" : league.leagueKey.toString()),
                            );

                        context.read<FixturesBloc>().add(
                              SelectLeagueFx(leagueId: league.leagueKey == -1 ? "" : league.leagueKey.toString()),
                            );
                      },
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: isSelected ? Color(0xff820002) : Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: league.leagueKey == -1
                                  ? _buildTitle(league, isSelected)
                                  : Row(
                                      spacing: 5,
                                      children: [
                                        league.leagueKey == 152
                                            ? Image.asset(
                                                "assets/images/leauges/premier_leauge_logo.png",
                                                color: isSelected ? Colors.white : Colors.grey,
                                              )
                                            : CachedImage(imageUrl: league.leagueLogo.toString(), isSelected: isSelected),
                                        _buildTitle(league, isSelected),
                                      ],
                                    ),
                            ),
                          )),
                    );
                  }),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  Padding _buildTitle(LeaguesModel league, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Center(
        child: Text(
          league.leagueName ?? AppStrings.leauge,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey,
            fontWeight: FontWeight.w700,
            fontSize: ResponsiveHelper.fontSize(widget.isTablet ? 7 : 11),
          ),
        ),
      ),
    );
  }
}

class LeaugesShimmerEffect extends StatefulWidget {
  final bool isTablet;

  LeaugesShimmerEffect({required this.isTablet});

  @override
  State<LeaugesShimmerEffect> createState() => _LeaugesShimmerEffectState();
}

class _LeaugesShimmerEffectState extends State<LeaugesShimmerEffect> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: SizedBox(
          width: double.infinity,
          height: ResponsiveHelper.height(40),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: SizedBox(
                      width: ResponsiveHelper.width(150),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            spacing: 5,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Text(
                                  "",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.grey[300],
                                    fontSize: ResponsiveHelper.fontSize(widget.isTablet ? 7 : 11),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ));
              }),
        ),
      ),
    );
  }
}
