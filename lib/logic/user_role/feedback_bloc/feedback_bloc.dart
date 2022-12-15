import 'package:atb_booking/data/models/city.dart';
import 'package:atb_booking/data/models/office.dart';
import 'package:atb_booking/data/services/city_repository.dart';
import 'package:atb_booking/data/services/feedback_provider.dart';
import 'package:atb_booking/data/services/office_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'feedback_event.dart';
part 'feedback_state.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  static Future<List<String>> getFutureTypeList(String? str) async {
    List<String> type = ["Отзыв", "Жалоба"];
    return type;
  }

  /// Необходимые поля
  String? selectedType;
  City? selectedCity;
  Office? selectedOffice;
  Future<List<Office>>? futureOffice;
  Future<List<City>>? futureCityList;
  String message = '';

  ///
  bool? typeFieldVisible;
  bool? cityFieldVisible;
  bool? officeFieldVisible;
  bool? messageFieldVisible;
  bool? buttonVisible;

  /// Обработчик событий
  FeedbackBloc()
      : super(FeedbackInputFieldsState(true, false, false, false, false,
            getFutureTypeList(''), null, null, '')
          ..isInitialState = true) {
    on<FeedbackTypeFormEvent>((event, emit) {
      typeFieldVisible = true;
      cityFieldVisible = false;
      officeFieldVisible = false;
      messageFieldVisible = false;
      buttonVisible = false;
      //
      selectedType = event.type;
      selectedCity = null;
      selectedOffice = null;
      if (selectedType == "Отзыв") {
        messageFieldVisible = true;
        buttonVisible = (message != '');
        emit(FeedbackInputFieldsState(
            typeFieldVisible!,
            cityFieldVisible!,
            officeFieldVisible!,
            messageFieldVisible!,
            buttonVisible!,
            getFutureTypeList(''),
            null,
            null,
            message));
      } else {
        cityFieldVisible = true;
        futureCityList = CityRepository().getAllCities();
        emit(FeedbackInputFieldsState(
            typeFieldVisible!,
            cityFieldVisible!,
            officeFieldVisible!,
            messageFieldVisible!,
            buttonVisible!,
            getFutureTypeList(''),
            futureCityList,
            null,
            message));
      }
    });
    on<FeedbackCityFormEvent>((event, emit) {
      typeFieldVisible = true;
      cityFieldVisible = true;
      officeFieldVisible = true;
      messageFieldVisible = false;
      buttonVisible = false;
      //
      selectedCity = event.city;
      selectedOffice = null;
      futureOffice = OfficeRepository().getOfficesByCityId(event.city.id);
      emit(FeedbackInputFieldsState(
          typeFieldVisible!,
          cityFieldVisible!,
          officeFieldVisible!,
          messageFieldVisible!,
          buttonVisible!,
          getFutureTypeList(''),
          futureCityList,
          futureOffice,
          message));
    });
    on<FeedbackOfficeFormEvent>((event, emit) {
      typeFieldVisible = true;
      cityFieldVisible = true;
      officeFieldVisible = true;
      messageFieldVisible = true;
      buttonVisible = false;
      //
      selectedOffice = event.office;
      buttonVisible = (message != '');
      emit(FeedbackInputFieldsState(
          typeFieldVisible!,
          cityFieldVisible!,
          officeFieldVisible!,
          messageFieldVisible!,
          buttonVisible!,
          getFutureTypeList(''),
          futureCityList,
          futureOffice,
          message));
    });
    on<FeedbackMessageInputEvent>((event, emit) {
      message = event.form;
      buttonVisible = (message != '');
      emit(FeedbackInputFieldsState(
          typeFieldVisible!,
          cityFieldVisible!,
          officeFieldVisible!,
          messageFieldVisible!,
          buttonVisible!,
          getFutureTypeList(''),
          futureCityList,
          futureOffice,
          message));
    });
    on<FeedbackButtonSubmitEvent>((event, emit) async {
      int feedbackTypeId = 3;
      int? officeId = null;
      int? workplaceId = null;
      int? guiltyId = null;

      if (selectedType == "Жалоба") {
        feedbackTypeId = 5;
        officeId = selectedOffice!.id;
      }

      try {
        emit(FeedbackPopupLoadingState());
        await FeedbackProvider().createFeedbackMessage(
            message, feedbackTypeId, officeId, workplaceId, guiltyId);
        emit(FeedbackSuccessState());
      } catch (e) {
        emit(FeedbackPopupErrorState());
      }
    });
  }
}
