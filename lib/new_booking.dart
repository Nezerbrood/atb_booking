import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
const List<String> list = <String>['One', 'Two', 'Three', 'Four'];
class NewBooking extends StatefulWidget {
  const NewBooking({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NewBookingState();
  }
}

var timeCards = <TimeCard>[
  TimeCard(DateTime.now()),
  TimeCard(DateTime.now()),
  TimeCard(DateTime.now()),
  TimeCard(DateTime.now()),
];
int? startindex;
int? endindex;

class _NewBookingState extends State<NewBooking> {
  double itemWidth = 80.0;
  int itemCount = 100;
  int selected = 50;
  FixedExtentScrollController _scrollController =
      FixedExtentScrollController(initialItem: 50);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("text"),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),),
                    ),
                    DropdownButtonExample(),
                  ],
                ),
                Center(
                    child: SizedBox(
                        width: 600,
                        height: 70,
                        child: Center(
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: timeCards,
                          ),
                        ))),
              ],
            ),
          ),
        ));
  }
}

class TimeCard extends StatefulWidget {
  DateTime time;

  TimeCard(this.time, {super.key});

  @override
  State<StatefulWidget> createState() {
    return TimeCardState();
  }
}

class TimeCardState extends State<TimeCard> {
  late int index;
  bool isFree = true;
  bool isSelect = false;

  void switchSelect() {
    setState(() {
      isSelect = !isSelect;
      print(isSelect);
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        switchSelect();
      },
      child: Container(
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
          color: isSelect
              ? Color.fromARGB(255, 255, 255, 107)
              : Theme.of(context).cardColor,
          shape: RoundedRectangleBorder(
              side: const BorderSide(
                  width: 1, color: Color.fromARGB(255, 200, 194, 207)),
              borderRadius: BorderRadius.circular(8.0)),
          child: Center(
            child: SizedBox(
                width: 100,
                height: 60,
                child: Center(
                  child: Text(
                    "20:00",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                )),
          ),
        ),
      ),
    );
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
          borderRadius: BorderRadius.circular(10)
      ),
      child: DropdownButton<String>(
        value: dropdownValue,
        icon: const Icon(Icons.arrow_downward,color: Colors.white,),
        elevation: 16,
        style: const TextStyle(color: Colors.white),
        underline: Container(
          height: 2,
          color: Colors.white,
        ),
        onChanged: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            dropdownValue = value!;
          });
        },
        items: list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}