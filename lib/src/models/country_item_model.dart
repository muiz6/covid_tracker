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
  String _cases;
  String _deaths;
  String _recovered;

  _Result(result) {
    _country = result['country'];
    _last_update = result['last_update'];
    _cases = result['cases'].toString();
    _deaths = result['deaths'].toString();
    _recovered = result['recovered'].toString();
  }

  String get country => _country;
// ignore: non_constant_identifier_names
  String get last_update => _last_update;
  String get cases => _cases;
  String get deaths => _deaths;
  String get recovered => _recovered;
}
