import 'package:zero_to_hero/src/blocs/bloc.dart';
import 'package:zero_to_hero/src/resources/repository.dart';
import 'package:zero_to_hero/src/models/countries_item_model.dart';

class CountryBloc implements Bloc {
  final _repository = Repository();
  // cache countries in this variable
  final List<CountryItemModel> _countries = List();

  Future<List<CountryItemModel>> getCountries(String searchTerm) async {
    if (_countries.isEmpty) {
      // lazy fetch once
      final countriesModel = await _repository.fetchCountry();
      _countries.addAll(countriesModel.countries);
    }
    return searchTerm.isEmpty
        ? _countries // return all countries when search term is empty
        : _countries.where((element) {
            final caseInsenstiveQuery = searchTerm.toLowerCase();
            final caseInsenstiveCountryName = element.country.toLowerCase();
            return caseInsenstiveCountryName.contains(caseInsenstiveQuery);
          }).toList();
  }

  dispose() {}
}
