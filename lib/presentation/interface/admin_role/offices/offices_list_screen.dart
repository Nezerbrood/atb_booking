import 'package:atb_booking/data/models/city.dart';
import 'package:atb_booking/data/models/office.dart';
import 'package:atb_booking/data/services/city_provider.dart';
import 'package:atb_booking/logic/admin_role/offices/LevelPlanEditor/level_plan_editor_bloc.dart';
import 'package:atb_booking/logic/admin_role/offices/new_office_page/new_office_page_bloc.dart';
import 'package:atb_booking/logic/admin_role/offices/offices_screen/admin_offices_bloc.dart';
import 'package:atb_booking/logic/admin_role/offices/office_page/admin_office_page_bloc.dart';
import 'package:atb_booking/presentation/interface/admin_role/offices/new_office_page.dart';
import 'package:atb_booking/presentation/interface/admin_role/offices/office_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class AdminOfficesScreen extends StatelessWidget {
  const AdminOfficesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Офисы")),
      body: Column(
        children: [
          const _CityField(),
          _OfficesList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
              builder: (_) {
            return MultiBlocProvider(providers: [
              BlocProvider.value(
                value: context.read<
                    AdminOfficesBloc>(), //context.read<NewOfficePageBloc>(),
              ),
              BlocProvider<NewOfficePageBloc>(
                  create: (context) =>
                      NewOfficePageBloc() //context.read<NewOfficePageBloc>(),
                  ),
              BlocProvider(
                  create: (context) =>
                      AdminOfficePageBloc() //context.read<AdminOfficePageBloc>(),
                  ),
            ], child: const NewOfficePage());
          }));
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class _CityField extends StatelessWidget {
  ///
  ///City input fields
  /// -> -> ->
  static final TextEditingController _cityInputController =
      TextEditingController();

  const _CityField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminOfficesBloc, AdminOfficesState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
          child: TypeAheadFormField(
            textFieldConfiguration: TextFieldConfiguration(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Выберите город...",
              ),
              controller: _cityInputController,
            ),
            suggestionsCallback: (pattern) {
              // при нажатии на поле
              return CityProvider()
                  .getCitiesByName(pattern); // state.futureCityList;
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
              _cityInputController.text = suggestion.name;
              context
                  .read<AdminOfficesBloc>()
                  .add(AdminOfficesCitySelectedEvent(suggestion));
              //todo _selectedCity = suggestion;
            },
            validator: (value) =>
                value!.isEmpty ? 'Введите название города' : null,
            //onSaved: (value) => this._selectedCity = value,
          ),
        );
      },
    );
  }
}

class _OfficesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminOfficesBloc, AdminOfficesState>(
      builder: (context, state) {
        if (state is AdminOfficesLoadedState) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListView.builder(
                shrinkWrap: false,
                itemCount: state.offices.length,
                itemBuilder: (context, index) {
                  return OfficeCard(
                    officeListItem: (state).offices[index],
                  );
                },
              ),
            ),
          );
        } else if (state is AdminOfficesLoadingState) {
          return const Center(child: CircularProgressIndicator(),);
        } else if (state is AdminOfficesInitial) {
          return const Center(
            child: Text("Выберите город"),
          );
        } else {
          throw Exception("Unknown AdminOfficesBloc state: $state");
        }
      },
    );
  }
}

class OfficeCard extends StatelessWidget {
  final Office officeListItem;

  const OfficeCard({super.key, required this.officeListItem});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (_, animation, secondaryAnimation) => MultiBlocProvider(providers: [
                    BlocProvider.value(
                      value: context.read<AdminOfficesBloc>(),
                    ),
                    BlocProvider<AdminOfficePageBloc>(
                        create: (_) => AdminOfficePageBloc()
                          ..add(OfficePageLoadEvent(officeListItem.id)))
                  ], child: const OfficePage()),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    const begin = Offset(1.0, 0.0);
                    const end = Offset.zero;
                    const curve = Curves.ease;

                    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );
                  },
                )
            );

            //
            //   MaterialPageRoute(builder: (cont) {
            // return MultiBlocProvider(providers: [
            //   BlocProvider.value(
            //     value: context.read<AdminOfficesBloc>(),
            //   ),
            //   BlocProvider<AdminOfficePageBloc>(
            //       create: (_) => AdminOfficePageBloc()
            //         ..add(OfficePageLoadEvent(officeListItem.id)))
            // ], child: const OfficePage());
            //}));
          },
          child: ListTile(
      title: Text(officeListItem.address),
      subtitle: Text("ID: ${officeListItem.id}"),
    ),
        ));
  }
}
// Route _createRoute() {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) => const (),
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       const begin = Offset(0.0, 1.0);
//       const end = Offset.zero;
//       const curve = Curves.ease;
//
//       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//
//       return SlideTransition(
//         position: animation.drive(tween),
//         child: child,
//       );
//     },
//   );
// }