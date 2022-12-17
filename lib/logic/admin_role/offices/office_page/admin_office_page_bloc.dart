import 'package:atb_booking/data/models/level_plan.dart';
import 'package:atb_booking/data/models/office.dart';
import 'package:atb_booking/data/services/level_plan_provider.dart';
import 'package:atb_booking/data/services/office_provider.dart';
import 'package:atb_booking/data/services/office_repository.dart';
import 'package:atb_booking/logic/admin_role/offices/LevelPlanEditor/level_plan_editor_bloc.dart';
import 'package:atb_booking/presentation/interface/admin_role/offices/level_editor_page.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'admin_office_page_event.dart';

part 'admin_office_page_state.dart';

class AdminOfficePageBloc
    extends Bloc<AdminOfficePageEvent, AdminOfficePageState> {
  Office? office;
  String? address;
  int? bookingRangeDays = 5;
  DateTimeRange? workRange;
  List<LevelListItem>? levels;

  bool isSaveButtonActive() {
    return !(office!.address == address && office!.workTimeRange == workRange && office!.maxBookingRangeInDays == bookingRangeDays);
  }

  AdminOfficePageBloc() : super(AdminOfficePageInitial()) {
    on<OfficePageLoadEvent>((event, emit) async {
      print("emit loading state");
      emit(AdminOfficePageLoadingState());
      try {
        print("emit loaded state");
        office = await OfficeProvider().getOfficeById(event.officeId);
        levels = await OfficeRepository().getLevelsByOfficeId(office!.id);
        address = office!.address!;
        bookingRangeDays = office!.maxBookingRangeInDays;
        workRange = office!.workTimeRange;
        emit(AdminOfficePageLoadedState(address!, bookingRangeDays!,
            workRange!, isSaveButtonActive(), levels!));
      } catch (_) {
        print(_);
        emit(AdminOfficePageErrorState());
      }
    });
    on< OfficePageReloadEvent>((event, emit) async {
      print("emit loading state");
      emit(AdminOfficePageLoadingState());
      try {
        print("emit loaded state");
        office = await OfficeProvider().getOfficeById(office!.id);
        levels = await OfficeRepository().getLevelsByOfficeId(office!.id);
        address = office!.address!;
        bookingRangeDays = office!.maxBookingRangeInDays;
        workRange = office!.workTimeRange;
        emit(AdminOfficePageLoadedState(address!, bookingRangeDays!,
            workRange!, isSaveButtonActive(), levels!));
      } catch (_) {
        print(_);
        emit(AdminOfficePageErrorState());
      }
    });
    on<AdminOfficePageCreateNewLevelButtonPress>((event,emit) async {
      int number = 1;
      for(var level in levels!){
        if(number<=level.number){
          number = level.number+1;
        }
      }
      try{
        int createdLevelId = await LevelProvider().createLevel(office!.id,number);
        ///
        ///
        /// ну вот таквота))))))
        /// извиняюсь
        event.context.read<LevelPlanEditorBloc>().add(LevelPlanEditorLoadWorkspacesFromServerEvent(createdLevelId));
        add(OfficePageLoadEvent(office!.id));
      }catch(_){
        print(_);
      }
    });
    on<AdminOfficeAddressChangeEvent>((event, emit) {
      address = event.address;
      print("emit loaded state");
      emit(AdminOfficePageLoadedState(address!, bookingRangeDays!, workRange!,
          isSaveButtonActive(), levels!)); /// эмитить не нужно потом что textfield изменяется сам. контроллер - статик
    });
    on<AdminBookingRangeChangeEvent>((event, emit) {
      bookingRangeDays = event.bookingRange;
      print("emit loaded state");
      // emit(AdminOfficePageLoadedState(address!,bookingRangeDays!)); /// эмитить не нужно потом что textfield изменяется сам, потому что контроллер статик
    });
    on<AdminOfficeSaveChangesButtonEvent>((event,emit)async {
      var newOfficeData = Office(id:office!.id,address: address!,maxBookingRangeInDays: bookingRangeDays!,workTimeRange:workRange!);
        try {
          await OfficeProvider().changeOffice(newOfficeData);
          office = newOfficeData;
          emit(AdminOfficePageLoadedState(address!, bookingRangeDays!, workRange!,
              isSaveButtonActive(), levels!));
        }catch(_){
          print(_);
          add(OfficePageLoadEvent(office!.id));
        }
    });
    on<AdminOfficePageUpdateFieldsEvent>((event, emit) {
      emit(AdminOfficePageLoadedState(address!, bookingRangeDays!, workRange!,
          isSaveButtonActive(), levels!));
    });
    on<AdminOfficePageWorkRangeChangeEvent>((event, emit) {
      workRange = event.newWorkTimeRange;
      emit(AdminOfficePageLoadedState(address!, bookingRangeDays!, workRange!,
          isSaveButtonActive(), levels!));
    });
  }
}
