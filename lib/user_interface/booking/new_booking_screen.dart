import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../constants/styles.dart';

const List<String> list = <String>['1 Этаж', '2 Этаж', '3 Этаж', '4 Этаж'];
class NewBookingScreen extends StatefulWidget {
  const NewBookingScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _NewBookingScreenState();
  }
}

int? startIndex;
int? endIndex;

class _NewBookingScreenState extends State<NewBookingScreen> {
  // double itemWidth = 80.0;
  // int itemCount = 100;
  // int selected = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Бронирование"),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                            decoration: BoxDecoration(
                              color: appThemeData.colorScheme.secondary,
                              borderRadius:
                                  BorderRadius.circular(10).copyWith(),
                            ),
                            child: const TextField(
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                            decoration: BoxDecoration(
                              color: appThemeData.colorScheme.secondary,
                              borderRadius:
                                  BorderRadius.circular(10).copyWith(),
                            ),
                            child: const TextField(
                                obscureText: true,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Выберите офис...',
                                ))),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(flex: 1, child: DropdownButtonLevel()),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(children: const [
                    Flexible(child: Image(image: AssetImage("assets/map.png"))),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Container(
                            decoration: BoxDecoration(
                              color: appThemeData.colorScheme.secondary,
                              borderRadius:
                                  BorderRadius.circular(10).copyWith(),
                            ),
                            child: const _DatePickerWidget()),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: ElevatedButton(
                    child: SizedBox(
                        width: 240,
                        height: 60,
                        child: Center(
                            child: Text(
                          "Выбрать время",
                          style: appThemeData.textTheme.displayLarge
                              ?.copyWith(color: Colors.white, fontSize: 20),
                        ))),
                    onPressed: () => {
                      showModalBottomSheet<void>(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                          top: Radius.circular(10),
                        )),
                        context: context,
                        builder: (BuildContext context) {
                          return const MyBottomSheet();
                        },
                      )
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class MyBottomSheet extends StatefulWidget {
  const MyBottomSheet({super.key});

  @override
  State<StatefulWidget> createState() {
    return MyBottomSheetState();
  }
}

class MyBottomSheetState extends State<MyBottomSheet> {
  SfRangeValues _values =
      SfRangeValues(DateTime(2022, 10, 31, 15), DateTime(2022, 10, 31, 20));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Image.asset("assets/workplace.png",
                alignment: Alignment.center,
                height: 200,
                width: 200,
                fit: BoxFit.fill),
            const Expanded(
                flex: 1, child: Center(child: Text("Описание места")))
          ],
        ),
        SizedBox(
          width: 600,
          child: Center(
            child: SfRangeSlider(
                values: _values,
                // min: 0.0,
                // max: 100.0,
                min: DateTime(2022, 10, 31, 15),
                max: DateTime(2022, 10, 31, 20),
                showLabels: true,
                interval: 1,
                dateIntervalType: DateIntervalType.hours,
                showTicks: true,
                dateFormat: DateFormat.Hm(),
                enableTooltip: true,
                onChanged: (dynamic newValues) {
                  setState(() {
                    _values = newValues;
                  });
                }),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: ElevatedButton(
            child: SizedBox(
                width: 240,
                height: 60,
                child: Center(
                    child: Text(
                  "Забронировать",
                  style: appThemeData.textTheme.displayLarge
                      ?.copyWith(color: Colors.white, fontSize: 20),
                ))),
            onPressed: () => {Navigator.of(context).pop()},
          ),
        ),
      ],
    );
  }
}

class DropdownButtonLevel extends StatefulWidget {
  const DropdownButtonLevel({super.key});

  @override
  State<DropdownButtonLevel> createState() => _DropdownButtonLevelState();
}

class _DropdownButtonLevelState extends State<DropdownButtonLevel> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: appThemeData.primaryColor,
          borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        width: 120,
        height: 60,
        child: Center(
          child: DropdownButton<String>(
            iconDisabledColor: Colors.white,
            iconEnabledColor: Colors.white,
            dropdownColor: appThemeData.primaryColor,
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

class _DatePickerWidget extends StatefulWidget {
  const _DatePickerWidget();
  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<_DatePickerWidget> {
  late DateTime _selectedDate;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Выберите дату",
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
                  onSurface: Theme.of(context).primaryColor, // body text color
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
        initialDate: _selectedDate ?? DateTime.now(),
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
