import 'package:atb_booking/data/models/office.dart';
import 'package:atb_booking/data/services/city_provider.dart';
import 'package:atb_booking/data/services/office_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Проверка провайдера CityProvider",() async {
    var result = await CityProvider().getAllCities();
    expect((result).isNotEmpty, true);
  });
  test("Проверка провайдера OfficeProvider",() async {
    var result1 = await OfficeProvider().getOfficeById(33);
    var result2 = await OfficeProvider().getOfficesByCityId(5);
    expect(result1 is Office, true);
    expect((result2).isNotEmpty, true);
  });
  print("____all tests completed successfully____");
}