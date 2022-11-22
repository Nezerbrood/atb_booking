import '../models/city.dart';
import 'city_provider.dart';

class CityRepository{
  final CityProvider _cityProvider = CityProvider();
  Future<List<City>> getAllCities() => _cityProvider.getAllCities();
  //Future<List<City>> getCityById(int id)=>_cityProvider.getCityById(id);
}