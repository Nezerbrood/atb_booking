part of 'level_plan_editor_bloc.dart';

@immutable
abstract class LevelPlanEditorState {}

class LevelPlanEditorInitial extends LevelPlanEditorState {}

class LevelPlanEditorBaseState extends LevelPlanEditorState{
  final Map<int,LevelPlanEditorElementData> mapOfPlanElements;
  final int? selectedElementId;
  LevelPlanEditorBaseState({required this.mapOfPlanElements,required this.selectedElementId});
}