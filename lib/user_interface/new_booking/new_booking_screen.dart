import 'package:atb_booking/data/services/city_repository.dart';
import 'package:atb_booking/data/services/level_plan_repository.dart';
import 'package:atb_booking/data/services/workspace_type_repository.dart';
import 'package:atb_booking/user_interface/widgets/elevated_button.dart';
import 'package:atb_booking/user_interface/widgets/plan/planWidget.dart';
import 'package:atb_booking/user_interface/widgets/plan/plan_bloc/plan_bloc.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:searchfield/searchfield.dart';
import '../../data/models/city.dart';
import '../../data/models/level_plan.dart';
import '../../data/models/office.dart';
import '../../data/models/workspace.dart';
import '../../data/services/office_repository.dart';
import '../../presentation/constants/styles.dart';
import 'new_booking_bottom_sheet.dart';

const List<String> list = <String>['1 Этаж', '2 Этаж', '3 Этаж', '4 Этаж'];
Workspace workspace =
    Workspace(1, 1, "description", true, 20, 20, 1, 1, [], 40, 40);
Office office = Office(
    id: 1,
    address: "Ул пушкина дом колотушкина",
    levels: [Level(id: 34, number: 2)],
    maxDuration: 10,
    workStart: DateTime.now(),
    workEnd: DateTime.now().add(Duration(hours: 8)));
City city = City(id: 1, name: "Владивосток");

class NewBookingScreen extends StatefulWidget {
  const NewBookingScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NewBookingScreenState();
  }
}

class _NewBookingScreenState extends State<NewBookingScreen> {
  @override
  void dispose() {
    _searchCityController.dispose();
    _searchOfficeController.dispose();
    focusCitySearch.dispose();
    super.dispose();
  }

  final _searchCityController = TextEditingController();
  final _searchOfficeController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  final focusCitySearch = FocusNode();
  final focusOfficeSearch = FocusNode();
  City _selectedCity = City.init();
  OfficeListItem _selectedOfficeListItem = OfficeListItem.init();
  Future<Office>? _selectedOffice;
  Level _selectedLevel = Level(id: -1, number: -1);
  Future<DateTime>? _selectedDate;

  bool containsCity(String text, List<City> cities) {
    final City? result = cities.firstWhere(
        (City city) => city.name.toLowerCase() == text.toLowerCase(),
        orElse: () => City.init());

    if (result!.name.isEmpty) {
      return false;
    }
    return true;
  }

  bool containsOffice(String text, List<OfficeListItem> offices) {
    final OfficeListItem? result = offices.firstWhere(
        (OfficeListItem officeListItem) =>
            officeListItem.address.toLowerCase() == text.toLowerCase(),
        orElse: () => OfficeListItem.init());
    if (result!.address.isEmpty) {
      return false;
    }
    _selectedOffice = OfficeRepository().getOfficeById(result!.id);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Бронирование"),
        ),
        body: SingleChildScrollView(
          child: BlocProvider<PlanBloc>(
            create: (context) =>
                PlanBloc(LevelPlanRepository(), WorkspaceTypeRepository())
                  ..add(PlanHideEvent()),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  /// Поле инпута города
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 10),
                    child: FutureBuilder<List<City>>(
                        future: CityRepository().getAllCities(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<City>> snapshot) {
                          if (snapshot.data != null) {
                            print(snapshot.data![0].name);
                            return Container(
                              decoration: BoxDecoration(
                                color: appThemeData.colorScheme.tertiary,
                                borderRadius:
                                    BorderRadius.circular(10).copyWith(),
                              ),
                              child: Theme(
                                data: appThemeData.copyWith(
                                    colorScheme: appThemeData.colorScheme
                                        .copyWith(
                                            surface: appThemeData
                                                .colorScheme.tertiary)),
                                child: SearchField(
                                  marginColor: Colors.white,
                                  suggestionItemDecoration: BoxDecoration(
                                      color: appThemeData.colorScheme.tertiary),
                                  searchInputDecoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    //labelText: text,
                                  ),
                                  focusNode: focusCitySearch,
                                  suggestions: snapshot.data!
                                      .map((city) =>
                                          SearchFieldListItem(city.name,
                                              child: Text(
                                                city.name.toString(),
                                                style: appThemeData
                                                    .textTheme.titleMedium!,
                                              ),
                                              item: city))
                                      .toList(),
                                  suggestionState: Suggestion.hidden,
                                  hasOverlay: true,
                                  controller: _searchCityController,
                                  hint: 'Search by city',
                                  maxSuggestionsInViewPort: 4,
                                  itemHeight: 45,
                                  validator: (x) {
                                    if (x!.isEmpty ||
                                        !containsCity(x, snapshot.data!)) {
                                      return 'Please Enter a valid City';
                                    }
                                    return null;
                                  },
                                  inputType: TextInputType.text,
                                  onSuggestionTap:
                                      (SearchFieldListItem<City> x) {
                                    setState(() {
                                      //_formKey.currentState!.validate();
                                      focusCitySearch.unfocus();
                                      _selectedCity = x.item!;
                                    });
                                  },
                                ),
                              ),
                            );
                          } else
                            return Container(
                              color: Colors.red,
                            );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ///
                        /// Инпут офиса
                        ///
                        Expanded(
                          flex: 13,
                          child: FutureBuilder<List<OfficeListItem>>(
                              future: OfficeRepository()
                                  .getOfficesByCityId(_selectedCity.id),
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<OfficeListItem>>
                                      snapshot) {
                                if (snapshot.data != null) {
                                  print(snapshot.data![0].address);
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: appThemeData.colorScheme.tertiary,
                                      borderRadius:
                                          BorderRadius.circular(10).copyWith(),
                                    ),
                                    child: Theme(
                                      data: appThemeData.copyWith(
                                          colorScheme: appThemeData.colorScheme
                                              .copyWith(
                                                  surface: appThemeData
                                                      .colorScheme.tertiary)),
                                      child: SearchField(
                                        marginColor: Colors.white,
                                        suggestionItemDecoration: BoxDecoration(
                                            color: appThemeData
                                                .colorScheme.tertiary),
                                        searchInputDecoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          //labelText: text,
                                        ),
                                        focusNode: focusOfficeSearch,
                                        suggestions: snapshot.data!
                                            .map((office) =>
                                                SearchFieldListItem(
                                                    office.address,
                                                    child: Text(
                                                      office.address.toString(),
                                                      style: appThemeData
                                                          .textTheme
                                                          .titleMedium!,
                                                    ),
                                                    item: office))
                                            .toList(),
                                        suggestionState: Suggestion.hidden,
                                        hasOverlay: true,
                                        controller: _searchOfficeController,
                                        hint: 'Search by country name',
                                        maxSuggestionsInViewPort: 4,
                                        itemHeight: 45,
                                        validator: (x) {
                                          if (x!.isEmpty ||
                                              !containsOffice(
                                                  x, snapshot.data!)) {
                                            return 'Please Enter a valid Office';
                                          }
                                          return null;
                                        },
                                        inputType: TextInputType.text,
                                        onSuggestionTap:
                                            (SearchFieldListItem<OfficeListItem>
                                                x) {
                                          setState(() {
                                            //_formKey.currentState!.validate();
                                            focusOfficeSearch.unfocus();
                                            _selectedOfficeListItem = x.item!;
                                          });
                                        },
                                      ),
                                    ),
                                  );
                                } else
                                  return Container(
                                    color: Colors.red,
                                  );
                              }),
                        ),
                        const SizedBox(width: 10),

                        ///
                        /// Инпут этажа
                        ///
                        Expanded(
                          flex: 10,
                          child: Container(
                            //height: 100,
                            decoration: BoxDecoration(
                              color: appThemeData.colorScheme.tertiary,
                              borderRadius:
                                  BorderRadius.circular(10).copyWith(),
                            ),
                            child: FutureBuilder<List<Level>>(
                                future: OfficeRepository().getLevelsByOfficeId(
                                    _selectedOfficeListItem.id),
                                builder: (BuildContext context,
                                    AsyncSnapshot<List<Level>> snapshot) {
                                  if (snapshot.data != null) {
                                    return DropdownSearch<Level>(
                                      onChanged: (level) {
                                        if (level != null) {
                                          _selectedLevel = level;
                                          context
                                              .read<PlanBloc>()
                                              .add(PlanLoadEvent(level.id));
                                        }
                                      },
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintStyle: appThemeData
                                              .textTheme.titleMedium,
                                          suffixIconColor: Colors.red,
                                          iconColor: appThemeData.primaryColor,
                                          labelText: "Этаж",
                                          hintText: "Select an Level",
                                          //filled: true,
                                        ),
                                      ),
                                      //items: List.generate(50, (i) => i),//snapshot.data!,
                                      items: snapshot.data!,
                                      itemAsString: (Level level) {
                                        return "${level.number} Этаж";
                                      },
                                      dropdownBuilder:
                                          (BuildContext context, Level? level) {
                                        if (level != null) {
                                          return Text(
                                            level.number.toString() + " Этаж",
                                            style: appThemeData
                                                .textTheme.titleMedium,
                                          );
                                        } else {
                                          return SizedBox.shrink();
                                        }
                                      },
                                      popupProps: PopupProps.menu(
                                        //showSearchBox: true,
                                        fit: FlexFit.loose,
                                        constraints: BoxConstraints.tightFor(
                                          width: 300,
                                          height: 140,
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Container();
                                  }
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: PlanWidget(),
                  ),
                  BlocConsumer<PlanBloc, PlanState>(
                    listener: (context, state) {
                      // TODO: implement listener
                    },
                    builder: (context, state) {
                      if (state is PlanWorkplaceSelectedState) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: AtbElevatedButton(
                              onPressed: () => {
                                    showModalBottomSheet<void>(
                                      builder: (BuildContext context) {
                                        return const BookingBottomSheet();
                                      },
                                      isScrollControlled: true,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(10),
                                      )),
                                      context: context,
                                    ),
                                  },
                              text: "Выбрать время"),
                        );
                      } else {
                        return Container();
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ));
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
