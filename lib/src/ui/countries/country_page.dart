import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zero_to_hero/src/blocs/country_bloc.dart';
import 'package:zero_to_hero/src/models/countries_item_model.dart';
import 'package:zero_to_hero/src/ui/clear_app_bar.dart';
import 'package:zero_to_hero/src/ui/dimens.dart';
import 'package:zero_to_hero/src/ui/plain_scroll_behavior.dart';
import 'package:zero_to_hero/src/ui/strings.dart';
import 'package:zero_to_hero/src/ui/countries/country_list_tile.dart';
import 'package:zero_to_hero/src/ui/countries/search_bar.dart';

class CountryPage extends StatefulWidget {
  final CountryBloc countryBloc;

  CountryPage({@required BuildContext context})
      : countryBloc = Provider.of<CountryBloc>(context, listen: false);

  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  Future<List<CountryItemModel>> _ftrCountryList;

  @override
  void initState() {
    _ftrCountryList = widget.countryBloc.getCountries("");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  child: SearchBar(
                    onChanged: (input) {
                      setState(() {
                        _ftrCountryList =
                            widget.countryBloc.getCountries(input);
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<CountryItemModel>>(
              future: _ftrCountryList,
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? buildList(snapshot.data)
                    : Center(
                        child: snapshot.hasError
                            ? Text(snapshot.error.toString())
                            : CircularProgressIndicator(),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildList(List<CountryItemModel> countries) {
    return ScrollConfiguration(
      behavior: PlainScrollBehavior(),
      child: ListView.builder(
        padding: EdgeInsets.all(
          Dimens.INSET_S,
        ),
        itemCount: countries.length,
        itemBuilder: (context, index) {
          final model = countries[index];
          // uniform padding independant of list item widget
          return Padding(
            padding: EdgeInsets.all(
              Dimens.INSET_S,
            ),
            child: CountryListTile(
              country: model.country,
              cases: model.cases,
              severity: Severity.values[index % 3],
            ),
          );
        },
      ),
    );
  }
}
