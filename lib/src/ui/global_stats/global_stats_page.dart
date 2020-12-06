import 'package:flutter/material.dart';

import '../../blocs/covid_bloc.dart';
import '../../models/date_item_model.dart';
import '../../models/timeline_item_model.dart';
import '../clear_app_bar.dart';
import '../dimens.dart';
import '../global_stats/curved_tab_bar.dart';
import '../global_stats/plain_scroll_behavior.dart';
import '../global_stats/stat_chart.dart';
import '../global_stats/stat_content.dart';
import '../strings.dart';
import 'plain_scroll_behavior.dart';

class GlobalStatsPage extends StatefulWidget {
  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<GlobalStatsPage> {
  final double _heightTbv = 200;
  final double _heightTabBar = 25;
  final List<Widget> _tabs = [
    Tab(
      text: Strings.TOTAL,
    ),
    Tab(
      text: Strings.TODAY,
    ),
    Tab(
      text: Strings.YESTERDAY,
    ),
  ];
  final EdgeInsets _paddingTbv = EdgeInsets.all(Dimens.INSET_M);

  @override
  Widget build(BuildContext context) {
    bloc.fetchTimeline();
    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  ClearAppBar(
                    title: Text(
                      Strings.GLOBAL_STATISTICS,
                    ),
                  ),
                  DefaultTabController(
                    length: _tabs.length,
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: Dimens.INSET_M),
                          child: Container(
                            height: _heightTabBar,
                            child: CurvedTabBar(
                              tabs: _tabs,
                            ),
                          ),
                        ),
                        Container(
                          height: _heightTbv,
                          child: ScrollConfiguration(
                            behavior: PlainScrollBehavior(),
                            child: TabBarView(
                              children: [
                                Padding(
                                  padding: _paddingTbv,
                                  child: StreamBuilder(
                                    stream: bloc.timeline,
                                    builder: (context,
                                        AsyncSnapshot<TimelineItemModel>
                                            snapshot) {
                                      if (snapshot.hasData) {
                                        return StatContent(
                                          affected: snapshot.data.total_cases,
                                          deaths: snapshot.data.total_deaths,
                                          recovered:
                                              snapshot.data.total_recovered,
                                        );
                                      } else if (snapshot.hasError) {
                                        return Text(snapshot.error.toString());
                                      }
                                      bloc.fetchTimeline();
                                      return Center(
                                          child: CircularProgressIndicator());
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: _paddingTbv,
                                  child: StreamBuilder(
                                    stream: bloc.today,
                                    builder: (context,
                                        AsyncSnapshot<DateItemModel> snapshot) {
                                      if (snapshot.hasData) {
                                        return StatContent(
                                          affected: snapshot.data.cases,
                                          deaths: snapshot.data.deaths,
                                          recovered: snapshot.data.recovered,
                                        );
                                      } else if (snapshot.hasError) {
                                        return Text(snapshot.error.toString());
                                      }
                                      bloc.fetchToday();
                                      return Center(
                                          child: CircularProgressIndicator());
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: _paddingTbv,
                                  child: StreamBuilder(
                                    stream: bloc.yesterday,
                                    builder: (context,
                                        AsyncSnapshot<DateItemModel> snapshot) {
                                      if (snapshot.hasData) {
                                        return StatContent(
                                          affected: snapshot.data.cases,
                                          deaths: snapshot.data.deaths,
                                          recovered: snapshot.data.recovered,
                                        );
                                      } else if (snapshot.hasError) {
                                        return Text(snapshot.error.toString());
                                      }
                                      bloc.fetchYesterday();
                                      return Center(
                                          child: CircularProgressIndicator());
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(Dimens.RADIUS_HOME_CONTAINER),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(
                    Dimens.INSET_M,
                  ),
                  child: StatChart(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
