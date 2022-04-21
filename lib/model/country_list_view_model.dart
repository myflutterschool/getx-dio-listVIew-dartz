import 'package:countries_list/model/country_data_view_model.dart';

class CountryListViewModel {
  bool? error;
  String? msg;
  List<CountryDataViewModel>? countriesData;

  CountryListViewModel({this.error, this.msg, this.countriesData});

  CountryListViewModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    msg = json['msg'];
    countriesData = (json['data'] as List)
        .map((final element) => CountryDataViewModel.fromJson(element))
        .toList();
  }
}
