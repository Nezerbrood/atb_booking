import 'package:atb_booking/data/models/user.dart';
import 'package:atb_booking/data/services/image_provider.dart';
import 'package:atb_booking/data/services/network/network_controller.dart';
import 'package:atb_booking/logic/admin_role/people/people_page/admin_people_bloc.dart';
import 'package:atb_booking/logic/admin_role/people/person_booking_list/admin_person_booking_list_bloc.dart';
import 'package:atb_booking/presentation/constants/styles.dart';
import 'package:atb_booking/presentation/interface/admin_role/people/person_booking_list.dart';
import 'package:atb_booking/presentation/interface/user_role/feedback/feedback_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminPersonCard extends StatelessWidget {
  final User user;

  const AdminPersonCard(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: GestureDetector(
      onTap: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => AdminPersonBookingListBloc(user),
              child: AdminPersonBookingListPage(),
            ),
          ),
        );
      },
      child: Card(
          semanticContainer: true,
          elevation: 1,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
              side: BorderSide(
                  width: 0, color: appThemeData.colorScheme.tertiary),
              borderRadius: BorderRadius.circular(12.0)),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ClipOval(
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: AppImageProvider.getImageUrlFromImageId(
                                user.avatarImageId,
                              ),
                              httpHeaders: NetworkController().getAuthHeader(),
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Center(
                                      child: CircularProgressIndicator(
                                          value: downloadProgress.progress)),
                              errorWidget: (context, url, error) =>
                                  Container()),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: ListTile(
                title: Text(user.fullName,
                    style: appThemeData.textTheme.titleMedium),
                subtitle: Text(
                  user.email,
                  style: appThemeData.textTheme.titleSmall,
                ),
                dense: true,
                minLeadingWidth: 100,
              ))
            ],
          )),
    ));
  }
}