import '../dimens.dart';
import '../global_stats/stat_tile.dart';
import '../my_colors.dart';
import '../strings.dart';
import 'package:flutter/material.dart';

class StatContent extends StatelessWidget {
  StatContent({
    this.affected = 0,
    this.deaths = 0,
    this.recovered = 0,
  });

  final int affected;
  final int deaths;
  final int recovered;

  final List<Color> _colors = [
    MyColors.YELLOW,
    MyColors.RED,
    MyColors.GREEN,
    Color(0xFF5db6f5),
    Color(0xFFa25ffa),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: StatTile(
                  title: Strings.AFFECTED,
                  value: affected,
                  color: _colors[0],
                ),
              ),
              // Using sized box for easier padding
              SizedBox.fromSize(
                size: Size.fromWidth(
                  Dimens.INSET_S,
                ),
              ),
              Expanded(
                child: StatTile(
                  title: Strings.DEATHS,
                  value: deaths,
                  color: _colors[1],
                ),
              ),
            ],
          ),
        ),
        SizedBox.fromSize(
          size: Size.fromHeight(
            Dimens.INSET_S,
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: StatTile(
                  title: Strings.RECOVERED,
                  value: recovered,
                  color: _colors[2],
                ),
              ),
              SizedBox.fromSize(
                size: Size.fromWidth(
                  Dimens.INSET_S,
                ),
              ),
              Expanded(
                child: StatTile(
                  title: Strings.ACTIVE,
                  value: affected - deaths - recovered,
                  color: _colors[3],
                ),
              ),
              SizedBox.fromSize(
                size: Size.fromWidth(
                  Dimens.INSET_S,
                ),
              ),
              // Expanded(
              //   child: StatTile(
              //     title: Strings.SERIOUS,
              //     color: _colors[4],
              //   ),
              // )
            ],
          ),
        ),
      ],
    );
  }
}
