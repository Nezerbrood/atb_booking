part of 'booking_list_bloc.dart';
abstract class BookingListState {}

class BookingListLoadingState extends BookingListState{
}
class BookingListLoadedState extends BookingListState{
  List<Booking> bookingList;
  Map<int,WorkspaceType> mapOfTypes;
  BookingListLoadedState({required this.bookingList, required this.mapOfTypes});
}
class BookingListEmptyState extends BookingListState{
  List<dynamic> loadedList = [];
}
class BookingListErrorState extends BookingListState{

}
