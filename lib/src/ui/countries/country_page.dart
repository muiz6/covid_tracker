import 'package:flutter/material.dart';
import 'package:zero_to_hero/src/ui/countries/countries.dart';

import '../../blocs/covid_bloc.dart';
import '../../models/country_item_model.dart';
import '../clear_app_bar.dart';
import '../dimens.dart';
import '../global_stats/plain_scroll_behavior.dart';
import '../strings.dart';
import 'country_list_tile.dart';
import 'search_bar.dart';

class CountryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bloc.fetchCountry();
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(
                  Dimens.RADIUS_L,
                ),
              ),
            ),
            child: Column(
              children: [
                ClearAppBar(
                  title: Text(
                    Strings.COUNTRIES,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: Dimens.INSET_S,
                    bottom: Dimens.INSET_S,
                    right: Dimens.INSET_S,
                  ),
                  child: SearchBar(),
                ),
              ],
            ),
          ),
          StreamBuilder(
            stream: bloc.country,
            builder: (context, AsyncSnapshot<CountryItemModel> snapshot) {
              if (snapshot.hasData) {
                return buildList(snapshot, context);
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return Expanded(
                  child: Center(child: CircularProgressIndicator()));
            },
          ),
        ],
      ),
    );
  }

  Widget buildList(
      AsyncSnapshot<CountryItemModel> snapshot, BuildContext context) {
    return Expanded(
      child: ScrollConfiguration(
        behavior: PlainScrollBehavior(),
        child: ListView.builder(
          padding: EdgeInsets.all(
            Dimens.INSET_S,
          ),
          itemCount: snapshot.data.results.length,
          itemBuilder: (BuildContext context, int index) {
            final int severity = index % 3;
            String name =
                kCountries[snapshot.data.results[index].country] != null
                    ? kCountries[snapshot.data.results[index].country]
                    : snapshot.data.results[index].country;
            if (name.length < 3)
              print(name + " " + snapshot.data.results[index].cases);
            return CountryListTile(
              country: name.length > 20 ? name.substring(0, 18) + ".." : name,
              severity: Severity.values[severity],
              cases: snapshot.data.results[index].cases,
            );
          },
        ),
      ),
    );
  }
}
