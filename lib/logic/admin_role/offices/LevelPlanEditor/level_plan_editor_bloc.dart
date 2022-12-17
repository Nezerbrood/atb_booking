import 'dart:async';
import 'dart:convert';

import 'package:atb_booking/data/models/workspace.dart';
import 'package:atb_booking/data/models/workspace_type.dart';
import 'package:atb_booking/data/services/level_plan_provider.dart';
import 'package:atb_booking/data/services/office_provider.dart';
import 'package:atb_booking/data/services/workspace_provider.dart';
import 'package:atb_booking/data/services/workspace_type_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'level_plan_editor_event.dart';

part 'level_plan_editor_state.dart';

const _HEIGHT = 1000.0;
const _WIDTH = 1000.0;

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
  final Map<int, LevelPlanElementData> _mapOfPlanElements = {};
  static final Map<int, _Size> _mapLastSize = {
    1: _Size(width: 100, height: 100),
    2: _Size(width: 200, height: 200),
  };
  int levelNumber = 0;
  int? _selectedElementId;
  final int _levelId;


  Timer? _debounce;
  _onChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), () {
      print("_onChanged() add event send server changes");
      add(LevelPlanEditorSendChangesToServerEvent());
    });
  }


  LevelPlanEditorBloc(this._levelId) : super(LevelPlanEditorInitial()) {
    on<LevelPlanEditorEvent>((event, emit) {
      // TODO: implement event handler
    });

    ///
    ///
    /// Двигаем элемент по плану
    on<LevelPlanEditorElementMoveEvent>((event, emit) async {
      _setElementToNewPosition(_mapOfPlanElements[event.id]!,
          event.newPositionX, event.newPositionY);
      _onChanged();
      emit(LevelPlanEditorMainState(
          mapOfPlanElements: _mapOfPlanElements,
          selectedElementId: _selectedElementId,
          levelNumber: levelNumber));
    });

    ///
    ///
    /// меняем активный эелмент isSelect
    on<LevelPlanEditorElementTapEvent>((event, emit) {
      _changeSelectedElement(event.id);
      emit(LevelPlanEditorMainState(
          mapOfPlanElements: _mapOfPlanElements,
          selectedElementId: _selectedElementId,
          levelNumber: levelNumber));
    });

    ///
    ///
    ///Добавляем по тапу новый воркплейс на план
    on<LevelPlanEditorCreateElementEvent>((event, emit) async {
      try {
        var element = _createNewElement(
            event.type, WorkspaceTypeRepository().getMapOfTypes(), _levelId);
        int idOfCreatedWorkspace = await WorkspaceProvider()
            .createWorkspaceByLevelPlanEditorElementData(element);
        element.id = idOfCreatedWorkspace;
        _mapOfPlanElements[idOfCreatedWorkspace] = element;

        _changeSelectedElement(idOfCreatedWorkspace);
        emit(LevelPlanEditorMainState(
            mapOfPlanElements: _mapOfPlanElements,
            selectedElementId: _selectedElementId,
            levelNumber: levelNumber));
      } catch (_) {
        //todo add logic
      }
    });

    ///
    ///
    /// Изменяем размер
    on<LevelPlanEditorElementChangeSizeEvent>((event, emit) async {
      _changeSizeElement(
          _mapOfPlanElements[event.id]!, event.newWidth, event.newHeight);
      await _onChanged();
      emit(LevelPlanEditorMainState(
          mapOfPlanElements: _mapOfPlanElements,
          selectedElementId: _selectedElementId,
          levelNumber: levelNumber));
    });

    ///
    ///
    /// Удаляем место
    on<LevelPlanEditorDeleteWorkspaceButtonPressEvent>((event, emit) async {
      try {
        int id = _selectedElementId!;
        await WorkspaceProvider().deleteById(id);
        _deleteElement(id);
        _selectedElementId = null;
        emit(LevelPlanEditorMainState(
            mapOfPlanElements: _mapOfPlanElements,
            selectedElementId: _selectedElementId,
            levelNumber: levelNumber));
      } catch (_) {
        print(_);
      }
    });

    ///
    ///
    ///Изменяем номер этажа
    on<LevelPlanEditorChangeLevelFieldEvent>((event, emit) {
      levelNumber = event.newLevel;
      emit(LevelPlanEditorMainState(
          mapOfPlanElements: _mapOfPlanElements,
          selectedElementId: _selectedElementId,
          levelNumber: levelNumber));
    });

    ///
    ///
    /// Изменяем описание воркспейса
    on<LevelPlanEditorChangeDescriptionFieldEvent>((event, emit) {
      _changeDescriptionOfElement(_selectedElementId!, event.form);
      emit(LevelPlanEditorMainState(
          mapOfPlanElements: _mapOfPlanElements,
          selectedElementId: _selectedElementId,
          levelNumber: levelNumber));
    });

    ///
    ///
    /// Изменяем статус (активно или нет) воркспейса
    on<LevelPlanEditorChangeActiveStatusEvent>((event, emit) {
      _switchActiveStatus(_selectedElementId!);
      emit(LevelPlanEditorMainState(
          mapOfPlanElements: _mapOfPlanElements,
          selectedElementId: _selectedElementId,
          levelNumber: levelNumber));
    });

    ///
    ///
    /// Изменяем количество мест воркспейса
    on<LevelPlanEditorChangeNumberOfWorkplacesFieldEvent>((event, emit) {
      _changeCountOfWorkplaces(_selectedElementId!, event.countOfWorkplaces);
      emit(LevelPlanEditorMainState(
          mapOfPlanElements: _mapOfPlanElements,
          selectedElementId: _selectedElementId,
          levelNumber: levelNumber));
    });

    ///
    ///
    /// Принудительно обновляет состояние
    on<LevelPlanEditorForceUpdateEvent>((event, emit) {
      emit(LevelPlanEditorMainState(
          mapOfPlanElements: _mapOfPlanElements,
          selectedElementId: _selectedElementId,
          levelNumber: levelNumber));
    });

    ///
    ///
    /// Загружаем этаж с сервера
    on<LevelPlanEditorLoadWorkspacesFromServerEvent>((event, emit) async {
      try {
        //emit(LevelPlanEditorLoadingState());
        var levelPlan = await LevelPlanProvider().getPlanByLevelId(_levelId);
        _mapOfPlanElements.clear();
        for(var elem in levelPlan.workspaces){
          _mapOfPlanElements[elem.id!]= elem;
        }
        if(_selectedElementId!=null){
        print("old width:${_mapOfPlanElements[_selectedElementId]!.width}");
        print("old heidht:${_mapOfPlanElements[_selectedElementId]!.height}");}
        emit(LevelPlanEditorMainState(
            mapOfPlanElements: _mapOfPlanElements,
            selectedElementId: _selectedElementId,
            levelNumber: levelNumber));
      } catch (_) {}
    });

    ///
    ///
    /// Загружаем воркплейсы на сервер
    on<LevelPlanEditorSendChangesToServerEvent>((event,emit)async{
      try{if(_selectedElementId!=null){
        print("old width:${_mapOfPlanElements[_selectedElementId]!.width}");
        print("old heidht:${_mapOfPlanElements[_selectedElementId]!.height}");}
        List<LevelPlanElementData> listOfChangedWorkspaces = _mapOfPlanElements.entries.map((e) => e.value).toList();
        await WorkspaceProvider().sendWorkspacesChangesByLevelId(listOfChangedWorkspaces);
        add(LevelPlanEditorLoadWorkspacesFromServerEvent());
      }catch(_){
        print(_);
        print("ids:[");
        for(var elem in _mapOfPlanElements.entries){
          print(elem.value.id);
        }
        print("]");
        add(LevelPlanEditorLoadWorkspacesFromServerEvent());
      }
    });
    add(LevelPlanEditorLoadWorkspacesFromServerEvent());
  }

  /// функция размещает елемент на плане,
  /// проверяя не вышел ли он за рамки,
  /// если вышел то изменяет координаты до корректных
  void _setElementToNewPosition(LevelPlanElementData planElement,
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
  LevelPlanElementData _createNewElement(
      WorkspaceType type, mapOfTypes, int levelId) {
    int id = _IdGenerator.getId();
    if (type.id == 1) {
      return LevelPlanElementData(
          positionX: 50,
          positionY: 50,
          width: _getLastSize(type.id).width,
          height: _getLastSize(type.id).height,
          numberOfWorkspaces: 1,
          type: type,
          description: 'description type 1',
          isActive: true,
          levelId: _levelId);
    } else if (type.id == 2) {
      return LevelPlanElementData(
          positionX: 50,
          positionY: 50,
          width: _getLastSize(type.id).width,
          height: _getLastSize(type.id).height,
          numberOfWorkspaces: 20,
          type: type,
          description: 'description type 2',
          isActive: true,
          levelId: _levelId);
    } else {
      throw Exception("BAD TYPE ID: ${type.type}");
    }
  }

  void _changeSizeElement(LevelPlanElementData levelPlanEditorElementData,
      double newWidth, double newHeight) {
    ///todo добавить проверки на границы
    if (newWidth < 60) {
      newWidth = 60;
    }
    if (newHeight < 60) {
      newHeight = 60;
    }
    levelPlanEditorElementData.width = newWidth;
    levelPlanEditorElementData.height = newHeight;
    _mapLastSize[levelPlanEditorElementData.type.id] =
        _Size(width: newWidth, height: newHeight);
  }

  ///метод удаляет место
  void _deleteElement(int? selectedElementId) {
    _mapOfPlanElements.remove(selectedElementId);
  }

  _Size _getLastSize(int id) {
    _Size lastSize = _mapLastSize[id]!;
    return lastSize;
  }

  void _changeDescriptionOfElement(
      int selectedElementId, String newDescription) {
    _mapOfPlanElements[selectedElementId]!.description = newDescription;
  }

  /// меняем статус для места
  void _switchActiveStatus(int selectedElementId) {
    _mapOfPlanElements[selectedElementId]!.isActive =
        !(_mapOfPlanElements[selectedElementId]!.isActive);
  }

  /// меняем количество мест в воркспейсе
  void _changeCountOfWorkplaces(int selectedElementId, int count) {
    _mapOfPlanElements[selectedElementId]!.numberOfWorkspaces = count;
  }
}

class _Size {
  final double width;
  final double height;

  _Size({required this.width, required this.height});
}
