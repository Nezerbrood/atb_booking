import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'new_booking_confirmation_popup_event.dart';
part 'new_booking_confirmation_popup_state.dart';

class NewBookingConfirmationPopupBloc extends Bloc<NewBookingConfirmationPopupEvent, NewBookingConfirmationPopupState> {

  static final NewBookingConfirmationPopupBloc _singleton = NewBookingConfirmationPopupBloc._internal();

  factory NewBookingConfirmationPopupBloc() {
    return _singleton;
  }
  NewBookingConfirmationPopupBloc._internal() : super(NewBookingConfirmationPopupInitialState()) {
    on<NewBookingConfirmationPopupEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<NewBookingConfirmationLoadEvent>((event, emit) {
      emit(NewBookingConfirmationPopupLoadingState());
    });
    on<NewBookingConfirmationSuccessEvent>((event, emit) {
      emit(NewBookingConfirmationPopupSuccessfulState());
    });
    on<NewBookingConfirmationErrorEvent>((event, emit) {
      emit(NewBookingConfirmationPopupErrorState());
    });
  }
}
