part of 'level_plan_editor_bloc.dart';

@immutable
abstract class LevelPlanEditorState {}

class LevelPlanEditorInitial extends LevelPlanEditorState {}

class LevelPlanEditorMainState extends LevelPlanEditorState{
  final Map<int,LevelPlanElementData> mapOfPlanElements;
  final int? selectedElementId;
  final int levelNumber;
  LevelPlanEditorMainState({required this.mapOfPlanElements,required this.selectedElementId,required this.levelNumber});
}
class LevelPlanEditorLoadingState extends LevelPlanEditorState{

}