part of 'locked_plan_bloc.dart';

@immutable
abstract class LockedPlanEvent {}
class LockedPlanLoadEvent extends LockedPlanEvent{
  final int levelId;
  final int workspaceId;
  LockedPlanLoadEvent(this.levelId,this.workspaceId);
}