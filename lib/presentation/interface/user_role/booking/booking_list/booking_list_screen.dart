import 'dart:convert';

import 'package:atb_booking/data/models/booking.dart';
import 'package:atb_booking/data/models/workspace_type.dart';
import 'package:atb_booking/data/services/image_provider.dart';
import 'package:atb_booking/data/services/network/network_controller.dart';
import 'package:atb_booking/logic/user_role/booking/booking_details_bloc/booking_details_bloc.dart';
import 'package:atb_booking/logic/user_role/booking/booking_list_bloc/booking_list_bloc.dart';
import 'package:atb_booking/presentation/constants/styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../booking_details/booking_details_screen.dart';
import '../new_booking/new_booking_screen.dart';
import 'booking_card_widget.dart';

class _FilterButtons extends StatelessWidget {
  const _FilterButtons({Key? key}) : super(key: key);
  static const List<Widget> fruits = <Widget>[
    Text('Мои'),
    Text('Гостевые'),
    Text('Все')
  ];
  static final List<bool> filterList = <bool>[true, false, false];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingListBloc, BookingListState>(
      builder: (context, state) {
        if(state is BookingListLoadedState){
        var _selectedFruits = state.selectedFruits;
        return ToggleButtons(
          onPressed: (int index) {
            context.read<BookingListBloc>().add(BookingListFilterChangeEvent(index));
          },
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          selectedBorderColor: appThemeData.primaryColor,
          selectedColor: Colors.white,

          fillColor: appThemeData.primaryColor,
          // color: Colors.red[400],
          constraints: const BoxConstraints(
            minHeight: 40.0,
            minWidth: 110.0,
          ),
          isSelected: _selectedFruits,
          children: fruits,
        );
        }else{
          throw Exception("unexpected state: $state");
        }
      },
    );
  }
}

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return BlocConsumer<BookingListBloc, BookingListState>(
        listener: (context, state) {
          // TODO: implement listener
        }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Center(
            child: _FilterButtons(),
          ),
        ),
        body: (state is BookingListLoadingState)
            ? const Padding(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0),
            child: Center(
              child: CircularProgressIndicator(),
            ))
            : (state is BookingListLoadedState)
            ? Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 00.0, 10.0, 0),
          child: Stack(children: <Widget>[
            Scrollbar(
              child: ListView.builder(
                controller: scrollController,
                itemCount: state.bookingList.length,
                itemBuilder: (context, index) {
                  final item = state.bookingList[index];
                  return GestureDetector(
                    onTap: () {
                      BookingListBloc()
                          .add(BookingCardTapEvent(item.id));
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              BlocProvider<BookingDetailsBloc>(
                                create: (context) =>
                                    BookingDetailsBloc(
                                        state.bookingList[index].id, true),
                                child: BookingDetailsScreen(),
                              )));
                    },
                    child: getBookingCard(
                        state.bookingList[index], state.mapOfTypes),
                  );
                },
              ),
            ),
          ]),
        )
            : (state is BookingListEmptyState)
            ? Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0),
            child: Center(
              child: Text(
                "Добавьте бронь с помощью кнопки ниже",
                textAlign: TextAlign.center,
                style: appThemeData.textTheme.titleLarge,
              ),
            ))
            : const Center(
          child: CircularProgressIndicator(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // NewBookingBloc().add(NewBookingReloadCitiesEvent());
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const NewBookingScreen()));
          },
          child: const Icon(Icons.add, color: Colors.white),
        ),
      );
    });
  }
}

BookingCard getBookingCard(Booking bookingData,
    Map<int, WorkspaceType> mapOfTypes,) {
  return BookingCard(
      bookingData.reservationInterval,
      bookingData.workspace.type.type,
      "assets/workplacelogo.png",
      (bookingData.workspace.photosIds.isEmpty)
          ? null
          : CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: AppImageProvider.getImageUrlFromImageId(
            bookingData.workspace.photosIds[0]),
        httpHeaders: NetworkController().getAuthHeader(),
        placeholder: (context, url) => const Center(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ));
}
