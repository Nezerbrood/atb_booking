part of 'locked_plan_bloc.dart';

@immutable
abstract class LockedPlanState {

  const LockedPlanState();
}
class LockedPlanInitState extends LockedPlanState{
}
class LockedPlanLoadingState extends LockedPlanState {
}
class LockedPlanLoadedState extends LockedPlanState {
  final double height;
  final double width;
  final List<WorkspaceOnPlan> workspaces;
  final int selectedWorkspaceId;
  final Map<int,WorkspaceType> workspaceTypes;
  final String? planBackgroundImage;
  LockedPlanLoadedState(this.workspaces,this.workspaceTypes, this.height, this.width, this.selectedWorkspaceId,  this.planBackgroundImage,);
}
class PlanWorkplaceSelectedState extends LockedPlanState {
  final String title;
  final double height;
  final double width;
  //final Image background;
  final List<WorkspaceOnPlan> workspaces;
  final WorkspaceOnPlan? selectedWorkspace;
  final Map<int,WorkspaceType> workspaceTypes;
  final String? planBackgroundImage;
  PlanWorkplaceSelectedState(DateTime selectedDate, this.workspaces,this.workspaceTypes, this.height, this.width, this.selectedWorkspace, this.title, this.planBackgroundImage);
}
class LockedPlanErrorState extends LockedPlanState {
  LockedPlanErrorState();
}
