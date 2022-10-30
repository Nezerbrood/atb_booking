import 'package:flutter/material.dart';

class Auth extends StatefulWidget {
  const Auth({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _Auth();
}

class _Auth extends State<Auth> {
  bool? isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 30, right: 50, left: 50),
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          const SizedBox(height: 35),
          Image.asset("assets/atb_logo.png"),
          const SizedBox(height: 75),
          const Text(
            "Авторизация",
            style: TextStyle(
                fontSize: 45,
                color: Color.fromRGBO(66, 66, 66, 1),
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 70),
          const TextField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Логин',
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          const TextField(
            obscureText: true,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Пароль',
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                value: isChecked,
                onChanged: ((newbool) {
                  setState(() {
                    isChecked = newbool;
                  });
                }),
                activeColor: Colors.orangeAccent,
              ),
              const Text(
                "Запомнить логин и пароль?",
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(
            height: 100,
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 255, 145, 0)),
              minimumSize: MaterialStateProperty.all(const Size(330, 50)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
            ),
            onPressed: () {},
            child: const Text(
              'Войти',
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
