
import 'package:atb_booking/logic/user_role/booking/booking_details_bloc/booking_details_bloc.dart';
import 'package:atb_booking/presentation/constants/styles.dart';
import 'package:atb_booking/presentation/interface/user_role/booking/booking_details/booking_delete_confirmation_popup.dart';
import 'package:atb_booking/presentation/interface/user_role/booking/booking_details/locked_plan/booking_added_people_widget.dart';
import 'package:atb_booking/presentation/interface/user_role/booking/booking_details/locked_plan/planWidget.dart';
import 'package:atb_booking/presentation/widgets/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class BookingDetailsScreen extends StatelessWidget {
  const BookingDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookingDetailsBloc, BookingDetailsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is BookingDetailsLoadedState) {
          getPhotoSize() {
            if (state.booking.workspace.photos.isEmpty) return 0.0;
            if (state.booking.workspace.photos.length == 1) return 250.0;
            return 200.0;
          }

          return Scaffold(
            appBar: AppBar(
              title: Text("Бронь №${state.booking.id}"),
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ///
                  ///
                  /// Фотографии рабочего места.
                  SizedBox(
                    height: getPhotoSize(), //getSize(),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Center(
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: state.booking.workspace.photos.length,
                            //state.workspace.photos.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                child:
                                    state.booking.workspace.photos[index].photo,
                                onTap: () {
                                  showDialog(
                                      useRootNavigator: false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return GestureDetector(
                                          behavior: HitTestBehavior.translucent,
                                          onTap: () {
                                            int count = 0;
                                            Navigator.popUntil(context,
                                                (route) {
                                              return count++ == 1;
                                            });
                                          },
                                          child: InteractiveViewer(
                                            transformationController:
                                                TransformationController(),
                                            maxScale: 2.0,
                                            minScale: 0.1,
                                            child: AlertDialog(
                                              //clipBehavior: Clip.none,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  0.0))),
                                              insetPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 200),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 10),
                                              content: state.booking.workspace
                                                  .photos[index].photo,
                                            ),
                                          ),
                                        );
                                      });
                                },
                              );
                            }),
                      ),
                    ),
                  ),
                  ///
                  ///
                  /// Кнопки показа карты и людей
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 1, color: appThemeData.primaryColor),
                            borderRadius: BorderRadius.circular(7.0)),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(00.0)),
                                    insetPadding: const EdgeInsets.symmetric(horizontal: 00,vertical: 00),
                                    titlePadding: const EdgeInsets.symmetric(horizontal: 00,vertical:00),
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 00,vertical:00),
                                    clipBehavior: Clip.none,
                                    content: SizedBox(
                                        width: 350,
                                        height: 350,
                                        child: LockedPlanWidget()));
                              });
                        },
                        color: appThemeData.primaryColor,
                        child: Row(
                          children: [
                            Text(
                              (state.booking.guests != null &&
                                      state.booking.guests!.isNotEmpty)
                                  ? "Показать\nна карте"
                                  : "Показать на карте",
                              style:
                                  appThemeData.textTheme.titleMedium!.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Icon(Icons.place)
                          ],
                        ),
                      ),
                      if (state.booking.guests != null &&
                          state.booking.guests!.isNotEmpty)
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1, color: appThemeData.primaryColor),
                              borderRadius: BorderRadius.circular(7.0)),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return const BookingAddedPeopleWidget();
                                });
                          },
                          color: appThemeData.primaryColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Добавленные\nлюди",
                                style: appThemeData.textTheme.titleMedium!
                                    .copyWith(
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.end,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(Icons.people),
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.white),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20))),
                                child: Center(
                                    child: Text(
                                  state.booking.guests!.length.toString(),
                                  style: appThemeData.textTheme.titleMedium!
                                      .copyWith(
                                          color: appThemeData.primaryColor),
                                )),
                              )
                            ],
                          ),
                        )
                    ],
                  ),

                  ///
                  ///
                  /// Описание рабочего места
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 5),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Text("Описание",
                              textAlign: TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                      color: Colors.black54,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w300)),
                        ),
                        Container(
                          height: 0.3,
                          color: Colors.black54,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Text(state.booking.workspace.description,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                      color: Colors.black, fontSize: 23)),
                        ),
                      ],
                    ),
                  ),

                  ///
                  ///
                  ///Название и этаж
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 5),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Text("Место",
                              textAlign: TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                      color: Colors.black54,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w300)),
                        ),
                        Container(
                          height: 0.3,
                          color: Colors.black54,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                              "${state.booking.workspace.type.type} ${state.booking.workspace.level} Этаж",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                      color: Colors.black, fontSize: 23)),
                        ),
                      ],
                    ),
                  ),

                  ///
                  ///
                  /// ОФИС
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 5),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Text("Офис",
                              textAlign: TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                      color: Colors.black54,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w300)),
                        ),
                        Container(
                          height: 0.3,
                          color: Colors.black54,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                              '${state.booking.cityName}. ${state.booking.officeAddress}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                      color: Colors.black, fontSize: 24)),
                        ),
                      ],
                    ),
                  ),

                  ///
                  ///
                  /// ДАТА
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 5),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Text("Дата",
                              textAlign: TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                      color: Colors.black54,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w300)),
                        ),
                        Container(
                          height: 0.3,
                          color: Colors.black54,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            DateFormat.yMMMMd("ru_RU").format(
                                state.booking.reservationInterval.start),
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(color: Colors.black, fontSize: 24),
                          ),
                        ),
                      ],
                    ),
                  ),

                  ///
                  ///
                  /// ВРЕМЯ
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 5),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Text("Время",
                              textAlign: TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                      color: Colors.black54,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w300)),
                        ),
                        Container(
                          height: 0.3,
                          color: Colors.black54,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            "c ${DateFormat('HH:mm').format(state.booking.reservationInterval.start)} до ${DateFormat('HH:mm').format(state.booking.reservationInterval.end)}",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(color: Colors.black, fontSize: 24),
                          ),
                        ),
                      ],
                    ),
                  ),

                  ///
                  ///
                  /// КНОПКА ОТМЕНЫ
                  (state.buttonIsShow)
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 30),
                          child: AtbElevatedButton(
                            onPressed: () {
                              BookingDetailsBloc()
                                  .add(BookingDetailsDeleteEvent());
                              showDialog(
                                useRootNavigator: false,
                                context: context,
                                builder: (BuildContext context) {
                                  return const BookingDeleteConfirmationPopup();
                                },
                              );
                            },
                            text: "Отменить",
                          ))
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          );
        } else if (state is BookingDetailsLoadingState) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        } else if (state is BookingDetailsErrorState) {
          return ErrorWidget(Exception("Error state"));
        } else if (state is BookingDetailsDeletedState) {
          getPhotoSize() {
            if (state.booking.workspace.photos.isEmpty) return 0.0;
            if (state.booking.workspace.photos.length == 1) return 250.0;
            return 200.0;
          }

          return Scaffold(
            appBar: AppBar(
              title: Text("Бронь №${state.booking.id}"),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    //height: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ///
                          ///
                          /// Фотографии рабочего места.
                          SizedBox(
                            height: getPhotoSize(), //getSize(),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: Center(
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        state.booking.workspace.photos.length,
                                    //state.workspace.photos.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        behavior: HitTestBehavior.translucent,
                                        child: state.booking.workspace
                                            .photos[index].photo,
                                        onTap: () {
                                          showDialog(
                                              useRootNavigator: false,
                                              context: context,
                                              builder: (BuildContext context) {
                                                return GestureDetector(
                                                  behavior: HitTestBehavior
                                                      .translucent,
                                                  onTap: () {
                                                    int count = 0;
                                                    Navigator.popUntil(context,
                                                        (route) {
                                                      return count++ == 1;
                                                    });
                                                  },
                                                  child: InteractiveViewer(
                                                    transformationController:
                                                        TransformationController(),
                                                    maxScale: 2.0,
                                                    minScale: 0.1,
                                                    child: AlertDialog(
                                                      //clipBehavior: Clip.none,
                                                      shape: const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          0.0))),
                                                      insetPadding:
                                                          const EdgeInsets
                                                                  .symmetric(
                                                              horizontal: 10,
                                                              vertical: 200),
                                                      contentPadding:
                                                          const EdgeInsets
                                                                  .symmetric(
                                                              horizontal: 10,
                                                              vertical: 10),
                                                      content: state
                                                          .booking
                                                          .workspace
                                                          .photos[index]
                                                          .photo,
                                                    ),
                                                  ),
                                                );
                                              });
                                        },
                                      );
                                    }),
                              ),
                            ),
                          ),

                          ///
                          ///
                          /// Описание рабочего места
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 5),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: Text("Описание",
                                      textAlign: TextAlign.left,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(
                                              color: Colors.black54,
                                              fontSize: 24,
                                              fontWeight: FontWeight.w300)),
                                ),
                                Container(
                                  height: 0.3,
                                  color: Colors.black54,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                      state.booking.workspace.description,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(
                                              color: Colors.black,
                                              fontSize: 23)),
                                ),
                              ],
                            ),
                          ),

                          ///
                          ///
                          ///Название и этаж
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 5),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: Text("Место",
                                      textAlign: TextAlign.left,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(
                                              color: Colors.black54,
                                              fontSize: 24,
                                              fontWeight: FontWeight.w300)),
                                ),
                                Container(
                                  height: 0.3,
                                  color: Colors.black54,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                      "${state.booking.workspace.type.type} ${state.booking.workspace.level} Этаж",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(
                                              color: Colors.black,
                                              fontSize: 23)),
                                ),
                              ],
                            ),
                          ),

                          ///
                          ///
                          /// ОФИС
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 5),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: Text("Офис",
                                      textAlign: TextAlign.left,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(
                                              color: Colors.black54,
                                              fontSize: 24,
                                              fontWeight: FontWeight.w300)),
                                ),
                                Container(
                                  height: 0.3,
                                  color: Colors.black54,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                      '${state.booking.cityName} ${state.booking.officeAddress}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(
                                              color: Colors.black,
                                              fontSize: 24)),
                                ),
                              ],
                            ),
                          ),

                          ///
                          ///
                          /// ДАТА
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 5),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: Text("Дата",
                                      textAlign: TextAlign.left,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(
                                              color: Colors.black54,
                                              fontSize: 24,
                                              fontWeight: FontWeight.w300)),
                                ),
                                Container(
                                  height: 0.3,
                                  color: Colors.black54,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    DateFormat.yMMMMd("ru_RU").format(state
                                        .booking.reservationInterval.start),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                            color: Colors.black, fontSize: 24),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          ///
                          ///
                          /// ВРЕМЯ
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 5),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: Text("Время",
                                      textAlign: TextAlign.left,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(
                                              color: Colors.black54,
                                              fontSize: 24,
                                              fontWeight: FontWeight.w300)),
                                ),
                                Container(
                                  height: 0.3,
                                  color: Colors.black54,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    'c ' +
                                        DateFormat('HH:mm').format(state.booking
                                            .reservationInterval.start) +
                                        " до " +
                                        DateFormat('HH:mm').format(state
                                            .booking.reservationInterval.end),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                            color: Colors.black, fontSize: 24),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "БРОНЬ ОТМЕНЕНА",
                              textAlign: TextAlign.center,
                              style: appThemeData.textTheme.displaySmall!
                                  .copyWith(
                                      color:
                                          const Color.fromARGB(255, 72, 0, 0),
                                      fontSize: 30),
                            ),
                          ),

                          /// КНОПКА НАЗАД
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          throw Exception("State exception");
        }
      },
    );
  }
}