import 'package:atb_booking/presentation/constants/styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class BookingCard extends StatelessWidget {
  final DateTimeRange dateTimeRange;
  String? type;
  final String asset;
  final CachedNetworkImage? image;
  bool trailing = true;

  BookingCard(this.dateTimeRange, this.type, this.asset, this.image,
      {this.trailing = true});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 1,
            shape: RoundedRectangleBorder(
                side: const BorderSide(
                    width: 0.3, color: Color.fromARGB(255, 200, 194, 207)),
                borderRadius: BorderRadius.circular(12.0)),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: Text(
                      type!,
                      style: appThemeData.textTheme.titleMedium,
                    ),
                    subtitle: Text(
                      'c ' +
                          DateFormat('HH:mm').format(dateTimeRange.start) +
                          " до " +
                          DateFormat('HH:mm').format(dateTimeRange.end) +
                          '\n' +
                          DateFormat.yMMMMd("ru_RU").format(dateTimeRange.start),
                      style: appThemeData.textTheme.titleMedium,
                    ),
                    //trailing: trailing ? Icon(Icons.cancel, color: Colors.black) : null,
                  ),
                ),
                _getImage()
                // Image.asset("assets/workplace.png",
                //     alignment: Alignment.center,
                //     width: 120,
                //     height: 120,
                //     fit: BoxFit.fill)
              ],
            )));
  }

  _getImage() {
    if (image == null){
      return Container(width: 120,height: 120,);
    }else{
      return Container(
          width:120,
          height:120,
          child: image);
    }
  }
}
