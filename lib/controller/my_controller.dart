import 'package:countries_list/model/country_data_view_model.dart';
import 'package:countries_list/model/country_list_view_model.dart';
import 'package:countries_list/repository/my_repository.dart';
import 'package:get/get.dart';
import 'package:dartz/dartz.dart';

class MyController extends GetxController {
  final MyRepository _repository = MyRepository();
  RxBool isLoadingGetAllCountries = false.obs,hasError=false.obs;
  final String errorMessage='An error has occurred';
  RxList<CountryDataViewModel>countries = <CountryDataViewModel>[].obs;

  Future<void> getAllCountries() async {
    isLoadingGetAllCountries(true);
    final Either<String, CountryListViewModel> resultOrException =
    await _repository.getAllCountries();
    resultOrException.fold((left) {
      isLoadingGetAllCountries(false);
      hasError(true);
    }, (data) {
      isLoadingGetAllCountries(false);
      countries(data.countriesData);
    });
  }

  Future<void>onRefresh()async{
    hasError(false);
    countries.clear();
    await getAllCountries();
  }

  @override
  void onInit() {
    getAllCountries();
    super.onInit();
  }
}
