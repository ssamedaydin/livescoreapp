import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livescoreapp/utils/strings.dart';
import 'package:shimmer/shimmer.dart';
import '../../../utils/favorites_helper.dart';
import '../../../utils/responsive.dart';
import '../../core/ui/shared_widgets/cached_avatar_widget.dart';
import '../../live_score/widgets/leauge_listview.dart';
import '../../match_info/widgets/match_info_screen.dart';
import '../view_model/fixtures_bloc.dart';
import '../view_model/fixtures_event.dart';
import '../view_model/fixtures_state.dart';

class FixturesScreen extends StatefulWidget {
  const FixturesScreen({Key? key}) : super(key: key);

  @override
  State<FixturesScreen> createState() => _FixturesScreenState();
}

class _FixturesScreenState extends State<FixturesScreen> {
  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    super.initState();

    final today = DateTime.now().toIso8601String().split('T')[0];
    context.read<FixturesBloc>().add(FetchFixtures(from: today, to: today));
  }

  @override
  Widget build(BuildContext context) {
    final bool isTablet = ResponsiveHelper.isTablet();
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(ResponsiveHelper.height(40)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: AppBar(
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: Text(
                AppStrings.fixtures,
                style: TextStyle(
                  color: Color(0xff820002),
                  fontWeight: FontWeight.w700,
                  fontSize: ResponsiveHelper.fontSize(isTablet ? 12 : 18),
                ),
              ),
              actions: [
                InkWell(
                  onTap: () async {
                    final picked = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      initialDateRange: startDate != null && endDate != null ? DateTimeRange(start: startDate!, end: endDate!) : null,
                    );
                    if (picked != null) {
                      setState(() {
                        startDate = picked.start;
                        endDate = picked.end;
                      });
                      context.read<FixturesBloc>().add(
                            FetchFixtures(
                              from: startDate!.toIso8601String().split('T')[0],
                              to: endDate!.toIso8601String().split('T')[0],
                            ),
                          );
                    }
                  },
                  child: SizedBox(
                    width: 45,
                    height: 45,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey, width: 0.5),
                      ),
                      child: Icon(
                        Icons.date_range,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        body: Column(
          spacing: 20,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: LeaugeListView(isTablet: isTablet),
            ),
            BlocBuilder<FixturesBloc, FixturesState>(
              builder: (context, state) {
                if (state is FixturesLoading) {
                  return FixturesShimmerEffect(
                    isTablet: isTablet,
                  );
                } else if (state is FixturesLoaded) {
                  return Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.fixtures.length,
                            itemBuilder: (BuildContext context, int index) {
                              final fixture = state.fixtures[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MatchInfoScreen(
                                        match: fixture,
                                      ),
                                    ),
                                  );
                                },
                                onDoubleTap: () => handleFavorites(context, fixture),
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 20.0),
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: ResponsiveHelper.height(isTablet ? 75 : 60),
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
                                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                                                        fixture.eventHomeTeam ?? AppStrings.homeTeam,
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
                                                      radius: ResponsiveHelper.width(isTablet ? 15 : 18),
                                                      imageUrl: fixture.homeTeamLogo.toString(),
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
                                                    child: (fixture.eventFinalResult == null)
                                                        ? Text("-")
                                                        : Text(
                                                            fixture.eventFinalResult != "-"
                                                                ? fixture.eventFinalResult!
                                                                : (fixture.eventHalftimeResult == "" ? 'vs' : fixture.eventHalftimeResult!),
                                                            style: TextStyle(
                                                              color: Color(0xff820002),
                                                              fontWeight: FontWeight.w700,
                                                              fontSize: ResponsiveHelper.fontSize(15),
                                                            ),
                                                          ),
                                                  ),
                                                  fixture.eventStatus == ""
                                                      ? SizedBox()
                                                      : Center(
                                                          child: Text(
                                                            "${fixture.eventStatus}'",
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
                                                      imageUrl: fixture.awayTeamLogo.toString(),
                                                      radius: ResponsiveHelper.width(isTablet ? 15 : 18),
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        fixture.eventAwayTeam ?? AppStrings.awayTeam,
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
                      ),
                    ),
                  );
                } else if (state is FixturesError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox();
              },
            )
          ],
        ));
  }
}

class FixturesShimmerEffect extends StatefulWidget {
  final bool isTablet;

  FixturesShimmerEffect({required this.isTablet});

  @override
  State<FixturesShimmerEffect> createState() => _FixturesShimmerEffectState();
}

class _FixturesShimmerEffectState extends State<FixturesShimmerEffect> {
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
