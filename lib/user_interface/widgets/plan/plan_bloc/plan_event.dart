part of 'plan_bloc.dart';

@immutable
abstract class PlanEvent {}
class PlanTapElementEvent extends PlanEvent{
  final WorkspaceOnPlan workspace;

  PlanTapElementEvent(this.workspace);
}
class PlanLoadEvent extends PlanEvent{
  final int levelId;
  PlanLoadEvent(this.levelId);
}
class PlanHideEvent extends PlanEvent{}

class PlanSelectDateEvent extends PlanEvent{
  final DateTime dateTime;
  PlanSelectDateEvent(this.dateTime);

}