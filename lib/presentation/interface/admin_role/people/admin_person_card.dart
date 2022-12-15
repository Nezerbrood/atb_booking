
import 'package:atb_booking/data/models/user.dart';
import 'package:atb_booking/logic/admin_role/people/admin_people_bloc.dart';
import 'package:atb_booking/presentation/constants/styles.dart';
import 'package:atb_booking/presentation/interface/user_role/feedback/feedback_screen.dart';
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
            // await Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (context) => PersonProfileScreen(user),
            //   ),
            // );
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
                              child: user.avatar,
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
                        title: Text(user.fullName, style: appThemeData.textTheme.titleMedium),
                        subtitle: Text(user.email, style: appThemeData.textTheme.titleSmall,),
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
          value: BlocProvider.of<AdminPeopleBloc>(contextDialog),
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
                  //todo add option
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
