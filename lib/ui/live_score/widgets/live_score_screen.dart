import 'package:flutter/material.dart';
import 'package:livescoreapp/ui/core/ui/shared_widgets/match_info_card.dart';
import 'package:livescoreapp/ui/live_score/widgets/leauge_listview.dart';
import 'package:livescoreapp/ui/live_score/widgets/live_match_listview.dart';
import '../../../utils/responsive.dart';
import '../../core/ui/shared_widgets/cached_avatar_widget.dart';
import '../view_model/live_score_bloc.dart';

class LiveScoreScreen extends StatefulWidget {
  const LiveScoreScreen({super.key});

  @override
  State<LiveScoreScreen> createState() => _LiveScoreScreenState();
}

class _LiveScoreScreenState extends State<LiveScoreScreen> {
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
              leadingWidth: 200,
              leading: Row(
                children: [
                  CachedAvatar(imageUrl: 'https://apiv2.allsportsapi.com/logo/players/52515_cristiano-ronaldo.jpg', radius: 25),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hoşgeldin",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      Text(
                        "Samed Aydın",
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                    ],
                  )
                ],
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
                      Icons.notifications_none,
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                SizedBox(
                  width: 45,
                  height: 45,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey, width: 0.5),
                    ),
                    child: Icon(
                      Icons.menu_outlined,
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
          child: SingleChildScrollView(
            child: Column(
              spacing: 20,
              children: [
                LeaugeListView(isTablet: isTablet),
                MatchInfoCard(isTablet: isTablet),
                LiveMatchListView(isTablet: isTablet),
              ],
            ),
          ),
        ));
  }
}
