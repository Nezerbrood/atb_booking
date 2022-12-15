part of 'admin_offices_bloc.dart';

@immutable
abstract class AdminOfficesState {
  final Future<List<City>> futureCityList;

  const AdminOfficesState(this.futureCityList);
}

class AdminOfficesInitial extends AdminOfficesState {
  const AdminOfficesInitial(super.futureCityList);
}
class AdminOfficesLoadingState extends AdminOfficesState{
  const AdminOfficesLoadingState(super.futureCityList);
}
class AdminOfficesLoadedState extends AdminOfficesState{
  final List<Office> offices;
  const AdminOfficesLoadedState(super.futureCityList, this.offices);
}
class AdminOfficesErrorState extends AdminOfficesState{
  const AdminOfficesErrorState(super.futureCityList);
}
