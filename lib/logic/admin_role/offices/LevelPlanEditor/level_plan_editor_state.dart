part of 'level_plan_editor_bloc.dart';

@immutable
abstract class LevelPlanEditorState {}

class LevelPlanEditorInitial extends LevelPlanEditorState {}

class LevelPlanEditorMainState extends LevelPlanEditorState{
  final List<LevelPlanElementData> listOfPlanElements;
  final int levelNumber;
  final int? selectedElementIndex;
  LevelPlanEditorMainState({required this.selectedElementIndex, required this.listOfPlanElements,required this.levelNumber});
}
class LevelPlanEditorLoadingState extends LevelPlanEditorState{

}