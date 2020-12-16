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

  CovidBloc() {
    // lazy fetch
    _totalFetcher.onListen = _fetchTotal;
    _todayFetcher.onListen = _fetchToday;
    _yesterdayFetcher.onListen = _fetchYesterday;
    _countryFetcher.onListen = _fetchCountry;
  }

  Stream<CountryItemModel> get country => _countryFetcher.stream;
  Stream<DateItemModel> get today => _todayFetcher.stream;
  Stream<DateItemModel> get yesterday => _yesterdayFetcher.stream;
  Stream<DateItemModel> get total => _totalFetcher.stream;

  void _fetchCountry() async {
    CountryItemModel countryItemModel = await _repository.fetchCountry();
    _countryFetcher.add(countryItemModel);
  }

  void _fetchTotal() async {
    // TimelineItemModel timelineItemModel = await _repository.fetchTimeline();
    // _totalFetcher.sink.add(timelineItemModel);
  }

  void _fetchToday() async {
    DateItemModel dateItemModel = await _repository.fetchToday();
    _todayFetcher.add(dateItemModel);
  }

  void _fetchYesterday() async {
    DateItemModel dateItemModel = await _repository.fetchYesterday();
    _yesterdayFetcher.add(dateItemModel);
  }

  dispose() {
    _countryFetcher.close();
    _totalFetcher.close();
    _todayFetcher.close();
    _yesterdayFetcher.close();
  }
}

final bloc = CovidBloc();
