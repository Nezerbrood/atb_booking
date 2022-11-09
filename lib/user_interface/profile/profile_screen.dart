import 'package:atb_booking/user_interface/profile/feedback_screen.dart';
import 'package:flutter/material.dart';
import '../../data/dataclasses/profilePerson.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<profilePerson> fetchPerson() async {
  final response = await http.get(Uri.parse("https://dummyjson.com/users"));
  if (response.statusCode == 200) {
    List<dynamic> dataJson = json.decode(response.body)["users"];
    List<profilePerson> persons = dataJson
        .map((obj) => profilePerson(obj["firstName"], obj["lastName"],
            obj["maidenName"], obj["email"], obj["phone"]))
        .toList();
    return persons[0];
  } else {
    throw Exception('Failed to load JSON');
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void _bubleTransition() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (context) => const FeedbackScreen()),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 65, left: 10, right: 10),
      color: Colors.white,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const _UppNavRow(),
          const SizedBox(height: 25),
          const _UserTitle(),
          const SizedBox(height: 55),
          const _UserInfo(),
          const SizedBox(height: 65),
          GestureDetector(
              onTap: _bubleTransition, child: const _UserBubleButton()),
        ],
      ),
    );
  }
}

class _UserBubleButton extends StatelessWidget {
  const _UserBubleButton({
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
        _RowForInfo("E-MAIL", "email", _titleStyle, _dataStyle),
        const SizedBox(height: 15),
        _RowForInfo("ТЕЛЕФОН", "number", _titleStyle, _dataStyle),
      ]),
    );
  }

  Row _RowForInfo(String title, String dataType, TextStyle titleStyle,
      TextStyle dataStyle) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: titleStyle,
            ),
            FutureBuilder(
              future: fetchPerson(),
              builder: ((context, snapshot) {
                if (snapshot.data == null) {
                  return const CircularProgressIndicator();
                } else {
                  if (dataType == "email") {
                    return Text(snapshot.data!.email, style: dataStyle);
                  } else if (dataType == 'number') {
                    return Text(snapshot.data!.number, style: dataStyle);
                  }else{
                    return Text("not defined", style: dataStyle);
                  }
                }
              }),
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
    return FutureBuilder(
      future: fetchPerson(),
      builder: ((context, snapshot) {
        if (snapshot.data == null) {
          return const CircularProgressIndicator();
        } else {
          return Text(
            "${snapshot.data!.lastName} ${snapshot.data!.firstName} ${snapshot.data!.maidenName}",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          );
        }
      }),
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
  const _UppNavRow();

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
          onTap: _exitToAuth,
          child: const Icon(Icons.exit_to_app, size: 28),
        ),
      ],
    );
  }
}
