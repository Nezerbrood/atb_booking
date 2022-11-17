
import 'package:atb_booking/user_interface/widgets/elevated_button.dart';
import 'package:atb_booking/user_interface/widgets/text_field.dart';
import 'package:atb_booking/user_interface/widgets/users_selectable_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../constants/styles.dart';

class BookingBottomSheet extends StatefulWidget {
  const BookingBottomSheet({super.key});

  @override
  State<StatefulWidget> createState() {
    return BookingBottomSheetState();
  }
}

class BookingBottomSheetState extends State<BookingBottomSheet> {
  int activeSliderIndex = 0;
  List<SfRangeValues> rangeValues = [
    SfRangeValues(DateTime(2022, 10, 31, 8), DateTime(2022, 10, 31, 14)),
    SfRangeValues(DateTime(2022, 10, 31, 14, 30), DateTime(2022, 10, 31, 15)),
    SfRangeValues(DateTime(2022, 10, 31, 16), DateTime(2022, 10, 31, 22)),
  ];
  List<SfRangeValues> range = [
    SfRangeValues(DateTime(2022, 10, 31, 8), DateTime(2022, 10, 31, 14)),
    SfRangeValues(DateTime(2022, 10, 31, 14, 30), DateTime(2022, 10, 31, 15)),
    SfRangeValues(DateTime(2022, 10, 31, 16), DateTime(2022, 10, 31, 22)),
  ];
  late SfRangeValues currentRange;

  @override
  void initState() {
    currentRange = rangeValues[activeSliderIndex];
    super.initState();
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.symmetric(horizontal: 0,vertical: 0),
          insetPadding: EdgeInsets.symmetric(horizontal:15,vertical: 40),
          title: AtbTextField(text: "Кого ищем?"),
          content: Container(
               width: double.maxFinite,
              child: AtbSelectableUserList()),
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            AtbElevatedButton(onPressed: (){Navigator.of(context).pop();}, text: "Добавить")
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget getSlider(int index) {
      return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            if (activeSliderIndex == index) {
              return;
            }
            setState(() {
              activeSliderIndex = index;
              currentRange = rangeValues[index];
            });
          },
          child: Container(
              constraints: const BoxConstraints(minHeight: 100, minWidth: 70),
              height: 100,
              width: ((range[index].end.hour - range[index].start.hour)
                              .toDouble() *
                          1.5.toDouble() *
                          30.toDouble())
                      .toDouble()
                      .abs() +
                  ((range[index].end.minute - range[index].start.minute)
                              .toDouble() *
                          2.toDouble().abs())
                      .abs(),
              child: SfRangeSlider(
                showTicks: true,
                showDividers: true,
                minorTicksPerInterval:
                    ((range[index].end.hour - range[index].start.hour) < 3)
                        ? 0
                        : 3,
                values: rangeValues[index],
                // min: 0.0,
                // max: 100.0,
                min: range[index].start,
                //as DateTime,
                max: range[index].end,
                //as DateTime,
                showLabels: true,
                //interval: 20,
                interval: (((range[index].end as DateTime).hour -
                            range[index].start.hour) <
                        3)
                    ? 30
                    : 2,
                stepDuration: const SliderStepDuration(minutes: 30),
                dateIntervalType:
                    ((range[index].end.hour - range[index].start.hour) < 3)
                        ? DateIntervalType.minutes
                        : DateIntervalType.hours,
                //numberFormat: NumberFormat('\$'),
                dateFormat: DateFormat.Hm(),
                enableTooltip: true,
                onChanged: activeSliderIndex == index
                    ? (SfRangeValues newValues) {
                        setState(() {
                          rangeValues[index] = newValues;
                          currentRange = newValues;
                        });
                      }
                    : null,
              )));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.min,
      children: [
        AppBar(
          title: Text(
            "Переговорная комната",
            style: appThemeData.textTheme.labelMedium?.copyWith(
                fontSize: 18, color: appThemeData.colorScheme.onSurface),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: GestureDetector(
                  onTap: () {
                    _dialogBuilder(context);
                  },
                  child: Icon(Icons.person_add_sharp)),
            )
          ],
        ),
        Row(
          children: [
            Image.asset("assets/workplace.png",
                alignment: Alignment.center,
                height: 200,
                width: 200,
                fit: BoxFit.fill),
            const Expanded(
                flex: 1,
                child: SizedBox(
                    height: 200,
                    width: 200,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                          child: Text(
                              "Давно выяснено, что при оценке дизайна и композиции читаемый текст мешает сосредоточиться. Lorem Ipsum используют потому, что тот обеспечивает более или менее стандартное заполнение шаблона, а также реальное распределение букв и пробелов в абзацах, которое не получается при простой дубликации")),
                    )))
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 00.0),
          child: SizedBox(
            width: 600,
            height: 140,
            child: SfRangeSliderTheme(
              data: SfRangeSliderThemeData(
                activeLabelStyle: appThemeData.textTheme.headlineMedium
                    ?.copyWith(
                        color: Colors.black54,
                        fontSize: 14,
                        fontStyle: FontStyle.normal),
                inactiveLabelStyle: appThemeData.textTheme.headlineMedium
                    ?.copyWith(
                        color: Colors.black54,
                        fontSize: 14,
                        fontStyle: FontStyle.normal),
                tooltipTextStyle: appThemeData.textTheme.headlineMedium
                    ?.copyWith(
                        color: Colors.white,
                        fontSize: 14,
                        fontStyle: FontStyle.normal),
                overlappingTooltipStrokeColor: Colors.white,
                tooltipBackgroundColor: appThemeData.primaryColor,
                disabledActiveTrackColor: Colors.black38,
                disabledInactiveTrackColor: Colors.black38,
                disabledActiveTickColor: Colors.black38,
                disabledInactiveTickColor: Colors.black38,
                disabledActiveMinorTickColor: Colors.black38,
                disabledInactiveMinorTickColor: Colors.black38,
                disabledActiveDividerColor: Colors.red,
                disabledInactiveDividerColor: Colors.black38,
                disabledThumbColor: Colors.black38,
                activeTrackColor: appThemeData.primaryColor,
                inactiveTrackColor: Colors.black38,
                activeTickColor: appThemeData.primaryColor,
                inactiveTickColor: Colors.black38,
                activeMinorTickColor: appThemeData.primaryColor,
                inactiveMinorTickColor: Colors.black38,
                activeDividerColor: appThemeData.primaryColor,
                inactiveDividerColor: Colors.black38,
                thumbColor: appThemeData.primaryColor,
              ),
              child: Scrollbar(
                thickness: 10,
                thumbVisibility: true,
                child: ListView.builder(
                  primary: true,
                  //physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  //shrinkWrap: true,
                  //physics: const NeverScrollableScrollPhysics(),
                  itemCount: rangeValues.length,
                  itemBuilder: (context, index) {
                    return getSlider(index);
                  },
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: appThemeData.colorScheme.tertiary,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  children: [
                    Text("Начало", style: appThemeData.textTheme.titleLarge),
                    Text(
                      DateFormat("HH:mm").format(currentRange.start),
                      style: appThemeData.textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: appThemeData.colorScheme.tertiary,
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  children: [
                    Text(
                      "Конец",
                      style: appThemeData.textTheme.titleLarge,
                    ),
                    Text(
                      DateFormat("HH:mm").format(currentRange.end),
                      style: appThemeData.textTheme.titleLarge,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(
            padding: const EdgeInsets.fromLTRB(30, 00, 30, 40),
            child: AtbElevatedButton(
                onPressed: () => {Navigator.of(context).pop()},
                text: 'Забронировать')),
      ],
    );
  }
}
