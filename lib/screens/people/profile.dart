import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

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
          SizedBox(height: 35),
          _UserInfo(),
          SizedBox(
            height: 35,
          ),
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
        children: [
          const _UserBubleBtn(
              title: "Пароль", subTitle: "Изменить установленный пароль"),
          const SizedBox(
            height: 18,
          ),
          const _UserBubleBtn(
              title: "Push-уведомления",
              subTitle: "Управление пуш уведомлениями"),
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

class _UppNavRow extends StatelessWidget {
  const _UppNavRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Icon(
          Icons.drive_file_rename_outline,
          size: 32,
        ),
        Icon(Icons.exit_to_app, size: 28),
      ],
    );
  }
}
