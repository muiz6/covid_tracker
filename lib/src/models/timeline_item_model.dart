class TimelineItemModel {
  int _total_cases;
  int _total_deaths;
  int _total_recovered;

  TimelineItemModel.fromJson(List<dynamic> parsedJson) {
    // print(parsedJson.length);
    int total_cases = 0;
    int total_deaths = 0;
    int total_recovered = 0;
    for (int i = 0; i < parsedJson.length; i++) {
      total_cases += parsedJson[i]["total_cases"];
      total_deaths += parsedJson[i]["total_deaths"];
      total_recovered += parsedJson[i]["total_recovered"];
    }
    _total_cases = total_cases;
    _total_deaths = total_deaths;
    _total_recovered = total_recovered;
  }
  int get total_cases => _total_cases;
  int get total_deaths => _total_deaths;
  int get total_recovered => _total_recovered;
}
