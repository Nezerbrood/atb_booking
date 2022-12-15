import 'dart:async';

import 'package:atb_booking/data/models/city.dart';
import 'package:atb_booking/data/services/city_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'new_office_page_event.dart';

part 'new_office_page_state.dart';

class NewOfficePageBloc extends Bloc<NewOfficePageEvent, NewOfficePageState> {
  City? selectedCity;
  Future<List<City>> futureCityList = CityRepository().getAllCities();
  String address = "";
  int bookingRange = 60;
  DateTimeRange? workTimeRange = DateTimeRange(
      start: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 8),
      end: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 20));

  NewOfficePageBloc()
      : super(NewOfficePageInitialState(CityRepository().getAllCities())) {
    on<NewOfficePageWorkTimeRangeChangeEvent>((event, emit) {
      workTimeRange = event.newWorkTimeRange;
      emit(NewOfficePageLoadedState(futureCityList, address, bookingRange, workTimeRange!));
    });
    on<NewOfficePageCitySelectedEvent>((event, emit) {
      selectedCity = event.selectedCity;
      emit(NewOfficePageLoadedState(
          futureCityList, address, bookingRange, workTimeRange!));
    });
    on<NewOfficePageUpdateFieldsEvent>((event,emit){
      emit(NewOfficePageLoadedState(
          futureCityList, address, bookingRange, workTimeRange!));
    });
    on<NewOfficeBookingRangeChangeEvent>((event,emit){
     bookingRange = event.newRange;
      emit(NewOfficePageLoadedState(
          futureCityList, address, bookingRange, workTimeRange!));
    });
    on<NewOfficePageAddressChangeEvent>((event,emit){
      address = event.newAddress;
      emit(NewOfficePageLoadedState(
          futureCityList, address, bookingRange, workTimeRange!));
    });
  }
}
