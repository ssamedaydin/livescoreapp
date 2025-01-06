import 'package:flutter/material.dart';
import 'package:livescoreapp/ui/match_info/widgets/match_stat_card.dart';

import '../../../domain/models/event_model.dart';

class ContentSwitcher extends StatelessWidget {
  final int selectedIndex;
  final EventModel match;

  const ContentSwitcher({Key? key, required this.selectedIndex, required this.match}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (selectedIndex) {
      case 0:
        return StatsComparisonScreen(statistics: match.statistics ?? []);
      case 1:
        return CardsListView(cards: match.cards ?? []);
      case 2:
        return GoalsListView(goals: match.goals ?? []);
      default:
        return const Center(child: Text("No data available."));
    }
  }
}

class CardsListView extends StatelessWidget {
  final List<CardsModel> cards;

  const CardsListView({Key? key, required this.cards}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cards.length,
      itemBuilder: (context, index) {
        final card = cards[index];
        return ListTile(
          title: Text("Time: ${card.time}, Card: ${card.card}"),
          subtitle: Text("Home Fault: ${card.homeFault}, Away Fault: ${card.awayFault}"),
        );
      },
    );
  }
}

class GoalsListView extends StatelessWidget {
  final List<GoalModel> goals;

  const GoalsListView({Key? key, required this.goals}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: goals.length,
      itemBuilder: (context, index) {
        final goal = goals[index];
        return ListTile(
          title: Text("Time: ${goal.time}, Scorer: ${goal.homeScorer}"),
          subtitle: Text("Score: ${goal.score}"),
        );
      },
    );
  }
}
