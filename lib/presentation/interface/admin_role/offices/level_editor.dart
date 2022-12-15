import 'package:atb_booking/data/models/workspace_type.dart';
import 'package:atb_booking/data/services/workspace_type_repository.dart';
import 'package:atb_booking/logic/admin_role/offices/LevelPlanEditor/level_plan_editor_bloc.dart';
import 'package:atb_booking/presentation/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

double SCALE_FACTOR = 4.0;

class LevelEditor extends StatelessWidget {
  const LevelEditor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => LevelPlanEditorBloc(),
        child: Column(
          children: const [
            _HorizontalWorkspaceBar(),
            _LevelPlanEditor(),
          ],
        ));
  }
}

class _LevelPlanEditorElementWidget extends StatelessWidget {
  final int id;
  final LevelPlanEditorElementData data;
  final bool isSelected;

  const _LevelPlanEditorElementWidget(
      {
      required this.data,
      required this.id,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: data.positionX * SCALE_FACTOR,
      top: data.positionY * SCALE_FACTOR,
      child: GestureDetector(
        onPanUpdate: (details) {
          print("dx:${details.delta.dx}");
          print("dy:${details.delta.dy}");
          if (isSelected) {
            context.read<LevelPlanEditorBloc>().add(
                LevelPlanEditorElementMoveEvent(
                    id,
                    data.positionY + (details.delta.dy / SCALE_FACTOR),
                    data.positionX + (details.delta.dx / SCALE_FACTOR)));
          }
        },
        onTap: () {
          context
              .read<LevelPlanEditorBloc>()
              .add(LevelPlanEditorElementTapEvent(id));
        },
        child: SizedBox(
          width: data.width * SCALE_FACTOR,
          height: data.width * SCALE_FACTOR,
          child: Container(
            color: isSelected ? Colors.red : Colors.green,
          ),
        ),
      ),
    );
  }
}

///
///
///Горизонтальный список с виджетами для размещения на плане.
class _HorizontalWorkspaceBar extends StatelessWidget {
  const _HorizontalWorkspaceBar({Key? key}) : super(key: key);
  static List<WorkspaceType> types = WorkspaceTypeRepository()
      .getMapOfTypes()
      .entries
      .map((e) => e.value)
      .toList();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: types.length,
          itemBuilder: (context, index) {
            return Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      types[index].type,
                      style: appThemeData.textTheme.titleSmall,
                      textAlign: TextAlign.right,
                    ),
                    width: 26 * SCALE_FACTOR,
                  ),
                  Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                        side:
                        BorderSide(
                            width: 0.2, color: Colors.black),

                        borderRadius: BorderRadius.circular(12.0)),
                    shadowColor: Color.fromARGB(255, 255, 223, 186),
                    elevation: 3,
                    color
                        : Color.fromARGB(255, 255, 255, 255),
                    child: Container(
                      width: 15*SCALE_FACTOR,
                      height: 15*SCALE_FACTOR,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(child: types[index].cachedNetworkImage),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}

class _LevelPlanEditor extends StatelessWidget {
  const _LevelPlanEditor({Key? key}) : super(key: key);
  static final TransformationController _transformationController =
      TransformationController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LevelPlanEditorBloc, LevelPlanEditorState>(
        builder: (context, state) {
      if (state is LevelPlanEditorBaseState) {
        var elements = state.mapOfPlanElements.entries
            .map((e) => _LevelPlanEditorElementWidget(
                  id: e.key,
                  data: e.value,
                  isSelected: state.selectedElementId == e.key,
                ))
            .toList();
        return InteractiveViewer(
          minScale: 0.3,
          maxScale: 4,
          transformationController: _transformationController,
          child: Container(
              color: Colors.grey,
              width: 100.0 * SCALE_FACTOR,
              height: 100.0 * SCALE_FACTOR,
              child: Stack(
                children: elements,
              )),
        );
      } else if (state is LevelPlanEditorInitial) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        throw Exception('State: $state');
      }
    });
  }
}
