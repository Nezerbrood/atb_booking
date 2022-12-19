
import 'package:atb_booking/data/models/user.dart';
import 'package:atb_booking/data/services/image_provider.dart';
import 'package:atb_booking/data/services/network/network_controller.dart';
import 'package:atb_booking/logic/user_role/feedback_bloc/feedback_bloc.dart';
import 'package:atb_booking/logic/user_role/people_bloc/people_bloc.dart';
import 'package:atb_booking/logic/user_role/people_profile_bloc/people_profile_booking_bloc.dart';
import 'package:atb_booking/presentation/constants/styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../feedback/feedback_screen.dart';
import 'person_profile_screen.dart';

class PersonCard extends StatelessWidget {
  final User user;

  const PersonCard(this.user, {super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
        child: GestureDetector(
      onTap: () async {
        PeopleProfileBookingBloc()
            .add(PeopleProfileBookingLoadEvent(id: user.id));
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PersonProfileScreen(user),
          ),
        );
      },
      child: Card(
          semanticContainer: true,
          elevation: 1,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
              side: BorderSide(
                  width: 1, color: appThemeData.colorScheme.tertiary),
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
                        child: Container(
                          child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: AppImageProvider
                                  .getImageUrlFromImageId(user.avatarImageId,),
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
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ),
                    user.isFavorite
                        ? Icon(Icons.star, color: appThemeData.primaryColor)
                        : const SizedBox.shrink()
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
                trailing: GestureDetector(
                    onTap: () {
                      _showSimpleDialog(context, user);
                    },
                    child: const Icon(Icons.more_vert, color: Colors.black)),
                dense: true,
                minLeadingWidth: 100,
              ))
            ],
          )),
    ));
  }
}

void _showSimpleDialog(BuildContext contextDialog, User user) {
  showDialog(
      context: contextDialog,
      builder: (context) {
        return BlocProvider.value(
          value: BlocProvider.of<PeopleBloc>(contextDialog),
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
                  Navigator.of(contextDialog).push(MaterialPageRoute(
                      builder: (contextBuilder) => BlocProvider.value(
                            value:
                                BlocProvider.of<FeedbackBloc>(contextDialog),
                            child: const FeedBackScreen(),
                          )));
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
                        .read<PeopleBloc>()
                        .add(PeopleAddingToFavoriteEvent(user));
                    Navigator.pop(context);
                  } else {
                    // TODO удалить из избранных
                    contextDialog
                        .read<PeopleBloc>()
                        .add(PeopleRemoveFromFavoriteEvent(user));
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
                      const Icon(
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

Future<void> _feedbackTransition(BuildContext functionContext) async {
  Navigator.push(
      functionContext,
      MaterialPageRoute(
          builder: (context) => BlocProvider.value(
                value: BlocProvider.of<FeedbackBloc>(functionContext),
                child: const FeedBackScreen(),
              )));
}
