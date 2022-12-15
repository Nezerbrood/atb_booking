

import 'package:atb_booking/data/models/workspace_type.dart';
import 'package:atb_booking/data/services/workspace_type_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'level_plan_editor_event.dart';

part 'level_plan_editor_state.dart';

const _HEIGHT = 100.0;
const _WIDTH = 100.0;

/// Все координаты относительно этих значений.

class LevelPlanEditorBloc
    extends Bloc<LevelPlanEditorEvent, LevelPlanEditorState> {
  final Map<int, LevelPlanEditorElementData> _mapOfPlanElements = {
    0: LevelPlanEditorElementData(
        positionX: 10,
        positionY: 20,
        width: 30,
        height: 30,
        workspaceData: WorkspaceData(
            0, '', true, WorkspaceTypeRepository().getMapOfTypes()[1]!)),
    1: LevelPlanEditorElementData(
        positionX: 20,
        positionY: 30,
        width: 40,
        height: 40,
        workspaceData: WorkspaceData(
            0, '', true, WorkspaceTypeRepository().getMapOfTypes()[1]!)),
    2: LevelPlanEditorElementData(
        positionX: 50,
        positionY: 60,
        width: 20,
        height: 20,
        workspaceData: WorkspaceData(
            0, '', true, WorkspaceTypeRepository().getMapOfTypes()[1]!))
  };
  int? _selectedElementId;

  LevelPlanEditorBloc() : super(LevelPlanEditorInitial()) {
    on<LevelPlanEditorEvent>((event, emit) {
      // TODO: implement event handler
    });

    ///
    ///
    /// Двигаем элемент по плану
    on<LevelPlanEditorElementMoveEvent>((event, emit) {
      _setElementToNewPosition(_mapOfPlanElements[event.id]!,
          event.newPositionX, event.newPositionY);
      emit(LevelPlanEditorBaseState(
          mapOfPlanElements: _mapOfPlanElements,
          selectedElementId: _selectedElementId));
    });

    ///
    ///
    /// меняем активный эелмент isSelect
    on<LevelPlanEditorElementTapEvent>((event, emit) {
      _changeSelectedElement(event.id);
      emit(LevelPlanEditorBaseState(
          mapOfPlanElements: _mapOfPlanElements,
          selectedElementId: _selectedElementId));
    });
    emit(LevelPlanEditorBaseState(
        mapOfPlanElements: _mapOfPlanElements,
        selectedElementId: _selectedElementId));
  }

  /// функция размещает елемент на плане,
  /// проверяя не вышел ли он за рамки,
  /// если вышел то изменяет координаты до корректных
  void _setElementToNewPosition(LevelPlanEditorElementData planElement,
      double newPositionX, double newPositionY) {
    if (newPositionX < 0.0) {
      newPositionX = 0;
    } else if (newPositionX > (_WIDTH - planElement.width)) {
      newPositionX = _WIDTH - planElement.width;
    }
    if (newPositionY < 0.0) {
      newPositionY = 0;
    } else if (newPositionY > (_HEIGHT - planElement.height)) {
      newPositionY = _HEIGHT - planElement.height;
    }
    planElement.positionX = newPositionX;
    planElement.positionY = newPositionY;
  }

  void _changeSelectedElement(int id) {
    if (_selectedElementId == null) {
      _selectedElementId = id;
    } else {
      if (_selectedElementId == id) {
        _selectedElementId = null;
      } else {
        _selectedElementId = id;
      }
    }
  }
}

class LevelPlanEditorElementData {
  double positionX;
  double positionY;
  double width;
  double height;
  WorkspaceData workspaceData;

  LevelPlanEditorElementData({
    required this.positionX,
    required this.positionY,
    required this.width,
    required this.height,
    required this.workspaceData,
  });
}

class WorkspaceData {
  //final int id;
  final int numberOfWorkspaces;
  final String description;
  final bool isActive;
  final WorkspaceType type;

  WorkspaceData(
      this.numberOfWorkspaces, this.description, this.isActive, this.type);
//final List<Photo> photos; todo найти решение для загрузки фотографий
}
