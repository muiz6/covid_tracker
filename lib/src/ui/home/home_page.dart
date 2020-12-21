import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:zero_to_hero/src/blocs/country_bloc.dart';
import 'package:zero_to_hero/src/blocs/covid_bloc.dart';
import 'package:zero_to_hero/src/ui/about_page.dart';
import 'package:zero_to_hero/src/ui/countries/country_page.dart';
import 'package:zero_to_hero/src/ui/global_stats/global_stats_page.dart';
import 'package:zero_to_hero/src/ui/home/blue_tab_bar.dart';

/// Screen containing bottom appbar
class HomePage extends StatelessWidget {
  final List<Widget> _tabs = [
    Tab(
      icon: Icon(
        Icons.public,
      ),
    ),
    Tab(
      icon: Icon(
        Icons.location_on,
      ),
    ),
    Tab(
      icon: Icon(
        Icons.info,
      ),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<CovidBloc>(
          create: (context) => CovidBloc(),
          dispose: (context, bloc) => bloc.dispose(),
        ),
        Provider<CountryBloc>(
          create: (context) => CountryBloc(),
          dispose: (context, bloc) => bloc.dispose(),
        ),
      ],
      builder: (context, child) {
        return DefaultTabController(
          length: _tabs.length,
          child: Scaffold(
            body: TabBarView(
              children: [
                GlobalStatsPage(
                  context: context,
                ),
                CountryPage(
                  context: context,
                ),
                AboutPage(),
              ],
            ),
            bottomNavigationBar: BlueTabBar(tabs: _tabs),
          ),
        );
      },
    );
  }
}
