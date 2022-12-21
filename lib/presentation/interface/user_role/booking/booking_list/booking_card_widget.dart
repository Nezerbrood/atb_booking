import 'package:atb_booking/data/models/booking.dart';
import 'package:atb_booking/data/services/image_provider.dart';
import 'package:atb_booking/data/services/network/network_controller.dart';
import 'package:atb_booking/presentation/constants/styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class _WorkspaceRow extends StatelessWidget {
  const _WorkspaceRow(this.booking);

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            booking.workspace.type.type,
            style: appThemeData.textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.w600,
              height: 0,
            ),
          ),
        ),
      ),
    );
  }
}

class _DateRow extends StatelessWidget {
  const _DateRow(this.booking);

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    String dateString = '';
    print(booking.reservationInterval.start.toLocal());
    print(DateTime.now().toLocal().day);
    if (booking.reservationInterval.start.toLocal().day ==
        DateTime.now().toLocal().day) {
      print(booking.reservationInterval.start.toLocal());
      print(DateTime.now().toLocal().day);
      dateString = "Сегодня";
    } else if (booking.reservationInterval.start.day ==
        DateTime.now().day + 1) {
      dateString = "Завтра";
    } else {
      dateString =
          DateFormat.MMMMd("ru_RU").format(booking.reservationInterval.start);
    }
    // Text(
    // 'c ' +
    // DateFormat('HH:mm').format(booking.reservationInterval.start) +
    // " до " +
    // DateFormat('HH:mm').format(booking.reservationInterval.end) +
    // '\n' +
    // DateFormat.MMMMd("ru_RU").format(booking.reservationInterval.start),
    // style: appThemeData.textTheme.titleMedium,
    // ),
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            dateString,
            style: appThemeData.textTheme.bodyMedium!
                .copyWith(height: 0, fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }
}

class _TimeRow extends StatelessWidget {
  const _TimeRow(this.booking);

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    String text = 'c ' +
        DateFormat('HH:mm').format(booking.reservationInterval.start) +
        " до " +
        DateFormat('HH:mm').format(booking.reservationInterval.end);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        decoration: BoxDecoration(
          color: AtbAdditionalColors.black7,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            text,
            style: appThemeData.textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
        ),
      ),
    );
  }
}

class _AddressRow extends StatelessWidget {
  const _AddressRow(this.booking);

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        decoration: BoxDecoration(
          color: AtbAdditionalColors.black7,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            "${booking.officeAddress}, ${booking.workspace.level} этаж",
            style: appThemeData.textTheme.bodySmall!.copyWith(
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          ),
        ),
      ),
    );
  }
}

class _Image extends StatelessWidget {
  const _Image(this.booking);

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    if (booking.workspace.photosIds.isEmpty) {
      return const SizedBox.shrink();
    } else {
      return Container(
        child: CachedNetworkImage(
            fit: BoxFit.fitWidth,
            imageUrl: AppImageProvider.getImageUrlFromImageId(
                booking.workspace.photosIds.first),
            httpHeaders: NetworkController().getAuthHeader(),
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Center(
                    child: CircularProgressIndicator(
                        value: downloadProgress.progress)),
            errorWidget: (context, url, error) => const Icon(Icons.error)),
      );
    }
  }
}

class BookingCard extends StatelessWidget {
  String? type;
  Booking booking;
  final String asset;
  final CachedNetworkImage? image;
  bool trailing = true;
  bool isGuestBooking;

  BookingCard(
      this.booking, this.type, this.asset, this.image, this.isGuestBooking,
      {super.key, this.trailing = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 1,
          shape: RoundedRectangleBorder(
              side: const BorderSide(
                  width: 0.3, color: Color.fromARGB(255, 200, 194, 207)),
              borderRadius: BorderRadius.circular(20.0)),
          color: Colors.white,
          child: Stack(
            alignment: Alignment.centerLeft,
              children: [
            Row(
              children: [
                Expanded(
                  flex: 65,
                  child: Container(),
                ),
                Expanded(flex: 35, child: _Image(booking)),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 65,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _DateRow(booking),
                        Row(
                          children: [
                            _TimeRow(booking),
                          ],
                        ),
                        _WorkspaceRow(booking),
                        _AddressRow(booking),
                      ],
                    ),
                  ),
                ),
                Expanded(flex: 35, child: Container()),
              ],
            ),
          ])),
    );
  }

  _getImage() {
    return Container(width: 110, height: 110, child: image);
  }
}
