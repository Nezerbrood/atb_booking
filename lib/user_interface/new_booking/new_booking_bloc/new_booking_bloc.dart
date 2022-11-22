// import 'dart:async';
//
// import 'package:atb_booking/data/services/city_provider.dart';
// import 'package:atb_booking/data/services/city_repository.dart';
// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';
//
// import '../../../data/dataclasses/city.dart';
//
// part 'new_booking_event.dart';
// part 'new_booking_state.dart';
//
// class NewBookingBloc extends Bloc<NewBookingEvent, NewBookingState> {
//   List<City> cities = [];// CityRepository().getAllCities();
//   loadCities() async {
//     cities = await CityRepository().getAllCities();
//     //this.add(NewBooking())
//   }
//   NewBookingBloc() : super(NewBookingStartState(cities)) {
//     on<NewBookingEvent>((event, emit) {
//       // TODO: implement event handler
//     });
//   }
// }
