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

class LevelPlanEditorElementChangeSizeEvent extends LevelPlanEditorEvent {
  final int id;

  final double newWidth;
  final double newHeight;

  LevelPlanEditorElementChangeSizeEvent(this.id, this.newWidth, this.newHeight);
}

class LevelPlanEditorElementTapEvent extends LevelPlanEditorEvent {
  final int id;

  LevelPlanEditorElementTapEvent(
    this.id,
  );
}

class LevelPlanEditorCreateElementEvent extends LevelPlanEditorEvent {
  final WorkspaceType type;

  LevelPlanEditorCreateElementEvent(this.type);
}

class LevelPlanEditorForceUpdateEvent extends LevelPlanEditorEvent {}

class LevelPlanEditorDeleteWorkspaceButtonPressEvent
    extends LevelPlanEditorEvent {}

class LevelPlanEditorChangeLevelFieldEvent extends LevelPlanEditorEvent {
  final int newLevel;

  LevelPlanEditorChangeLevelFieldEvent(this.newLevel);
}

class LevelPlanEditorChangeDescriptionFieldEvent extends LevelPlanEditorEvent {
  final String form;

  LevelPlanEditorChangeDescriptionFieldEvent(this.form);
}

class LevelPlanEditorChangeNumberOfWorkplacesFieldEvent
    extends LevelPlanEditorEvent {
  final int countOfWorkplaces;

  LevelPlanEditorChangeNumberOfWorkplacesFieldEvent(this.countOfWorkplaces);
}

class LevelPlanEditorChangeActiveStatusEvent extends LevelPlanEditorEvent {}

class LevelPlanEditorLoadWorkspacesFromServerEvent extends LevelPlanEditorEvent{
}
class LevelPlanEditorSendChangesToServerEvent extends LevelPlanEditorEvent{

}