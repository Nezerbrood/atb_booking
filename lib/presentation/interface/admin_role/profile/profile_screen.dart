import 'package:atb_booking/data/services/image_provider.dart';
import 'package:atb_booking/data/services/network/network_controller.dart';
import 'package:atb_booking/logic/admin_role/profile/admin_profile_bloc.dart';
import 'package:atb_booking/presentation/constants/styles.dart';
import 'package:atb_booking/presentation/interface/auth/auth_screen.dart';
import 'package:atb_booking/presentation/widgets/elevated_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
                  AdminProfileBloc().add(AdminProfileExitToAuthEvent());
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

class AdminProfileScreen extends StatelessWidget {
  const AdminProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => const Auth()));
              },
              icon: const Icon(Icons.logout, size: 28))
        ],
        title: Text(
          "Администратор",
          style: appThemeData.textTheme.displayLarge?.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: appThemeData.colorScheme.onSurface),
        ),
      ),
      body: BlocConsumer<AdminProfileBloc, AdminProfileState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is AdminProfileLoadedState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 35),
                  _UserTitle(
                    avatar: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: AppImageProvider.getImageUrlFromImageId(
                          state.userPerson.avatarImageId,
                        ),
                        httpHeaders: NetworkController().getAuthHeader(),
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                                child: CircularProgressIndicator(
                                    value: downloadProgress.progress)),
                        errorWidget: (context, url, error) => Container()),
                    userName: state.userPerson.fullName,
                  ),
                  const SizedBox(height: 55),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 238, 238, 238),
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    child: Column(
                      children: [
                        _UserInfo(
                          jobTitle: state.userPerson.jobTitle,
                          email: state.userPerson.email,
                          number: state.userPerson.phone,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 65),
                ],
              ),
            );
          } else if (state is AdminProfileLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AdminProfileErrorState) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                    'Ой...  Неудалось загрузить.\n Попробуйте еще раз...',
                    style: TextStyle(fontSize: 30)),
                AtbElevatedButton(
                    onPressed: () {
                      AdminProfileBloc().add(AdminProfileLoadEvent());
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
            child: ClipOval(
          child: Container(
            child: avatar,
            width: 150,
            height: 150,
          ),
        )),
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
  const _UserInfo(
      {required this.jobTitle, required this.email, required this.number});
  final String jobTitle;
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
        _RowForInfo("ДОЛЖНОСТЬ", "jobTitle", _titleStyle, _dataStyle, jobTitle),
        const SizedBox(height: 15),
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
          if (dataType == 'number') ...[Text(element, style: dataStyle)],
          if (dataType == 'jobTitle') ...[Text(element, style: dataStyle)]
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
