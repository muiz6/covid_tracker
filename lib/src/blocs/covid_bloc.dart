import 'package:zero_to_hero/src/models/timeline_item_model.dart';
import 'package:zero_to_hero/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zero_to_hero/src/models/country_item_model.dart';
import 'package:zero_to_hero/src/models/date_item_model.dart';

class CovidBloc {
  final _repository = Repository();
  final _countryFetcher = BehaviorSubject<CountryItemModel>();
  final _totalFetcher = BehaviorSubject<DateItemModel>();
  final _todayFetcher = BehaviorSubject<DateItemModel>();
  final _yesterdayFetcher = BehaviorSubject<DateItemModel>();
  final _timelineFetcher = BehaviorSubject<List<TimelineItemModel>>();

  CovidBloc() {
    // lazy fetch
    _totalFetcher.onListen = _fetchTotal;
    _todayFetcher.onListen = _fetchToday;
    _yesterdayFetcher.onListen = _fetchYesterday;
    _countryFetcher.onListen = _fetchCountry;
    _timelineFetcher.onListen = _fetchTimeline;
  }

  Stream<CountryItemModel> get country => _countryFetcher.stream;
  Stream<DateItemModel> get today => _todayFetcher.stream;
  Stream<DateItemModel> get yesterday => _yesterdayFetcher.stream;
  Stream<DateItemModel> get total => _totalFetcher.stream;
  Stream<List<TimelineItemModel>> get timeline => _timelineFetcher.stream;

  void _fetchCountry() async {
    CountryItemModel countryItemModel = await _repository.fetchCountry();
    _countryFetcher.add(countryItemModel);
  }

  void _fetchTotal() async {
    final timelineItemModel = await _repository.fetchTotal();
    _totalFetcher.sink.add(timelineItemModel);
  }

  void _fetchToday() async {
    DateItemModel dateItemModel = await _repository.fetchToday();
    _todayFetcher.add(dateItemModel);
  }

  void _fetchYesterday() async {
    DateItemModel dateItemModel = await _repository.fetchYesterday();
    _yesterdayFetcher.add(dateItemModel);
  }

  void _fetchTimeline() async {
    final timeline = await _repository.fetchTimeline();
    _timelineFetcher.add(timeline);
  }

  dispose() {
    _countryFetcher.close();
    _totalFetcher.close();
    _todayFetcher.close();
    _yesterdayFetcher.close();
    _timelineFetcher.close();
  }
}

final bloc = CovidBloc();
