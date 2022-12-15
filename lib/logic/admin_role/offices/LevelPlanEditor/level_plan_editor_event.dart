part of 'level_plan_editor_bloc.dart';

@immutable
abstract class LevelPlanEditorEvent {}

class LevelPlanEditorElementMoveEvent extends LevelPlanEditorEvent {
  final int id;

  final double newPositionX;
  final double newPositionY;

  LevelPlanEditorElementMoveEvent(
      this.id, this.newPositionY, this.newPositionX);
}
class LevelPlanEditorElementTapEvent extends LevelPlanEditorEvent {
  final int id;
  LevelPlanEditorElementTapEvent(
      this.id,);
}