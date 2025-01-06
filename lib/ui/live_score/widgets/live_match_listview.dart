import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livescoreapp/utils/strings.dart';
import 'package:shimmer/shimmer.dart';
import '../../../utils/favorites_helper.dart';
import '../../../utils/responsive.dart';
import '../../core/ui/shared_widgets/cached_avatar_widget.dart';
import '../../match_info/widgets/match_info_screen.dart';
import '../view_model/live_score_bloc.dart';
import '../view_model/live_score_state.dart';

class LiveMatchListView extends StatefulWidget {
  bool isTablet;
  LiveMatchListView({required this.isTablet});
  @override
  _LiveMatchListViewState createState() => _LiveMatchListViewState();
}

class _LiveMatchListViewState extends State<LiveMatchListView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LiveScoreBloc, LiveScoreState>(
      builder: (context, state) {
        if (state is LiveScoreLoading) {
          return LiveMatchesShimmerEffect(
            isTablet: widget.isTablet,
          );
        } else if (state is LiveScoreLoaded && state.events.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              Text(
                AppStrings.liveMatchs,
                style: TextStyle(
                  color: Color(0xff5d5d5d),
                  fontWeight: FontWeight.w700,
                  fontSize: ResponsiveHelper.fontSize(18),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: ResponsiveHelper.height(280),
                child: state.events.length == 1
                    ? Center(child: Text(AppStrings.onlyOneMatch))
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.events.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == 0) {
                            return SizedBox();
                          }
                          final event = state.events[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MatchInfoScreen(
                                    match: event,
                                  ),
                                ),
                              );
                            },
                            onDoubleTap: () => handleFavorites(context, event),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: SizedBox(
                                width: double.infinity,
                                height: ResponsiveHelper.height(widget.isTablet ? 75 : 60),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.red.withOpacity(0.2),
                                        blurRadius: ResponsiveHelper.width(10),
                                        offset: Offset(0, ResponsiveHelper.height(5)),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            flex: 3,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              spacing: 5,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    event.eventHomeTeam ?? AppStrings.homeTeam,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: ResponsiveHelper.fontSize(13),
                                                    ),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.clip,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                CachedAvatar(
                                                  radius: ResponsiveHelper.width(widget.isTablet ? 15 : 18),
                                                  imageUrl: event.homeTeamLogo.toString(),
                                                ),
                                              ],
                                            )),
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            spacing: ResponsiveHelper.width(1),
                                            children: [
                                              Center(
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  spacing: ResponsiveHelper.width(7),
                                                  children: [
                                                    Text(
                                                      event.eventFinalResult != null
                                                          ? event.eventFinalResult!.split('-')[0]
                                                          : event.eventHalftimeResult!.split('-')[0],
                                                      style: TextStyle(
                                                        color: Color(0xff820002),
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: ResponsiveHelper.fontSize(15),
                                                      ),
                                                    ),
                                                    Text(
                                                      ':',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: ResponsiveHelper.fontSize(13),
                                                      ),
                                                    ),
                                                    Text(
                                                      event.eventFinalResult != null
                                                          ? event.eventFinalResult!.split('-')[1]
                                                          : event.eventHalftimeResult!.split('-')[1],
                                                      style: TextStyle(
                                                        color: Color(0xff820002),
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: ResponsiveHelper.fontSize(15),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Center(
                                                child: Text(
                                                  "${event.eventStatus}'",
                                                  style: TextStyle(
                                                    color: Colors.black.withOpacity(0.7),
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: ResponsiveHelper.fontSize(12),
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                            flex: 3,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              spacing: 5,
                                              children: [
                                                CachedAvatar(
                                                  imageUrl: event.awayTeamLogo.toString(),
                                                  radius: ResponsiveHelper.width(widget.isTablet ? 15 : 18),
                                                ),
                                                Flexible(
                                                  child: Text(
                                                    event.eventAwayTeam ?? AppStrings.awayTeam,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: ResponsiveHelper.fontSize(13),
                                                    ),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.clip,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ],
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
              )
            ],
          );
        } else if (state is LiveScoreError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}

class LiveMatchesShimmerEffect extends StatefulWidget {
  final bool isTablet;

  LiveMatchesShimmerEffect({required this.isTablet});

  @override
  State<LiveMatchesShimmerEffect> createState() => _LiveMatchesShimmerEffectState();
}

class _LiveMatchesShimmerEffectState extends State<LiveMatchesShimmerEffect> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SizedBox(
        width: double.infinity,
        height: ResponsiveHelper.height(280),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: SizedBox(
                  width: double.infinity,
                  height: ResponsiveHelper.height(widget.isTablet ? 75 : 60),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.withOpacity(0.2),
                          blurRadius: ResponsiveHelper.width(10),
                          offset: Offset(0, ResponsiveHelper.height(5)),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: ResponsiveHelper.width(15),
                        children: [
                          Flexible(
                            child: Text(
                              "",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: ResponsiveHelper.fontSize(13),
                              ),
                            ),
                          ),
                          CircleAvatar(
                            radius: ResponsiveHelper.width(widget.isTablet ? 15 : 20),
                            backgroundColor: Colors.grey[200],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: ResponsiveHelper.width(1),
                            children: [
                              Row(
                                spacing: ResponsiveHelper.width(7),
                                children: [
                                  Text(
                                    "",
                                    style: TextStyle(
                                      color: Color(0xff820002),
                                      fontWeight: FontWeight.w700,
                                      fontSize: ResponsiveHelper.fontSize(15),
                                    ),
                                  ),
                                  Text(
                                    '',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: ResponsiveHelper.fontSize(13),
                                    ),
                                  ),
                                  Text(
                                    "",
                                    style: TextStyle(
                                      color: Color(0xff820002),
                                      fontWeight: FontWeight.w700,
                                      fontSize: ResponsiveHelper.fontSize(15),
                                    ),
                                  ),
                                ],
                              ),
                              Center(
                                child: Text(
                                  "",
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.7),
                                    fontWeight: FontWeight.w500,
                                    fontSize: ResponsiveHelper.fontSize(12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          CircleAvatar(
                            radius: ResponsiveHelper.width(widget.isTablet ? 15 : 18),
                            backgroundColor: Colors.grey[200],
                          ),
                          Flexible(
                            child: Text(
                              "",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: ResponsiveHelper.fontSize(13),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
