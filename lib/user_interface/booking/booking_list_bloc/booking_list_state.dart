part of 'booking_list_bloc.dart';
abstract class BookingListState {}

class BookingListLoadingState extends BookingListState{
}
class BookingListLoadedState extends BookingListState{
  List<dynamic> loadedList;
  BookingListLoadedState({required this.loadedList});
}
class BookingListEmptyState extends BookingListState{
  List<dynamic> loadedList = [];
}
class BookingListErrorState extends BookingListState{

}
