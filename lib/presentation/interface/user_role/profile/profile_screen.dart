import 'package:atb_booking/data/services/image_provider.dart';
import 'package:atb_booking/data/services/network/network_controller.dart';
import 'package:atb_booking/logic/user_role/booking/booking_list_bloc/booking_list_bloc.dart';
import 'package:atb_booking/logic/user_role/feedback_bloc/feedback_bloc.dart';
import 'package:atb_booking/logic/user_role/profile_bloc/profile_bloc.dart';
import 'package:atb_booking/presentation/constants/styles.dart';
import 'package:atb_booking/presentation/interface/auth/auth_screen.dart';
import 'package:atb_booking/presentation/interface/user_role/feedback/feedback_screen.dart';
import 'package:atb_booking/presentation/widgets/elevated_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void _exitToAuth(BuildContext mainContext) async {
  await showDialog(
    useRootNavigator: true,
      context: mainContext,
      builder: (context) => AlertDialog(
            title: Text(
              "Вы действительно хотите выйти?",
              style: TextStyle(color: appThemeData.colorScheme.primary),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(mainContext).pushReplacementNamed('/auth');
                  Navigator.of(context).pop();
                  ProfileBloc().add(ProfileExitToAuthEvent());
                },
                child: const Text('Выйти'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, 'Cancel');
                },
                child: const Text('Остаться'),
              ),
            ],
          ));
}

void _bubbleTransition(BuildContext context) async {
  await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) {
      return BlocProvider<FeedbackBloc>(
        create: (context) => FeedbackBloc(),
        child: const FeedBackScreen(),
      );
    }),
  );
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                BookingListBloc().add(BookingListInitialEvent());
                Navigator.pushReplacement(context,  MaterialPageRoute(builder: (_) => const Auth()));
                },
              icon: const Icon(Icons.logout, size: 28))
        ],
        title: Text(
          "Профиль",
          style: appThemeData.textTheme.displayLarge?.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: appThemeData.colorScheme.onSurface),
        ),
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is ProfileLoadedState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 35),
                  _UserTitle(
                    avatar: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: AppImageProvider
                            .getImageUrlFromImageId(state.userPerson.avatarImageId,),
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
                    userName: state.userPerson.fullName,
                  ),
                  const SizedBox(height: 55),
                  _UserInfo(
                      email: state.userPerson.email,
                      number: state.userPerson.phone),
                  const SizedBox(height: 65),
                  GestureDetector(
                      onTap: () {
                        _bubbleTransition(context);
                      },
                      child: const _UserBubbleButton()),
                  const SizedBox(height: 20)
                ],
              ),
            );
          } else if (state is ProfileLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProfileErrorState) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                    'Ой...  Неудалось загрузить.\n Попробуйте еще раз...',
                    style: TextStyle(fontSize: 30)),
                AtbElevatedButton(
                    onPressed: () {
                      ProfileBloc().add(ProfileLoadEvent());
                    },
                    text: "Загрузить")
              ],
            ));
          } else {
            return ErrorWidget(Exception("BadState"));
          }
        },
      ),
    );
  }
}

class _UserTitle extends StatelessWidget {
  const _UserTitle({required this.avatar, required this.userName});
  final CachedNetworkImage avatar;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            // padding: const EdgeInsets.all(1),
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(55),
            //   color: Colors.black,
            // ),
            child: ClipOval(
          child: Container(
            child: avatar,
            width: 150,
            height: 150,
          ),
        )
            //(avatar == null)
            //     ? ClipOval(
            //         child: Image.network(
            //           avatar,
            //           alignment: Alignment.center,
            //           width: 150,
            //           height: 150,
            //           fit: BoxFit.cover,
            //         ),
            //       )
            //     : const CircleAvatar(
            //         radius: 55, // Image radius
            //         backgroundImage: AssetImage('assets/avatar.jpg'),
            //       ),
            ),
        const SizedBox(height: 25),
        Text(
          userName,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ],
    );
  }
}

class _UserInfo extends StatelessWidget {
  const _UserInfo({required this.email, required this.number});
  final String email;
  final String number;

  final TextStyle _titleStyle =
      const TextStyle(color: Colors.grey, fontSize: 15);
  final TextStyle _dataStyle =
      const TextStyle(color: Colors.black, fontSize: 17);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      width: double.infinity,
      child: Column(children: [
        _RowForInfo("E-MAIL", "email", _titleStyle, _dataStyle, email),
        const SizedBox(height: 15),
        _RowForInfo("ТЕЛЕФОН", "number", _titleStyle, _dataStyle, number),
      ]),
    );
  }
}

Row _RowForInfo(String title, String dataType, TextStyle titleStyle,
    TextStyle dataStyle, String element) {
  return Row(
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleStyle,
          ),
          if (dataType == "email") ...[Text(element, style: dataStyle)],
          if (dataType == 'number') ...[Text(element, style: dataStyle)]
        ],
      )
    ],
  );
}

class _UserBubbleButton extends StatelessWidget {
  const _UserBubbleButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: const [
          _UserBubbleBtn(
              title: "Обратная связь",
              subTitle: "Пожаловаться или оставить отзыв"),
        ],
      ),
    );
  }
}

class _UserBubbleBtn extends StatelessWidget {
  const _UserBubbleBtn({required this.title, required this.subTitle});

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 10,
        left: 25,
      ),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              title,
              style: const TextStyle(color: Colors.black, fontSize: 17),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              subTitle,
              style: const TextStyle(color: Colors.grey, fontSize: 15),
            )
          ]),
          const Icon(Icons.keyboard_arrow_right_sharp)
        ],
      ),
    );
  }
}
