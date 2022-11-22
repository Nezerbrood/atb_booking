import 'package:atb_booking/user_interface/widgets/plan/plan_bloc/plan_bloc.dart';
import 'package:atb_booking/user_interface/widgets/plan/plan_element.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../presentation/constants/styles.dart';

class PlanWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlanBloc, PlanState>(
      builder: (context, state) {
        if (state is PlanLoadedState ) {
          return Column(
            children: [
              Container(
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
                          : Image.asset("assets/map.png").image,
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Stack(
                    //fit: StackFit.expand,
                    children: PlanElement.getListOfPlanElement(state.workspaces,
                        state.selectedWorkspace, state.workspaceTypes),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Container(
                    child: Text(
                  state.title,
                  textAlign: TextAlign.center,
                  style: appThemeData.textTheme.headlineSmall,
                )),
              ),

            ],
          );
        }
        if (state is PlanWorkplaceSelectedState) {
          return Column(
            children: [
              Container(
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
                          : Image.asset("assets/map.png").image,
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Stack(
                    //fit: StackFit.expand,
                    children: PlanElement.getListOfPlanElement(state.workspaces,
                        state.selectedWorkspace, state.workspaceTypes),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Container(
                    child: Text(
                      state.title,
                      textAlign: TextAlign.center,
                      style: appThemeData.textTheme.headlineSmall,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Container(
                    decoration: BoxDecoration(
                      color: appThemeData.colorScheme.tertiary,
                      borderRadius: BorderRadius.circular(10).copyWith(),
                    ),
                    child: _DatePickerWidget(
                      onChanged: (DateTime dateTime) {
                        print("${dateTime.toString()}");
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
        } else //(state is PlanErrorState){
        {
          return Container();
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
    _selectedDate = context.read<PlanBloc>().state.selectedDate;
  }
  @override
  Widget build(
    BuildContext context,
  ) {
    if (_selectedDate != null) {
      _defaultText = "Выберите дату";
      _textEditingController.text =
          (DateFormat('dd.MM.yyyy').format(_selectedDate!)).toString();
    }
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
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
          initialDate: DateTime(1222),
          firstDate: DateTime(1200),
          lastDate: DateTime(2100),
        );
        if (newDate != null) {
          _textEditingController.text =
              (DateFormat('dd.MM.yyyy').format(newDate)).toString();
          setState(() {
            _selectedDate = newDate;
          });
          context.read<PlanBloc>().add(PlanSelectDateEvent(newDate));
          widget.onChanged(newDate);
        }
      },
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
