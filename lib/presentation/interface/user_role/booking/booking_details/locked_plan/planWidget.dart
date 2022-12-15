import 'package:atb_booking/logic/user_role/booking/locked_plan_bloc/locked_plan_bloc.dart';
import 'package:atb_booking/presentation/interface/user_role/booking/booking_details/locked_plan/plan_element.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LockedPlanWidget extends StatelessWidget {
  LockedPlanWidget({super.key});

  final TransformationController _transformationController =
      TransformationController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: LockedPlanBloc(), //todo replace to read context
      child: BlocConsumer<LockedPlanBloc, LockedPlanState>(
        builder: (context, state) {
          if (state is LockedPlanLoadedState) {
            return InteractiveViewer(
              // boundaryMargin: const EdgeInsets.all(double.infinity),
              // constrained: false,
              transformationController: _transformationController,
              maxScale: 2.0,
              minScale: 0.1,
              child: Container(
                width: state.width,
                height: state.height,
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
                  children: LockedPlanElement.getListOfLockedPlanElement(
                      state.workspaces,
                      state.selectedWorkspaceId,
                      state.workspaceTypes),
                ),
              ),
            );
          }
          if (state is LockedPlanLoadingState) {
            return const SizedBox(
              width: 350,
              height: 350,
              child: CircularProgressIndicator(),
            );
          } else {
            return Container();
          }
        },
        listener: (context, state) {
          // TODO: implement listener
        },
      ),
    );
  }
}
