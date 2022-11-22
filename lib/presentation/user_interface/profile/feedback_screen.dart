import 'package:atb_booking/user_interface/widgets/elevated_button.dart';
import 'package:flutter/material.dart';

import '../../widgets/elevated_button.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  void _pressButton() {
    Navigator.of(context).pop();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "Подать жалобу",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 65, left: 30, right: 30),
        color: Colors.white,
        child: Column(
          children: [
            const _TypeWidget(),
            const SizedBox(height: 90),
            const _MessageField(),
            const SizedBox(height: 45),
            //AtbElevatedButton(onPressed: _pressButton, text: "Отправить")
          ],
        ),
      ),
    );
  }
}

class _TypeWidget extends StatefulWidget {
  const _TypeWidget();

  @override
  State<_TypeWidget> createState() => _TypeWidgetState();
}

class _TypeWidgetState extends State<_TypeWidget> {
  _TypeWidgetState() {
    _selectedValue = _reportType[0];
  }

  final List<String> _reportType = ['Жалоба', 'Отзыв'];
  String? _selectedValue = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Тип обращения",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              border: Border.all()),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              value: _selectedValue,
              items: _reportType
                  .map((type) => DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      ))
                  .toList(),
              onChanged: (val) {
                _selectedValue = val;
                setState(() {});
              },
              dropdownColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class _MessageField extends StatelessWidget {
  const _MessageField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Сообщение",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        TextField(
          keyboardType: TextInputType.multiline,
          minLines: 7,
          maxLines: 7,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  color: Colors.black45,
                )),
            border: const OutlineInputBorder(),
            hintText: "Введите текст ...",
          ),
        ),
      ],
    );
  }
}
