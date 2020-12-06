import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import '../models/country_item_model.dart';
import '../models/timeline_item_model.dart';
import '../models/date_item_model.dart';

class CovidBloc {
  final _repository = Repository();
  final _countryFetcher = PublishSubject<CountryItemModel>();
  final _timelineFetcher = PublishSubject<TimelineItemModel>();
  final _todayFetcher = PublishSubject<DateItemModel>();
  final _yesterdayFetcher = PublishSubject<DateItemModel>();

  Stream<CountryItemModel> get country => _countryFetcher.stream;
  Stream<TimelineItemModel> get timeline => _timelineFetcher.stream;
  Stream<DateItemModel> get today => _todayFetcher.stream;
  Stream<DateItemModel> get yesterday => _yesterdayFetcher.stream;

  fetchCountry() async {
    CountryItemModel countryItemModel = await _repository.fetchCountry();
    _countryFetcher.sink.add(countryItemModel);
  }

  fetchTimeline() async {
    TimelineItemModel timelineItemModel = await _repository.fetchTimeline();
    _timelineFetcher.sink.add(timelineItemModel);
  }

  fetchToday() async {
    DateItemModel dateItemModel = await _repository.fetchToday();
    _todayFetcher.sink.add(dateItemModel);
  }

  fetchYesterday() async {
    DateItemModel dateItemModel = await _repository.fetchYesterday();
    _yesterdayFetcher.sink.add(dateItemModel);
  }

  dispose() {
    _countryFetcher.close();
    _timelineFetcher.close();
    _todayFetcher.close();
    _yesterdayFetcher.close();
  }
}

final bloc = CovidBloc();
