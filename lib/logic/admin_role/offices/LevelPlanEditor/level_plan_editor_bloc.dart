import 'package:atb_booking/data/models/workspace_type.dart';
import 'package:atb_booking/data/services/workspace_type_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'level_plan_editor_event.dart';

part 'level_plan_editor_state.dart';

const _HEIGHT = 100.0;
const _WIDTH = 100.0;

/// Все координаты относительно этих значений.class

class _IdGenerator {
  static int _lastId = 0;

  static int getId() {
    _lastId++;
    return _lastId;
  }
}

class LevelPlanEditorBloc
    extends Bloc<LevelPlanEditorEvent, LevelPlanEditorState> {
  final Map<int, LevelPlanEditorElementData> _mapOfPlanElements = {};
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

    ///
    ///
    ///Добавляем по тапу новый воркплейс на план
    on<LevelPlanEditorCreateElementEvent>((event, emit) {
      var idOfCreatedElement = _addNewElementToPlan(
          event.type, WorkspaceTypeRepository().getMapOfTypes());
      _changeSelectedElement(idOfCreatedElement);

      ///меняем выбраный элемент на созданный
      emit(LevelPlanEditorBaseState(
          mapOfPlanElements: _mapOfPlanElements,
          selectedElementId: _selectedElementId));
    });

    ///
    ///
    /// Изменяем размер
    on<LevelPlanEditorElementChangeSizeEvent>((event, emit) {
      _changeSizeElement(
          _mapOfPlanElements[event.id]!, event.newWidth, event.newHeight);
      emit(LevelPlanEditorBaseState(
          mapOfPlanElements: _mapOfPlanElements,
          selectedElementId: _selectedElementId));
    });

    ///
    ///
    /// Принудительно обновляет состояние
    on<LevelPlanEditorForceUpdateEvent>((event,emit){
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

  ///
  ///
  /// метод вовращает айди созданого элемента
  int _addNewElementToPlan(WorkspaceType type, mapOfTypes) {
    int id = _IdGenerator.getId();
    if (type.id == 1) {
      _mapOfPlanElements[id] = LevelPlanEditorElementData(
        positionX: 50,
        positionY: 50,
        minSize: 10,
        width: 10,
        height: 10,
        numberOfWorkspaces: 1,
        type: type,
        description: 'description type 1',
        isActive: true,
      );
    } else if (type.id == 2) {
      _mapOfPlanElements[id] = LevelPlanEditorElementData(
        positionX: 50,
        positionY: 50,
        minSize: 10,
        width: 20,
        height: 20,
        numberOfWorkspaces: 20,
        type: type,
        description: 'description type 2',
        isActive: true,
      );
    } else {
      throw Exception("BAD TYPE ID: ${type.type}");
    }
    return id;
  }

  void _changeSizeElement(LevelPlanEditorElementData levelPlanEditorElementData,
      double newWidth, double newHeight) {
    ///todo добавить проверки на границы
    if (newWidth<levelPlanEditorElementData.minSize){
      newWidth = levelPlanEditorElementData.minSize;
    }
    if(newHeight<levelPlanEditorElementData.minSize){
      newHeight = levelPlanEditorElementData.minSize;
    }
    levelPlanEditorElementData.width = newWidth;
    levelPlanEditorElementData.height = newHeight;

  }
}

class LevelPlanEditorElementData {
  double positionX;
  double positionY;
  double minSize;
  double width;
  double height;
  int numberOfWorkspaces;
  String description;
  bool isActive;
  WorkspaceType type;

  LevelPlanEditorElementData({
    required this.positionX,
    required this.positionY,
    required this.minSize,
    required this.width,
    required this.height,
    required this.numberOfWorkspaces,
    required this.type,
    required this.description,
    required this.isActive,
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
