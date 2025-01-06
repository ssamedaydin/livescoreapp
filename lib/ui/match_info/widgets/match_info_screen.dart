import 'package:flutter/material.dart';
import 'package:livescoreapp/ui/core/ui/shared_widgets/match_info_card.dart';
import 'package:livescoreapp/ui/match_info/widgets/detail_title_listview.dart';
import 'package:livescoreapp/utils/strings.dart';
import '../../../domain/models/event_model.dart';
import '../../../utils/responsive.dart';
import 'match_stat_card.dart';

class MatchInfoScreen extends StatefulWidget {
  final EventModel match;
  const MatchInfoScreen({
    Key? key,
    required this.match,
  }) : super(key: key);

  @override
  State<MatchInfoScreen> createState() => _LiveScoreScreenState();
}

class _LiveScoreScreenState extends State<MatchInfoScreen> {
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
              leading: InkWell(
                onTap: () => Navigator.pop(context),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey, width: 0.5),
                  ),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.grey,
                  ),
                ),
              ),
              title: Text(
                widget.match.leaugeName ?? AppStrings.leauge,
                style: TextStyle(
                  color: Color(0xff820002),
                  fontWeight: FontWeight.w700,
                  fontSize: ResponsiveHelper.fontSize(isTablet ? 12 : 18),
                ),
              ),
              actions: [
                SizedBox(
                  width: 45,
                  height: 45,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey, width: 0.5),
                    ),
                    child: Icon(
                      Icons.more_vert,
                      color: Colors.grey,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            spacing: 20,
            children: [
              Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: MatchInfoCard(
                      isTablet: isTablet,
                      match: widget.match,
                    ),
                  )),
              Expanded(
                  flex: 4,
                  child: DecoratedBox(
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        spacing: 10,
                        children: [
                          DetailTitleListView(isTablet: isTablet),
                          SizedBox(
                            width: double.infinity,
                            height: 300,
                            child: StatsComparisonScreen(
                              statistics: widget.match.statistics ?? [],
                            ),
                          ),
                        ],
                      )))
            ],
          ),
        ));
  }
}
