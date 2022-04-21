import 'package:countries_list/model/country_list_view_model.dart';
import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';

class MyRepository {
  var _dio = Dio();
  static const String _url =
      'https://countriesnow.space/api/v0.1/countries/capital';

  MyRepository() {
    _dio = Dio(BaseOptions(baseUrl: _url));
  }

  Future<Either<String, CountryListViewModel>> getAllCountries() async {
    try {
      final response = await _dio.get(_url);
      final CountryListViewModel countries =
          CountryListViewModel.fromJson(response.data);
      return Right(countries);
    } catch (dioError) {
      return Left(dioError.toString());
    }
  }
}
