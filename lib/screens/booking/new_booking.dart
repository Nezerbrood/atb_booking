import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:flutter/material.dart';

const List<String> list = <String>['1 Этаж', '2 Этаж', '3 Этаж', '4 Этаж'];

class NewBooking extends StatefulWidget {
  const NewBooking({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NewBookingState();
  }
}

// var timeCards = <TimeCard>[
//   TimeCard(0,DateTime.now()),
//   TimeCard(1,DateTime.now()),
//   TimeCard(2,DateTime.now()),
//   TimeCard(3,DateTime.now()),
// ];
int? startindex;
int? endindex;

class _NewBookingState extends State<NewBooking> {
  double itemWidth = 80.0;
  int itemCount = 100;
  int selected = 50;

  @override
  Widget build(BuildContext context) {
    void changeSelectedTime(int index) {
      if (startindex == null || endindex == null) {
        startindex = index;
        endindex = index;
      } else if (startindex == endindex && index != startindex) {
        endindex = index;
      } else if (index == startindex) {
        startindex = null;
        endindex = null;
      } else if (index == endindex) {
        endindex = startindex;
      } else if (index > startindex! && index < endindex!) {
        endindex = index;
      } else if (index > endindex!) {
        startindex = endindex;
        endindex = index;
      }
      print("changeSelectedTime: index:$index\n" +
          "@Start index: $startindex\n" +
          "@End index: $endindex\n");
      setState(() {});
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("text"),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 00),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 200,
                          height: 55,
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
                        const DropdownButtonExample(),
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
                  Center(
                      child: Text("Выберите время",
                          style: Theme.of(context).textTheme.headlineSmall)),
                  Center(
                      child: SizedBox(
                          width: 600,
                          height: 55,
                          child: Center(
                            child: ListView.builder(
                              itemCount: 14,
                              scrollDirection: Axis.horizontal,
                              //children: timeCards,
                              itemBuilder: (BuildContext context, int index) {
                                if (index == 13) {
                                  return SizedBox(width: 180);
                                } else {
                                  return GestureDetector(
                                      onTap: () {
                                        changeSelectedTime(index);
                                      },
                                      child:
                                          new TimeCard(index, DateTime.now()));
                                }
                              },
                            ),
                          ))),
                  Center(
                      child: Center(
                    child: TextButton(
                        style: TextButton.styleFrom(
                            foregroundColor: Color.fromARGB(255, 239, 89, 90),
                            disabledForegroundColor:
                                Colors.red.withOpacity(0.38)),
                        child: Text("Выберите дату"),
                        onPressed: () async {
                          DateTime? newDate = await showDatePicker(
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: ColorScheme.light(
                                    primary: Theme.of(context).primaryColor,
                                    // header background color
                                    onPrimary: Colors.white,
                                    // header text color
                                    onSurface: Theme.of(context)
                                        .primaryColor, // body text color
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
                        }),
                  ))
                ],
              ),
            ),
          ),
        ));
  }
}

class TimeCard extends StatelessWidget {
  DateTime time;
  int index;

  TimeCard(this.index, this.time, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 0.3, vertical: 0.3),
      color: getColor(),
      shape: RoundedRectangleBorder(
          side: const BorderSide(
              width: 0.1, color: Color.fromARGB(255, 200, 194, 207)),
          borderRadius: BorderRadius.circular(0.0)),
      child: Center(
        child: SizedBox(
            width: 80,
            height: 60,
            child: Center(
              child: Text(
                "20:00",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            )),
      ),
    );
  }

  Color getColor() {
    if (startindex == null) {
      return Color.fromARGB(255, 238, 255, 235);
    }
    if (startindex != null && endindex != null) {
      if (index <= endindex! && startindex! <= index) {
        return Colors.yellow;
      } else {
        return Color.fromARGB(255, 238, 255, 235);
      }
    }
    return Colors.red;
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
