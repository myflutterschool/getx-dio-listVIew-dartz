class CountryDataViewModel{
  String?name;
  String? capital;

  CountryDataViewModel({this.name, this.capital});
  CountryDataViewModel.fromJson(Map<String,dynamic>json){
    name=json['name'];
    capital=json['capital'];
  }
}