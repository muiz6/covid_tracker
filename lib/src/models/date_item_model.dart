class DateItemModel {
  int _cases;
  int _deaths;
  int _recovered;

  DateItemModel.fromJson(List<dynamic> parsedJson) {
    // print(parsedJson.length);
    int cases = 0;
    int deaths = 0;
    int recovered = 0;
    for (int i = 0; i < parsedJson.length; i++) {
      cases += parsedJson[i]["cases"];
      deaths += parsedJson[i]["deaths"];
      recovered += parsedJson[i]["recovered"];
    }
    _cases = cases;
    _deaths = deaths;
    _recovered = recovered;
  }
  int get cases => _cases;
  int get deaths => _deaths;
  int get recovered => _recovered;
}
