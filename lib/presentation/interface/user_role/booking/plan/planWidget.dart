
import 'package:atb_booking/logic/user_role/booking/new_booking/new_booking_bloc/plan_bloc/plan_bloc.dart';
import 'package:atb_booking/presentation/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'plan_element.dart';
class PlanWidget extends StatelessWidget {
  static final TransformationController _transformationController = TransformationController();

  const PlanWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlanBloc, PlanState>(
      builder: (context, state) {
        if (state is PlanLoadedState ) {
          return Column(
            children: [
              InteractiveViewer(

                transformationController: _transformationController,
                maxScale: 2.0,
                minScale: 0.1,
                child: SizedBox(
                  //color: Colors.white70,
                  width: state.width,
                  height: state.height,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: state.planBackgroundImage != null
                            ? Image.network(state.planBackgroundImage!).image
                            : Image.asset("assets/map.jpg").image,
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Stack(
                      //fit: StackFit.expand,
                      children: PlanElementWidget.getListOfPlanElementWidget(state.workspaces,
                          state.selectedWorkspace, state.workspaceTypes),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  state.title,
                  textAlign: TextAlign.center,
                  style: appThemeData.textTheme.headlineSmall,
                ),
              ),

            ],
          );
        }
        if (state is PlanWorkplaceSelectedState) {
          return Column(
            children: [
              InteractiveViewer(
                transformationController: _transformationController,
                maxScale: 2.0,
                minScale: 0.1,
                child: SizedBox(
                  //color: Colors.white70,
                  width: state.width,
                  height: state.height,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: state.planBackgroundImage != null
                            ? Image.network(state.planBackgroundImage!).image
                            : Image.asset("assets/map.jpg").image,
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Stack(
                      //fit: StackFit.expand,
                      children: PlanElementWidget.getListOfPlanElementWidget(state.workspaces,
                          state.selectedWorkspace, state.workspaceTypes),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  state.title,
                  textAlign: TextAlign.center,
                  style: appThemeData.textTheme.headlineSmall,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 10),
                child: Container(
                    decoration: BoxDecoration(
                      color: appThemeData.colorScheme.tertiary,
                      borderRadius: BorderRadius.circular(10).copyWith(),
                    ),
                    child: _DatePickerWidget(
                      onChanged: (DateTime dateTime) {
                      },
                    )),
              )
            ],
          );
        }

        if (state is PlanHidedState) {
          return Container();
        }
        if (state is PlanLoadingState) {
          return Container();
        } else {
          return ErrorWidget(Exception("errorState if plan"));
        }
      },
      listener: (context, state) {
        // TODO: implement listener
      },
    );
  }
}

class _DatePickerWidget extends StatefulWidget {
  const _DatePickerWidget({required this.onChanged});

  final void Function(DateTime dateTime) onChanged;

  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<_DatePickerWidget> {
  DateTime? _selectedDate;
  static String _defaultText = "Выберите дату";
  final TextEditingController _textEditingController = TextEditingController();
@override
  void initState() {
    super.initState();
    _selectedDate = PlanBloc().state.selectedDate;
  }
  @override
  Widget build(
    BuildContext context,
  ) {
    if (_selectedDate != null) {
      _defaultText = "Выберите дату";
      _textEditingController.text =
          (DateFormat.yMMMMd("ru_RU").format(_selectedDate!)).toString();
    }
    return TextField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: _defaultText,
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
          initialDate: DateTime.now().add(const Duration(days: 1)),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(Duration(days: PlanBloc().maxBookingRangeInDays!)),
        );
        if (newDate != null) {
          _textEditingController.text =
              (DateFormat('dd.MM.yyyy').format(newDate)).toString();
          setState(() {
            _selectedDate = newDate;
          });
          PlanBloc().add(PlanSelectDateEvent(newDate));
          widget.onChanged(newDate);
          print("----------------");
          print("NEW VALUE DATA-PICKER IS: ${newDate.toUtc().toString()}");
          print("----------------");

        }
      },
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
