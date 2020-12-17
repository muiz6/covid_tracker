import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zero_to_hero/src/models/timeline_item_model.dart';
import 'package:zero_to_hero/src/ui/dimens.dart';
import 'package:zero_to_hero/src/ui/my_colors.dart';
import 'package:zero_to_hero/src/ui/strings.dart';

class StatChart extends StatelessWidget {
  final Stream<List<TimelineItemModel>> _stream;

  StatChart({@required Stream<List<TimelineItemModel>> stream})
      : _stream = stream;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<TimelineItemModel>>(
      stream: _stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              Text(
                Strings.DAILY_NEW_CASES,
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(
                height: Dimens.INSET_S,
              ),
              AspectRatio(
                aspectRatio: 1.5,
                // chart needs to be inside a sized container to prevent overflow
                child: BarChart(
                  BarChartData(
                    barGroups: _toBarChartData(snapshot.data),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    titlesData: FlTitlesData(
                      leftTitles: SideTitles(
                        showTitles: true,
                        interval: _calculateInterval(5, snapshot.data),
                        reservedSize: Dimens.INSET_M,
                      ),
                      bottomTitles: SideTitles(
                        showTitles: true,
                        getTitles: (value) {
                          final date = DateTime.fromMillisecondsSinceEpoch(
                              value.toInt());
                          final formatter = DateFormat('MMM-dd');
                          return formatter.format(date);
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              MyColors.RED,
            ),
          ),
        );
      },
    );
  }

  static List<BarChartGroupData> _toBarChartData(
      List<TimelineItemModel> timeline) {
    return timeline.map((model) {
      return BarChartGroupData(
        x: model.date.millisecondsSinceEpoch,
        barRods: [
          BarChartRodData(
            y: model.cases.toDouble(),
            colors: [
              MyColors.RED,
            ],
          ),
        ],
      );
    }).toList();
  }

  static double _calculateInterval(
      int segments, List<TimelineItemModel> timeline) {
    final int maxCases = timeline.reduce((val1, val2) {
      return val1.cases > val2.cases ? val1 : val2;
    }).cases;
    final interval = maxCases / segments;
    // round off to millionth
    return interval - interval % 1000000;
  }
}
