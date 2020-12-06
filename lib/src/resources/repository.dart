import 'dart:async';

import '../models/country_item_model.dart';
import '../models/date_item_model.dart';
import '../models/timeline_item_model.dart';
import 'covid_api_provider.dart';

class Repository {
  final covidApiProvider = CovidApiProvider();

  Future<CountryItemModel> fetchCountry() => covidApiProvider.fetchCountry();

  Future<TimelineItemModel> fetchTimeline() => covidApiProvider.fetchTimeline();

  Future<DateItemModel> fetchToday() => covidApiProvider.fetchToday();

  Future<DateItemModel> fetchYesterday() => covidApiProvider.fetchYesterday();
}
