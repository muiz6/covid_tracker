import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:zero_to_hero/src/models/timeline_item_model.dart';
import 'package:zero_to_hero/src/ui/dimens.dart';
import 'package:zero_to_hero/src/ui/my_colors.dart';
import 'package:zero_to_hero/src/ui/strings.dart';

class StatChart extends StatelessWidget {
  final List<BarChartGroupData> _data = _getExampleData();
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
                          reservedSize: Dimens.INSET_M,
                        ),
                      )),
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
        x: 0,
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

  static List<BarChartGroupData> _getExampleData() {
    final List<BarChartGroupData> data = List();
    for (int i = 1; i <= 7; i++) {
      data.add(BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            y: i * 1000.0,
            colors: [
              MyColors.RED,
            ],
          ),
        ],
      ));
    }
    return data;
  }
}
