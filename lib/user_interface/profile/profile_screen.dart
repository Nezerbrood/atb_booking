import 'package:flutter/material.dart';
import '../../app_func/app_in.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 65, left: 10, right: 10),
      color: Colors.white,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          _UppNavRow(),
          SizedBox(height: 25),
          _UserTitle(),
          SizedBox(height: 55),
          _UserInfo(),
          SizedBox(height: 45),
          _UserBubleButtons(),
        ],
      ),
    );
  }
}

class _UserBubleButtons extends StatelessWidget {
  const _UserBubleButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: const [
          _UserBubleBtn(
              title: "Обратная связь",
              subTitle: "Пожаловаться или оставить отзыв"),
        ],
      ),
    );
  }
}

class _UserBubleBtn extends StatelessWidget {
  final String title;
  final String subTitle;

  const _UserBubleBtn({
    Key? key,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

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

class _UserInfo extends StatelessWidget {
  const _UserInfo({
    Key? key,
  }) : super(key: key);
  final TextStyle _titleStyle =
      const TextStyle(color: Colors.grey, fontSize: 15);
  final TextStyle _dataStyle =
      const TextStyle(color: Colors.black, fontSize: 17);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      width: double.infinity,
      child: Column(children: [
        _RowForInfo("E-MAIL", "bdr7800@yandex.ru", _titleStyle, _dataStyle),
        const SizedBox(
          height: 15,
        ),
        _RowForInfo("ДАТА РОЖДЕНИЯ", "12.11.2001", _titleStyle, _dataStyle),
        const SizedBox(
          height: 15,
        ),
        _RowForInfo("ПОЛ", "Мужской", _titleStyle, _dataStyle),
        const SizedBox(
          height: 15,
        ),
        _RowForInfo("ТЕЛЕФОН", "+7 (908) 453-11-23", _titleStyle, _dataStyle),
      ]),
    );
  }

  Row _RowForInfo(
      String title, String data, TextStyle titleStyle, TextStyle dataStyle) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: titleStyle,
            ),
            Text(
              data,
              style: dataStyle,
            )
          ],
        )
      ],
    );
  }
}

class _UserTitle extends StatelessWidget {
  const _UserTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _UserAvatar(),
        SizedBox(height: 25),
        _UserName(),
      ],
    );
  }
}

class _UserName extends StatelessWidget {
  const _UserName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Бровко Данила Романович",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    );
  }
}

class _UserAvatar extends StatelessWidget {
  const _UserAvatar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(55),
        color: Colors.black,
      ),
      child: const CircleAvatar(
        radius: 55, // Image radius
        backgroundImage: AssetImage('assets/avatar.jpg'),
      ),
    );
  }
}

class _UppNavRow extends StatefulWidget {
  const _UppNavRow({super.key});

  @override
  State<_UppNavRow> createState() => __UppNavRowState();
}

class __UppNavRowState extends State<_UppNavRow> {
  void _exitToAuth() {
    Navigator.of(context, rootNavigator: true).pushNamed("/auth");
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          child: const Icon(Icons.exit_to_app, size: 28),
          onTap: _exitToAuth,
        ),
      ],
    );
  }
}
