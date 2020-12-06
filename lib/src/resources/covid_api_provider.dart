import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' show Client;

import '../models/country_item_model.dart';
import '../models/date_item_model.dart';
import '../models/timeline_item_model.dart';

class CovidApiProvider {
  Client client = Client();
  // final _apiKey = 'your_api_key';

  Future<CountryItemModel> fetchCountry() async {
    print("Cou");
    final response = await client.get("https://covid19-api.org/api/status");
    // print(response.body.toString());
    print("/Cou");
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return CountryItemModel.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<TimelineItemModel> fetchTimeline() async {
    print("Time");
    final response = await client.get("https://covid19-api.org/api/timeline");
    // print(response.body.toString());
    print("/Time");
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return TimelineItemModel.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<DateItemModel> fetchToday() async {
    DateTime date = DateTime.now();
    print("Tod");
    final response = await client.get(
        "https://covid19-api.org/api/status?date=" +
            date.toString().substring(0, 10));
    // print(response.body.toString());
    print("/Tod");
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return DateItemModel.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<DateItemModel> fetchYesterday() async {
    DateTime date = DateTime.now().subtract(Duration(days: 1));
    print("Yes");
    final response = await client.get(
        "https://covid19-api.org/api/status?date=" +
            date.toString().substring(0, 10));
    // print(response.body.toString());
    print("/Yes");
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return DateItemModel.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
