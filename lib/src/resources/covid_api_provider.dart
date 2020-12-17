import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:zero_to_hero/src/models/timeline_item_model.dart';
import 'package:zero_to_hero/src/models/country_item_model.dart';
import 'package:zero_to_hero/src/models/date_item_model.dart';

class CovidApiProvider {
  static const _API_ROOT = 'https://covid19-api.org/api';
  final Client client = Client();

  Future<CountryItemModel> fetchCountry() async {
    final response = await client.get('$_API_ROOT/status');
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return CountryItemModel.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<DateItemModel> fetchToday() async => _fetchSingleDayData();

  Future<DateItemModel> fetchYesterday() async => _fetchSingleDayData(
        offset: 1,
      );

  Future<DateItemModel> fetchTotal() async {
    // DateTime date = DateTime.now();
    final response = await client.get('$_API_ROOT/timeline');
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return DateItemModel.fromJson(json.decode(response.body)[0]);
    }
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }

  Future<List<TimelineItemModel>> fetchTimeline() async {
    final response = await client.get('$_API_ROOT/timeline');
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      final List<dynamic> timeline = json.decode(response.body);
      return timeline
          .sublist(0, 7)
          .map((json) => TimelineItemModel.fromJson(json))
          .toList();
    }
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }

  Future<DateItemModel> _fetchSingleDayData({int offset = 0}) async {
    final response = await client.get('$_API_ROOT/timeline');
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      final todayTotal =
          DateItemModel.fromJson(json.decode(response.body)[offset]);
      final ystTotal =
          DateItemModel.fromJson(json.decode(response.body)[offset + 1]);
      // just single day
      return DateItemModel(
        cases: todayTotal.cases - ystTotal.cases,
        deaths: todayTotal.deaths - ystTotal.deaths,
        recovered: todayTotal.recovered - ystTotal.recovered,
      );
    }
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}
