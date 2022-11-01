import 'package:flutter/material.dart';

class Auth extends StatefulWidget {
  const Auth({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _Auth();
}

class _Auth extends State<Auth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
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
            const _FormWidget(),
          ],
        ),
      ),
    );
  }
}

class _FormWidget extends StatefulWidget {
  const _FormWidget();

  @override
  State<_FormWidget> createState() => __FormWidgetState();
}

class __FormWidgetState extends State<_FormWidget> {
  bool? _isChecked = false;
  String? _errorText = null;
  final _loginTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  void _auth() {
    final login = _loginTextController.text;
    final password = _passwordTextController.text;

    if (login == 'admin' && password == 'admin') {
      _errorText = null;

      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      _errorText = "Не верный логин или пароль";
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final errorText = _errorText;
    return Column(
      children: [
        TextField(
          controller: _loginTextController,
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Логин',
          ),
        ),
        const SizedBox(height: 40),
        TextField(
          obscureText: true,
          controller: _passwordTextController,
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Пароль',
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: 10),
          Text(
            errorText,
            style: const TextStyle(color: Colors.red, fontSize: 17),
          ),
          const SizedBox(height: 5)
        ],
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Checkbox(
              value: _isChecked,
              onChanged: ((newbool) {
                setState(() {
                  _isChecked = newbool;
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
        const SizedBox(height: 100),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                const Color.fromARGB(255, 255, 145, 0)),
            minimumSize: MaterialStateProperty.all(const Size(330, 50)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
          ),
          onPressed: _auth,
          child: const Text(
            'Войти',
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
