import 'package:flutter/material.dart';

import '../../../domain/models/event_model.dart';

class StatsComparisonScreen extends StatelessWidget {
  final List<StatisticsModel> statistics;
  const StatsComparisonScreen({Key? key, required this.statistics}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: statistics.length,
        itemBuilder: (context, index) {
          final stat = statistics[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: _buildStatItem(
                statName: stat.type,
                homeValue: int.parse(stat.home),
                awayValue: int.parse(stat.away),
                homeColor: Color(0xff820002),
                awayColor: Color(0xff12377B)),
          );
        },
      ),
    );
  }

  Widget _buildStatItem({
    required String statName,
    required int homeValue,
    required int awayValue,
    required Color homeColor,
    required Color awayColor,
  }) {
    final int maxValue = homeValue + awayValue;
    final double leftPercentage = homeValue / maxValue;
    final double rightPercentage = awayValue / maxValue;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('$homeValue', style: TextStyle(color: homeColor, fontWeight: FontWeight.w700, fontSize: 15)),
            Text(
              statName,
              style: TextStyle(fontSize: 14),
            ),
            Text('$awayValue', style: TextStyle(color: awayColor, fontWeight: FontWeight.w700, fontSize: 15)),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              flex: (leftPercentage * 100).toInt(),
              child: SizedBox(
                height: 20,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                    color: homeColor,
                  ),
                ),
              ),
            ),
            SizedBox(width: 2),
            Expanded(
              flex: (rightPercentage * 100).toInt(),
              child: SizedBox(
                height: 20,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                    color: awayColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
