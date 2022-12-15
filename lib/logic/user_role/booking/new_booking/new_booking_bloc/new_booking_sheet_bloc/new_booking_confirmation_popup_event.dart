part of 'new_booking_confirmation_popup_bloc.dart';

@immutable
abstract class NewBookingConfirmationPopupEvent {}

class NewBookingConfirmationSuccessEvent
    extends NewBookingConfirmationPopupEvent {}

class NewBookingConfirmationErrorEvent
    extends NewBookingConfirmationPopupEvent {}

class NewBookingConfirmationLoadEvent extends NewBookingConfirmationPopupEvent {
}
