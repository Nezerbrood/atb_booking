
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'booking_delete_confirmation_event.dart';

part 'booking_delete_confirmation_state.dart';

class BookingDeleteConfirmationBloc extends Bloc<BookingDeleteConfirmationEvent,
    BookingDeleteConfirmationState> {
  static final BookingDeleteConfirmationBloc _singleton = BookingDeleteConfirmationBloc._internal();

  factory BookingDeleteConfirmationBloc() {
    return _singleton;
  }
  BookingDeleteConfirmationBloc._internal()
      : super(BookingDeleteConfirmationInitialState()) {
    on<BookingDeleteConfirmationLoadEvent>((event, emit) {
      emit(BookingDeleteConfirmationLoadingState());
    });

    on<BookingDeleteConfirmationErrorEvent>((event, emit) {
      emit(BookingDeleteConfirmationErrorState());
    });
    on<BookingDeleteConfirmationSuccessEvent>((event, emit) {
      emit(BookingDeleteConfirmationSuccessState());
    });

    emit(BookingDeleteConfirmationLoadingState());
  }
}
