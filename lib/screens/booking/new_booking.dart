import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const List<String> list = <String>['1 Этаж', '2 Этаж', '3 Этаж', '4 Этаж'];

class NewBooking extends StatefulWidget {
  const NewBooking({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NewBookingState();
  }
}

int? startindex;
int? endindex;

class _NewBookingState extends State<NewBooking> {
  // double itemWidth = 80.0;
  // int itemCount = 100;
  // int selected = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Бронирование"),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 248, 240, 240),
                              borderRadius:
                                  BorderRadius.circular(10).copyWith(),
                            ),
                            child: TextField(
                                obscureText: true,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Выберите город...',
                                ))),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 248, 240, 240),
                              borderRadius:
                                  BorderRadius.circular(10).copyWith(),
                            ),
                            child: TextField(
                                obscureText: true,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Выберите офис...',
                                ))),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                          child: const DropdownButtonExample()),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(children: [
                    Flexible(
                        child: Image(image: AssetImage("assets/map.png"))),
                  ]),
                ),
                SizedBox(
                  width: 0,
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 248, 240, 240),
                              borderRadius:
                              BorderRadius.circular(10).copyWith(),
                            ),
                            child: TestPickerWidget()),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 0,
                  height: 20,
                ),
              ],
            ),
          ),
        ));
  }
}

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 232, 76, 83),
          borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        width: 120,
        height: 60,
        child: Center(
          child: DropdownButton<String>(
            iconDisabledColor: Colors.white,
            iconEnabledColor: Colors.white,
            dropdownColor: Colors.red,
            icon: const Icon(Icons.arrow_downward),
            value: dropdownValue,
            elevation: 16,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.white),
            onChanged: (String? value) {
              setState(() {
                dropdownValue = value!;
              });
            },
            items: list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Center(
                    child: Text(value,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: Colors.white))),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class TestPickerWidget extends StatefulWidget {
  const TestPickerWidget({super.key});

  @override
  _TestPickerWidgetState createState() => _TestPickerWidgetState();
}

class _TestPickerWidgetState extends State<TestPickerWidget> {
  late DateTime _selectedDate;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Выберите дату',
        ),
        focusNode: AlwaysDisabledFocusNode(),
        controller: _textEditingController,
        onTap: () async {
    DateTime? newDate = await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).primaryColor,
              // header background color
              onPrimary: Colors.white,
              // header text color
              onSurface:
                  Theme.of(context).primaryColor, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.red, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
      context: context,
      initialDate: DateTime(1222),
      firstDate: DateTime(1200),
      lastDate: DateTime(2100),
    );
        },
      );
  }

  _selectDate(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2040),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: const ColorScheme.dark(
                primary: Colors.deepPurple,
                onPrimary: Colors.white,
                surface: Colors.blueGrey,
                onSurface: Colors.yellow,
              ),
              dialogBackgroundColor: Colors.blue[500],
            ),
            child: child!,
          );
        });

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      _textEditingController
        ..text = DateFormat.yMMMd().format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _textEditingController.text.length,
            affinity: TextAffinity.upstream));
    }
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
