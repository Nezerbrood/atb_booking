import 'package:atb_booking/data/models/user.dart';
import 'package:atb_booking/data/services/image_provider.dart';
import 'package:atb_booking/data/services/network/network_controller.dart';
import 'package:atb_booking/logic/user_role/booking/booking_details_bloc/booking_details_bloc.dart';
import 'package:atb_booking/presentation/constants/styles.dart';
import 'package:atb_booking/presentation/interface/user_role/feedback/feedback_screen.dart';
import 'package:atb_booking/presentation/widgets/elevated_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingAddedPeopleWidget extends StatelessWidget {
  const BookingAddedPeopleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<BookingDetailsBloc>(), //todo replace to context read
      child: BlocBuilder<BookingDetailsBloc, BookingDetailsState>(
          builder: (context, state) {
        if (state is BookingDetailsLoadedState) {
          var users = (state).booking.guests;
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            insetPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 50),
            titlePadding: EdgeInsets.symmetric(horizontal: 20,vertical:00),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical:00),
            clipBehavior: Clip.none,
            content:SizedBox(
              height: 600,
              width:  500,
              child: Padding(
                padding: EdgeInsets.zero,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Center(
                        child: ListView.builder(
                          shrinkWrap: false,
                          itemCount: users!.length,
                          itemBuilder: (context, index) {
                            return PeopleCard(
                              user: users[index],
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: AtbElevatedButton(onPressed:(){ (Navigator.of(context).pop());}, text: "Назад"),
                    )
                  ],
                ),
              ),
            ),
          );
        } else {
          throw Exception("Unknown bookingDetailsBloc state: $state");
        }
      }),
    );
  }
}

class PeopleCard extends StatelessWidget {
  final User user;

  const PeopleCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      // чтоб обрезал края при нажатии на карт
      child: Row(
        children: [
          Expanded(
            child: ListTile(
              leading: Stack(children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: AppImageProvider
                              .getImageUrlFromImageId(user.avatarImageId),
                          httpHeaders: NetworkController()
                              .getAuthHeader(),
                          progressIndicatorBuilder: (context,
                              url, downloadProgress) =>
                              Center(
                                  child:
                                  CircularProgressIndicator(
                                      value:
                                      downloadProgress
                                          .progress)),
                          errorWidget: (context, url, error) =>
                              Container()),
                    ),
                  ),
                ),
                user.isFavorite
                    ? Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child:
                            Icon(Icons.star, color: appThemeData.primaryColor))
                    : const SizedBox.shrink()
              ]),
              trailing: IconButton(
                  color: Colors.black,
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    _showSimpleDialog(context, user);
                  },
                  icon: const Icon(Icons.more_vert)),
              title: Text(user.fullName),
              subtitle: Text(user.email),
            ),
          ),
        ],
      ),
    );
  }
}

void _showSimpleDialog(BuildContext contextDialog, User user) {
  showDialog(
      context: contextDialog,
      builder: (context) {
        return BlocProvider.value(
          value: BlocProvider.of<BookingDetailsBloc>(contextDialog),
          child: SimpleDialog(
            title: Text(
              user.fullName,
              style: appThemeData.textTheme.headlineSmall
                  ?.copyWith(color: appThemeData.primaryColor),
            ),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () async {
                  Navigator.pop(context);
                  await _feedbackTransition(context);
                },
                child: Row(
                  children: [
                    const Icon(Icons.report_gmailerrorred),
                    const SizedBox(width: 10),
                    Text('Пожаловаться',
                        style: appThemeData.textTheme.titleMedium),
                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  // TODO сделать пользователя избранным
                  if (!user.isFavorite) {
                    contextDialog
                        .read<BookingDetailsBloc>()
                        .add(BookingDetailsToFavoriteEvent(user));
                    Navigator.pop(context);
                  } else {
                    // TODO удалить из избранных
                    contextDialog
                        .read<BookingDetailsBloc>()
                        .add(BookingDetailsRemoveFromFavoriteEvent(user));
                    Navigator.pop(context);
                  }
                },
                child: Row(
                  children: [
                    if (user.isFavorite) ...[
                      const Icon(Icons.star),
                      const SizedBox(width: 10),
                      Text('Убрать из избранного',
                          style: appThemeData.textTheme.titleMedium),
                    ] else ...[
                      Icon(
                        Icons.star_border,
                      ),
                      const SizedBox(width: 10),
                      Text('Добавить в избранные',
                          style: appThemeData.textTheme.titleMedium),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      });
}

Future<void> _feedbackTransition(BuildContext context) async {
  await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const FeedBackScreen()),
  );
}
