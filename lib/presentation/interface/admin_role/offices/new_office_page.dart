import 'package:atb_booking/data/models/city.dart';
import 'package:atb_booking/data/services/city_provider.dart';
import 'package:atb_booking/logic/admin_role/offices/LevelPlanEditor/level_plan_editor_bloc.dart';
import 'package:atb_booking/logic/admin_role/offices/new_office_page/new_office_page_bloc.dart';
import 'package:atb_booking/logic/admin_role/offices/office_page/admin_office_page_bloc.dart';
import 'package:atb_booking/presentation/interface/admin_role/offices/office_page.dart';
import 'package:atb_booking/presentation/widgets/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class NewOfficePage extends StatelessWidget {
  const NewOfficePage({Key? key}) : super(key: key);
  static final TextEditingController cityInputController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("crete city_controller)");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Создание офиса"),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          context
              .read<NewOfficePageBloc>()
              .add(NewOfficePageUpdateFieldsEvent());
        },
        child: BlocBuilder<NewOfficePageBloc, NewOfficePageState>(
          builder: (context, state) {
            print("newOfficePage state: $state");
            if (state is NewOfficePageLoadedState) {
              print("${state.buttonIsActive}");
              return Column(
                children: [
                  _CityField(
                    cityInputController: cityInputController,
                  ),
                  _OfficeAddress(
                    state: state,
                  ),
                  _BookingRange(state: state),
                  _WorkTimeRange(state: state),
                  if (state.buttonIsActive) const _CreateButton()
                ],
              );
            } else if (state is NewOfficePageInitialState) {
              cityInputController.clear();
              return StreamBuilder<Object>(
                  stream: null,
                  builder: (context, snapshot) {
                    return Column(
                      children: [
                        _CityField(
                          cityInputController: cityInputController,
                        ),
                      ],
                    );
                  });
            } else {
              throw Exception('invalid state: $state');
            }
          },
        ),
      ),
    );
  }
}

class _CityField extends StatelessWidget {
  ///
  ///City input fields
  /// -> -> ->
  final TextEditingController cityInputController;

  const _CityField({super.key, required this.cityInputController});

  @override
  Widget build(BuildContext context) {
    print(cityInputController.text);
    return BlocBuilder<NewOfficePageBloc, NewOfficePageState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
          child: TypeAheadFormField(
            textFieldConfiguration: TextFieldConfiguration(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Выберите город...",
              ),
              controller: cityInputController,
            ),
            suggestionsCallback: (pattern) {
              // при нажатии на поле

              return CityProvider().getCitiesByName(
                  pattern); // //CityRepository().getAllCities();
            },

            itemBuilder: (context, City suggestion) {
              return ListTile(
                title: Text(suggestion.name),
              );
            },
            transitionBuilder: (context, suggestionsBox, controller) {
              // при вводи чего то в форму
              return suggestionsBox;
            },
            onSuggestionSelected: (City suggestion) {
              cityInputController.text = suggestion.name;
              context
                  .read<NewOfficePageBloc>()
                  .add(NewOfficePageCitySelectedEvent(suggestion));
              //todo _selectedCity = suggestion;
            },
            validator: (value) =>
                value!.isEmpty ? 'Please select a city' : null,
            //onSaved: (value) => this._selectedCity = value,
          ),
        );
      },
    );
  }
}

class _OfficeAddress extends StatelessWidget {
  static TextEditingController? _officeAddressController;
  final NewOfficePageLoadedState state;

  _OfficeAddress({super.key, required this.state}) {
    if (_officeAddressController == null) {
      _officeAddressController = TextEditingController(text: state.address);
    } else {
      if (state.address != _officeAddressController!.text) {
        _officeAddressController = TextEditingController(text: state.address);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print(state.address);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Text("Адрес",
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.black54,
                    fontSize: 24,
                    fontWeight: FontWeight.w300)),
          ),
          Container(
            height: 0.3,
            color: Colors.black54,
          ),
          SizedBox(
            width: double.infinity,
            child: TextField(
              decoration: const InputDecoration(hintText: 'Введите адресс'),
              keyboardType: TextInputType.streetAddress,
              onTap: () {
                context
                    .read<NewOfficePageBloc>()
                    .add(NewOfficePageUpdateFieldsEvent());
              },
              onChanged: (form) {
                context
                    .read<NewOfficePageBloc>()
                    .add(NewOfficePageAddressChangeEvent(form));
              },
              controller: _officeAddressController,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: Colors.black, fontSize: 20),
              maxLines: 2,
              minLines: 1,
              maxLength: 1000,
              //keyboardType: TextInputType.multiline,
            ),
          )
        ],
      ),
    );
  }
}

class _BookingRange extends StatelessWidget {
  static TextEditingController? _bookingRangeController;
  final NewOfficePageLoadedState state;

  _BookingRange({super.key, required this.state}) {
    if (_bookingRangeController == null) {
      _bookingRangeController =
          TextEditingController(text: state.bookingRange.toString());
    } else {
      if (state.address != _bookingRangeController!.text) {
        _bookingRangeController =
            TextEditingController(text: state.bookingRange.toString());
      }
    }
    _bookingRangeController!.selection = TextSelection(
        baseOffset: 0, extentOffset: _bookingRangeController!.text.length);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 9,
            child: Row(
              children: [
                Text("Дальность \nбронирования в днях",
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.black54,
                        fontSize: 24,
                        fontWeight: FontWeight.w300)),
                const SizedBox(
                  width: 5,
                ),
                Container(
                  height: 60,
                  width: 0.3,
                  color: Colors.black54,
                )
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: TextField(
                keyboardType: TextInputType.number,
                onTap: () {
                  context
                      .read<NewOfficePageBloc>()
                      .add(NewOfficePageUpdateFieldsEvent());
                },
                onChanged: (form) {
                  print("controller.text: ${_bookingRangeController!.text}");
                  context
                      .read<NewOfficePageBloc>()
                      .add(NewOfficeBookingRangeChangeEvent(int.parse(form)));
                },
                controller: _bookingRangeController,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: Colors.black, fontSize: 23),
                //keyboardType: TextInputType.multiline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WorkTimeRange extends StatelessWidget {
  final NewOfficePageLoadedState state;

  _WorkTimeRange({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    var values =
        SfRangeValues(state.workTimeRange.start, state.workTimeRange.end);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 10, 30, 0),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Text("Время работы офиса",
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.black54,
                        fontSize: 24,
                        fontWeight: FontWeight.w300)),
              ),
              Container(
                height: 0.3,
                color: Colors.black54,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: SfRangeSlider(
              showTicks: true,
              showDividers: true,
              minorTicksPerInterval: 2,
              values: values,
              max: DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day, 24),
              min: DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day, 0),
              showLabels: true,
              interval: 4,
              stepDuration: const SliderStepDuration(minutes: 30),
              dateIntervalType: DateIntervalType.hours,
              //numberFormat: NumberFormat('\$'),
              dateFormat: DateFormat.Hm(),
              enableTooltip: true,
              onChanged: (newValues) {
                context
                    .read<NewOfficePageBloc>()
                    .add(NewOfficePageWorkTimeRangeChangeEvent(DateTimeRange(
                      start: newValues.start,
                      end: newValues.end,
                    )));
                //values = newValues;
              }),
        ),
      ],
    );
  }
}

class _CreateButton extends StatelessWidget {
  const _CreateButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AtbElevatedButton(
      onPressed: () {
        // Navigator.of(context).popUntil((route) {
        //   return route.isFirst;
        // });
        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(builder: (context) {
        //       return Scaffold(
        //         appBar: AppBar(),
        //         body: Container(
        //           color: Colors.purple,
        //         ),
        //       );
        //     })
        // );
        showDialog(
            useRootNavigator: true,
            context: context,
            builder: (context_) {
              return BlocProvider.value(
                value: context.read<NewOfficePageBloc>(),
                child: MultiBlocProvider(providers: [
                  BlocProvider(
                    create: (_) => AdminOfficePageBloc(),
                  ),
                  BlocProvider(
                    create: (_) =>
                        LevelPlanEditorBloc(),
                  ),
                ], child: const _CreateAlertDialog()),
              );
            });
        context
            .read<NewOfficePageBloc>()
            .add(NewOfficePageButtonPressEvent(context));
      },
      text: "Создать",
    );
  }
}

class _CreateAlertDialog extends StatelessWidget {
  const _CreateAlertDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: BlocListener<NewOfficePageBloc, NewOfficePageState>(
        child: const CircularProgressIndicator(),
        listener: (_, state) {
          print("STATE: $state");
          if (state is NewOfficePageSuccessfulCreatedState)  {
            context
                .read<AdminOfficePageBloc>()
                .add(OfficePageLoadEvent(state.officeId));
            Navigator.pop(context);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context_) {
              return MultiBlocProvider(providers: [
                BlocProvider<AdminOfficePageBloc>(
                  create: (_) => AdminOfficePageBloc(),
                ),
              ], child: const OfficePage());
            }));
          }
        },
      ),
    );
  }
}
