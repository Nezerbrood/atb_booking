import 'package:atb_booking/data/services/workspace_type_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../data/models/level_plan.dart';
import '../../../../data/models/workspace.dart';
import '../../../../data/models/workspace_type.dart';
import '../../../../data/services/level_plan_repository.dart';

part 'plan_event.dart';

part 'plan_state.dart';

class PlanBloc extends Bloc<PlanEvent, PlanState> {
  static const double WIDTH = 350;
  static const double HEIGHT = 350;
  static const String _defaultTitle = "Выберите место для бронирования";
  LevelPlan? levelPlan;
  Map<int, WorkspaceType>? workspaceTypes;
  WorkspaceOnPlan? selectedWorkspace;
  DateTime selectedDate = DateTime.now().add(Duration(days: 1));
  final LevelPlanRepository levelPlanRepository;
  final WorkspaceTypeRepository workspaceTypeRepository;
  PlanBloc(this.levelPlanRepository, this.workspaceTypeRepository)
      : super(PlanHidedState(DateTime.now())) {
    on<PlanTapElementEvent>((event, emit) async {
      try {
        if (selectedWorkspace == event.workspace) {
          selectedWorkspace = null;
          emit(PlanLoadedState(
            selectedDate,
            levelPlan!.workspaces,
            workspaceTypes!,
            HEIGHT,
            WIDTH,
            selectedWorkspace,
            selectedWorkspace == null ? _defaultTitle : workspaceTypes![selectedWorkspace!.typeId]!.type,
            levelPlan!.plan,
          ));
        } else {
          selectedWorkspace = event.workspace;
          emit(PlanWorkplaceSelectedState(
            selectedDate,
            levelPlan!.workspaces,
            workspaceTypes!,
            HEIGHT,
            WIDTH,
            selectedWorkspace,
            selectedWorkspace == null ? _defaultTitle : workspaceTypes![selectedWorkspace!.typeId]!.type,
            levelPlan!.plan,
          ));
        }
      } catch (_) {}
    });
    on<PlanLoadEvent>((event, emit) async {
      try {
        workspaceTypes = await workspaceTypeRepository.getMapOfTypes();
        levelPlan = await levelPlanRepository.getPlanByLevelId(event.levelId);
        emit(PlanLoadedState(
          selectedDate,
          levelPlan!.workspaces,
          workspaceTypes!,
          HEIGHT,
          WIDTH,
          selectedWorkspace,
          selectedWorkspace == null
              ? _defaultTitle
              : workspaceTypes![selectedWorkspace!.typeId]!.type,
          levelPlan!.plan,
        ));
      } catch (_) {
        emit(PlanErrorState(selectedDate));
      }
    });
    on<PlanHideEvent>((event, emit) async {
      try {
        emit(PlanHidedState(selectedDate));
      } catch (_) {
        emit(PlanErrorState(selectedDate));
      }
    });
    on<PlanSelectDateEvent>((event, emit) async {
      try {
        selectedDate = event.dateTime;
      } catch (_) {
        emit(PlanErrorState(selectedDate));
      }
    });

  }
}
