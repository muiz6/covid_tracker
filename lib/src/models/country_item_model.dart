class CountryItemModel {
  List<_Result> _results = [];

  CountryItemModel.fromJson(List<dynamic> parsedJson) {
    // print(parsedJson.length);
    List<_Result> temp = [];
    for (int i = 0; i < parsedJson.length; i++) {
      _Result result = _Result(parsedJson[i]);
      temp.add(result);
    }
    _results = temp;
  }

  List<_Result> get results => _results;
}

class _Result {
  String _country;
// ignore: non_constant_identifier_names
  String _last_update;
  int _cases;
  int _deaths;
  int _recovered;

  _Result(result) {
    _country = result['country'];
    _last_update = result['last_update'];
    _cases = result['cases'];
    _deaths = result['deaths'];
    _recovered = result['recovered'];
  }

  String get country => _country;
// ignore: non_constant_identifier_names
  String get last_update => _last_update;
  int get cases => _cases;
  int get deaths => _deaths;
  int get recovered => _recovered;
}
