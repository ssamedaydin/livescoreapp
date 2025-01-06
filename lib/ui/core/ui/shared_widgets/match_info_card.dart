import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livescoreapp/utils/strings.dart';

import '../../../../domain/models/event_model.dart';
import '../../../../utils/responsive.dart';
import 'cached_avatar_widget.dart';
import '../../../live_score/view_model/live_score_bloc.dart';
import '../../../live_score/view_model/live_score_state.dart';

class MatchInfoCard extends StatelessWidget {
  final bool isTablet;
  final EventModel? match;

  MatchInfoCard({required this.isTablet, this.match});

  @override
  Widget build(BuildContext context) {
    if (match == null) {
      return BlocSelector<LiveScoreBloc, LiveScoreState, EventModel?>(
        selector: (state) {
          if (state is LiveScoreLoaded && state.events.isNotEmpty) {
            return state.events.firstWhere(
              (e) => e.eventLive == "1",
            );
          }
          return null;
        },
        builder: (context, topMatch) {
          if (topMatch == null) {
            return const Text(AppStrings.noLiveMatches);
          }
          return _buildMatchCard(context, topMatch, true);
        },
      );
    }

    return _buildMatchCard(context, match!, false);
  }

  Widget _buildMatchCard(BuildContext context, EventModel match, bool title) {
    return SizedBox(
      width: double.infinity,
      height: ResponsiveHelper.width(isTablet ? 120 : 190),
      child: Stack(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xff820002),
              boxShadow: [
                BoxShadow(
                  color: Colors.red.withOpacity(0.5),
                  blurRadius: ResponsiveHelper.width(10),
                  offset: Offset(0, ResponsiveHelper.height(5)),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: isTablet ? 1 : 5,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    title
                        ? Text(
                            match.leaugeName ?? AppStrings.leauge,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: ResponsiveHelper.fontSize(isTablet ? 12 : 18),
                            ),
                          )
                        : SizedBox(),
                    Text(
                      match.leaugeRound ?? "Week",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontWeight: FontWeight.w400,
                        fontSize: ResponsiveHelper.fontSize(isTablet ? 8 : 13),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildTeamInfo(
                        teamName: match.eventHomeTeam ?? AppStrings.homeTeam,
                        teamLogo: match.homeTeamLogo,
                        alignment: "Home",
                      ),
                      _buildMatchScore(match),
                      _buildTeamInfo(
                        teamName: match.eventAwayTeam ?? AppStrings.awayTeam,
                        teamLogo: match.awayTeamLogo,
                        alignment: "Away",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamInfo({
    required String teamName,
    required String? teamLogo,
    required String alignment,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CachedAvatar(
          imageUrl: teamLogo ?? '',
          radius: ResponsiveHelper.width(isTablet ? 18 : 32),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: ResponsiveHelper.width(85),
          child: Center(
            child: Text(
              teamName,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: ResponsiveHelper.fontSize(isTablet ? 10 : 14),
              ),
              maxLines: 1,
              overflow: TextOverflow.clip,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          alignment,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontWeight: FontWeight.w500,
            fontSize: ResponsiveHelper.fontSize(isTablet ? 8 : 10),
          ),
        ),
      ],
    );
  }

  Widget _buildMatchScore(EventModel match) {
    return Column(
      spacing: isTablet ? 3 : 10,
      children: [
        Row(
          spacing: 10,
          children: [
            Text(
              match.eventFinalResult != null ? match.eventFinalResult!.split('-')[0] : match.eventHalftimeResult!.split('-')[0],
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: ResponsiveHelper.fontSize(25),
              ),
            ),
            Text(
              match.eventHalftimeResult == "" ? 'vs' : ':',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: ResponsiveHelper.fontSize(20),
              ),
            ),
            Text(
              match.eventFinalResult != null ? match.eventFinalResult!.split('-')[1] : match.eventHalftimeResult!.split('-')[1],
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: ResponsiveHelper.fontSize(25),
              ),
            ),
          ],
        ),
        SizedBox(
          width: ResponsiveHelper.width((["Finished", "Half Time"].contains(match.eventStatus.toString())) ? 90 : 45),
          height: ResponsiveHelper.height(25),
          child: DecoratedBox(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Color(0xff9F0003), border: Border.all(color: Colors.grey.withOpacity(0.7))),
            child: Center(
              child: Text(
                "${match.eventStatus}'",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontWeight: FontWeight.w700,
                  fontSize: ResponsiveHelper.fontSize(isTablet ? 10 : 14),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
