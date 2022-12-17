import 'package:atb_booking/data/models/workspace.dart';
import 'package:atb_booking/data/models/workspace_type.dart';
import 'package:atb_booking/data/services/workspace_type_repository.dart';
import 'package:atb_booking/logic/admin_role/offices/LevelPlanEditor/level_plan_editor_bloc.dart';
import 'package:atb_booking/presentation/constants/styles.dart';
import 'package:atb_booking/presentation/widgets/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//double SCALE_FACTOR = 0.5;

class LevelEditorPage extends StatelessWidget {
  const LevelEditorPage({Key? key}) : super(key: key);
  static double SCALE_FACTOR = 1.0;//MediaQuery.of(context).size.height * 0.75,
  @override
  Widget build(BuildContext context) {
    SCALE_FACTOR = MediaQuery.of(context).size.width / 1000.0;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Этаж"), //todo add level to string
        actions: [
          TextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const _DeleteLevelConfirmationPopup();
                    });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "удалить этаж",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      decoration: TextDecoration.underline,
                      color: Colors.red,
                      fontSize: 20),
                ),
              ))
        ],
      ),
      body: BlocBuilder<LevelPlanEditorBloc, LevelPlanEditorState>(
        builder: (context, state) {
          if (state is LevelPlanEditorMainState) {
            return Column(
              children: [
                const _HorizontalWorkspaceBar(),
                const _LevelPlanEditor(),
                const _TitleUnderPlan(),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      _DeleteWorkspaceButton(),
                      _AddInfoButton()
                    ]),
                _LevelNumberField(),
                const _UploadBackgroundImageButton()
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class _LevelPlanEditor extends StatelessWidget {
  const _LevelPlanEditor({Key? key}) : super(key: key);
  static TransformationController _transformationController =
      TransformationController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LevelPlanEditorBloc, LevelPlanEditorState>(
        builder: (context, state) {
      if (state is LevelPlanEditorMainState) {
        _transformationController =
            TransformationController(_transformationController.value);
        _transformationController.addListener(() {
          context
              .read<LevelPlanEditorBloc>()
              .add(LevelPlanEditorForceUpdateEvent());
        });
        var elements = state.mapOfPlanElements.entries
            .map((e) => _LevelPlanEditorElementWidget(
                id: e.key,
                data: e.value,
                isSelect: state.selectedElementId == e.key,
                scaleInteractiveViewValue:
                    _transformationController.value.getMaxScaleOnAxis()))
            .toList();
        return InteractiveViewer(
          minScale: 0.3,
          maxScale: 2.5,
          transformationController: _transformationController,
          child: Container(
              color: const Color.fromARGB(255, 232, 232, 232),
              width: 1000.0 * LevelEditorPage.SCALE_FACTOR,
              height: 1000.0 * LevelEditorPage.SCALE_FACTOR,
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

class _LevelPlanEditorElementWidget extends StatelessWidget {
  final int id;
  final LevelPlanElementData data;
  final bool isSelect;
  final double scaleInteractiveViewValue;

  const _LevelPlanEditorElementWidget(
      {required this.data,
      required this.id,
      required this.isSelect,
      required this.scaleInteractiveViewValue});

  @override
  Widget build(BuildContext context) {
    var cornerSize = 30 * LevelEditorPage.SCALE_FACTOR / scaleInteractiveViewValue;
    var BLUE_PRINT_FRAME_WIDTH = 6;
    return Positioned(
      left: data.positionX * LevelEditorPage.SCALE_FACTOR,
      top: data.positionY * LevelEditorPage.SCALE_FACTOR,
      child: SizedBox(
        //color: AtbAdditionalColors.debugTranslucent,
        height: data.height * LevelEditorPage.SCALE_FACTOR,
        width: data.width * LevelEditorPage.SCALE_FACTOR,
        child: GestureDetector(
          onPanUpdate: (details) {
            if (isSelect) {
              context.read<LevelPlanEditorBloc>().add(
                  LevelPlanEditorElementMoveEvent(
                      id,
                      data.positionY + (details.delta.dy / LevelEditorPage.SCALE_FACTOR),
                      data.positionX + (details.delta.dx / LevelEditorPage.SCALE_FACTOR)));
            }
          },
          onTap: () {
            context
                .read<LevelPlanEditorBloc>()
                .add(LevelPlanEditorElementTapEvent(id));
          },
          child: Stack(children: [
            Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                  side: !isSelect
                      ? BorderSide(width: 0, color: Colors.grey)
                      : BorderSide(width: 6*LevelEditorPage.SCALE_FACTOR, color: appThemeData.primaryColor),
                  borderRadius: BorderRadius.circular(8*LevelEditorPage.SCALE_FACTOR)),
              shadowColor: !data.isActive
                  ? Colors.black
                  : isSelect
                      ? const Color.fromARGB(255, 255, 126, 0)
                      : const Color.fromARGB(255, 198, 255, 170),
              elevation: isSelect ? 8 : 3,
              color: !data.isActive
                  ? Colors.black
                  : isSelect
                      ? const Color.fromARGB(255, 255, 231, 226)
                      : const Color.fromARGB(255, 234, 255, 226),
              child: SizedBox(
                width: data.width * LevelEditorPage.SCALE_FACTOR,
                height: data.height * LevelEditorPage.SCALE_FACTOR,
                child: Padding(
                  padding: EdgeInsets.all(6 * LevelEditorPage.SCALE_FACTOR),
                  child: Container(child: data.type.cachedNetworkImage),
                ),
              ),
            ),
            if (isSelect)
              Stack(children: [
                ///
                ///
                /// Левая верхняя точка
                Positioned(
                    left: 0, //data.positionX * SCALE_FACTOR,
                    top: 0, //data.positionY * SCALE_FACTOR,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        context.read<LevelPlanEditorBloc>().add(
                            LevelPlanEditorElementMoveEvent(
                                id,
                                data.positionY +
                                    (details.delta.dy / LevelEditorPage.SCALE_FACTOR),
                                data.positionX +
                                    (details.delta.dx / LevelEditorPage.SCALE_FACTOR)));
                        context
                            .read<LevelPlanEditorBloc>()
                            .add(LevelPlanEditorElementChangeSizeEvent(
                              id,
                              data.width + -(details.delta.dx / LevelEditorPage.SCALE_FACTOR),
                              data.height + -(details.delta.dy / LevelEditorPage.SCALE_FACTOR),
                            ));
                      },
                      child: SizedBox(
                        width: cornerSize,
                        height: cornerSize,
                        //color: AtbAdditionalColors.debugTranslucent,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(BLUE_PRINT_FRAME_WIDTH * LevelEditorPage.SCALE_FACTOR),
                            border: Border.all(
                                color: AtbAdditionalColors
                                    .planBorderElementTranslucent,
                                width: BLUE_PRINT_FRAME_WIDTH * LevelEditorPage.SCALE_FACTOR),
                          ),
                        ),
                      ),
                    )),

                ///
                ///
                ///Правая верхня точка
                Positioned(
                    right: 0,
                    top: 0, //data.positionY * SCALE_FACTOR,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        context.read<LevelPlanEditorBloc>().add(
                            LevelPlanEditorElementMoveEvent(
                                id,
                                data.positionY +
                                    (details.delta.dy / LevelEditorPage.SCALE_FACTOR),
                                data.positionX));
                        context
                            .read<LevelPlanEditorBloc>()
                            .add(LevelPlanEditorElementChangeSizeEvent(
                              id,
                              data.width + (details.delta.dx / LevelEditorPage.SCALE_FACTOR),
                              data.height + -(details.delta.dy / LevelEditorPage.SCALE_FACTOR),
                            ));
                      },
                      child: SizedBox(
                        width: cornerSize,
                        height: cornerSize,
                        //color: AtbAdditionalColors.debugTranslucent,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(BLUE_PRINT_FRAME_WIDTH * LevelEditorPage.SCALE_FACTOR),
                            border: Border.all(
                                color: AtbAdditionalColors
                                    .planBorderElementTranslucent,
                                width: BLUE_PRINT_FRAME_WIDTH * LevelEditorPage.SCALE_FACTOR),
                          ),
                        ),
                      ),
                    )),

                ///
                ///
                ///Левая нижняя точка
                Positioned(
                    bottom: 0,
                    left: 0, //data.positionY * SCALE_FACTOR,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        context.read<LevelPlanEditorBloc>().add(
                            LevelPlanEditorElementMoveEvent(
                                id,
                                data.positionY,
                                data.positionX +
                                    (details.delta.dx / LevelEditorPage.SCALE_FACTOR)));
                        context
                            .read<LevelPlanEditorBloc>()
                            .add(LevelPlanEditorElementChangeSizeEvent(
                              id,
                              data.width + -(details.delta.dx / LevelEditorPage.SCALE_FACTOR),
                              data.height + (details.delta.dy / LevelEditorPage.SCALE_FACTOR),
                            ));
                      },
                      child: SizedBox(
                        width: cornerSize,
                        height: cornerSize,
                        //color: AtbAdditionalColors.debugTranslucent,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(BLUE_PRINT_FRAME_WIDTH * LevelEditorPage.SCALE_FACTOR),
                            border: Border.all(
                                color: AtbAdditionalColors
                                    .planBorderElementTranslucent,
                                width: BLUE_PRINT_FRAME_WIDTH * LevelEditorPage.SCALE_FACTOR),
                          ),
                        ),
                      ),
                    )),

                ///
                ///
                ///Правая нижняя точка
                Positioned(
                    bottom: 0,
                    right: 0, //data.positionY * SCALE_FACTOR,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        context
                            .read<LevelPlanEditorBloc>()
                            .add(LevelPlanEditorElementChangeSizeEvent(
                              id,
                              data.width + (details.delta.dx / LevelEditorPage.SCALE_FACTOR),
                              data.height + (details.delta.dy / LevelEditorPage.SCALE_FACTOR),
                            ));
                      },
                      child: SizedBox(
                        width: cornerSize,
                        height: cornerSize,
                        //color: AtbAdditionalColors.debugTranslucent,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(BLUE_PRINT_FRAME_WIDTH * LevelEditorPage.SCALE_FACTOR),
                            border: Border.all(
                                color: AtbAdditionalColors
                                    .planBorderElementTranslucent,
                                width: BLUE_PRINT_FRAME_WIDTH * LevelEditorPage.SCALE_FACTOR),
                          ),
                        ),
                      ),
                    )),

                ///
                ///
                /// Левая cтенка для изменения размера
                Positioned(
                    left: 0,
                    top: 0 + cornerSize,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        context.read<LevelPlanEditorBloc>().add(
                            LevelPlanEditorElementMoveEvent(
                                id,
                                data.positionY,
                                data.positionX +
                                    (details.delta.dx / LevelEditorPage.SCALE_FACTOR)));
                        context
                            .read<LevelPlanEditorBloc>()
                            .add(LevelPlanEditorElementChangeSizeEvent(
                              id,
                              data.width + -(details.delta.dx / LevelEditorPage.SCALE_FACTOR),
                              data.height,
                            ));
                      },
                      child: Container(
                        //color: AtbAdditionalColors.debugTranslucent
                        color: Colors.transparent,
                        width: cornerSize / 2,
                        height:
                            ((data.height) * LevelEditorPage.SCALE_FACTOR) - (cornerSize * 2),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: BLUE_PRINT_FRAME_WIDTH * LevelEditorPage.SCALE_FACTOR,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: AtbAdditionalColors
                                  .planBorderElementTranslucent,
                              borderRadius:
                                  BorderRadius.circular(BLUE_PRINT_FRAME_WIDTH * LevelEditorPage.SCALE_FACTOR),
                            ),
                            //color: AtbAdditionalColors.planBorderElementTranslucent,
                            child: const SizedBox.shrink(),
                          ),
                        ),
                      ),
                    )),

                ///
                ///
                /// Правая cтенка для изменения размера
                Positioned(
                    right: 0,
                    top: 0 + cornerSize,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        context.read<LevelPlanEditorBloc>().add(
                            LevelPlanEditorElementMoveEvent(
                                id, data.positionY, data.positionX));
                        context
                            .read<LevelPlanEditorBloc>()
                            .add(LevelPlanEditorElementChangeSizeEvent(
                              id,
                              data.width + (details.delta.dx / LevelEditorPage.SCALE_FACTOR),
                              data.height,
                            ));
                      },
                      child: Container(
                        width: cornerSize,
                        height:
                            ((data.height) * LevelEditorPage.SCALE_FACTOR) - (cornerSize * 2),
                        //color: AtbAdditionalColors.debugTranslucent
                        color: Colors.transparent,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: BLUE_PRINT_FRAME_WIDTH * LevelEditorPage.SCALE_FACTOR,
                            height: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(BLUE_PRINT_FRAME_WIDTH * LevelEditorPage.SCALE_FACTOR),
                                color: AtbAdditionalColors
                                    .planBorderElementTranslucent),
                            //color: AtbAdditionalColors.planBorderElementTranslucent,
                            child: const SizedBox.shrink(),
                          ),
                        ),
                      ),
                    )),

                ///
                ///
                /// Верхняя стенка
                Positioned(
                    right: 0 + cornerSize,
                    top: 0,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        context.read<LevelPlanEditorBloc>().add(
                            LevelPlanEditorElementMoveEvent(
                                id,
                                data.positionY +
                                    (details.delta.dy / LevelEditorPage.SCALE_FACTOR),
                                data.positionX));
                        context
                            .read<LevelPlanEditorBloc>()
                            .add(LevelPlanEditorElementChangeSizeEvent(
                              id,
                              data.width,
                              data.height - (details.delta.dy / LevelEditorPage.SCALE_FACTOR),
                            ));
                      },
                      child: Container(
                        width: ((data.width) * LevelEditorPage.SCALE_FACTOR) - (cornerSize * 2),
                        height: cornerSize,
                        //color: AtbAdditionalColors.debugTranslucent
                        color: Colors.transparent,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            height: BLUE_PRINT_FRAME_WIDTH * LevelEditorPage.SCALE_FACTOR,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AtbAdditionalColors
                                  .planBorderElementTranslucent,
                              borderRadius:
                                  BorderRadius.circular(BLUE_PRINT_FRAME_WIDTH * LevelEditorPage.SCALE_FACTOR),
                            ),
                            child: const SizedBox.shrink(),
                          ),
                        ),
                      ),
                    )),

                ///
                ///
                /// нижняя стенка для изменения размеров
                Positioned(
                    bottom: 0,
                    left: cornerSize,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        context
                            .read<LevelPlanEditorBloc>()
                            .add(LevelPlanEditorElementChangeSizeEvent(
                              id,
                              data.width,
                              data.height + (details.delta.dy / LevelEditorPage.SCALE_FACTOR),
                            ));
                      },
                      child: Container(
                        width: ((data.width) * LevelEditorPage.SCALE_FACTOR) - (cornerSize * 2),
                        height: cornerSize,
                        //color: AtbAdditionalColors.debugTranslucent
                        color: Colors.transparent,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: BLUE_PRINT_FRAME_WIDTH * LevelEditorPage.SCALE_FACTOR,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AtbAdditionalColors
                                  .planBorderElementTranslucent,
                              borderRadius:
                                  BorderRadius.circular(BLUE_PRINT_FRAME_WIDTH * LevelEditorPage.SCALE_FACTOR),
                            ),
                            child: const SizedBox.shrink(),
                          ),
                        ),
                      ),
                    ))
              ])
          ]),
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
    return SizedBox(
      height: 65,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: types.length,
          itemBuilder: (context, index) {
            return Card(
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () {
                  context
                      .read<LevelPlanEditorBloc>()
                      .add(LevelPlanEditorCreateElementEvent(types[index]));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Text(
                        types[index].type,
                        style: appThemeData.textTheme.titleSmall,
                        textAlign: TextAlign.right,
                      ),
                      width:120,
                    ),
                    Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                          side:
                              const BorderSide(width: 0.2, color: Colors.black),
                          borderRadius: BorderRadius.circular(12.0)),
                      shadowColor: const Color.fromARGB(255, 255, 223, 186),
                      elevation: 3,
                      color: const Color.fromARGB(255, 255, 255, 255),
                      child: SizedBox(
                        width: 60,
                        height: 60,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child:
                              Container(child: types[index].cachedNetworkImage),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class _DeleteWorkspaceButton extends StatelessWidget {
  const _DeleteWorkspaceButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LevelPlanEditorBloc, LevelPlanEditorState>(
      builder: (context, state) {
        if (state is LevelPlanEditorMainState) {
          if (state.selectedElementId != null) {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    side:
                        BorderSide(width: 1, color: appThemeData.primaryColor),
                    borderRadius: BorderRadius.circular(7.0)),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (buildContext) {
                        return BlocProvider.value(
                          value: context.read<LevelPlanEditorBloc>(),
                          child: _DeleteWorkspaceConfirmationPopup(),
                        );
                      });
                },
                color: appThemeData.primaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "Удалить место",
                        style: appThemeData.textTheme.titleMedium!.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(Icons.delete)
                    ],
                  ),
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        } else {
          throw Exception("Unexpected state: $state");
        }
      },
    );
  }
}

class _AddInfoButton extends StatelessWidget {
  const _AddInfoButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: BlocBuilder<LevelPlanEditorBloc, LevelPlanEditorState>(
        builder: (context, state) {
          if (state is LevelPlanEditorMainState) {
            if (state.selectedElementId != null) {
              return MaterialButton(
                shape: RoundedRectangleBorder(
                    side:
                        BorderSide(width: 1, color: appThemeData.primaryColor),
                    borderRadius: BorderRadius.circular(7.0)),
                onPressed: () {
                  //todo push event and show alertdialog
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (_) {
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.75,
                          child: Center(
                            child: BlocProvider.value(
                              value: context.read<LevelPlanEditorBloc>(),
                              child: const _BottomSheet(),
                            ),
                          ),
                        );
                      });
                },
                color: appThemeData.primaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "Изменить",
                        style: appThemeData.textTheme.titleMedium!.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(Icons.featured_play_list)
                    ],
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          } else {
            throw Exception("Unexpected state: $state");
          }
        },
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LevelPlanEditorBloc, LevelPlanEditorState>(
      builder: (context, state) {
        if (state is LevelPlanEditorMainState) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: AtbElevatedButton(
              onPressed: () {},
              text: 'Сохранить изменения',
            ),
          );
        } else {
          throw Exception("unexpected state: $state");
        }
      },
    );
  }
}

class _TitleUnderPlan extends StatelessWidget {
  const _TitleUnderPlan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LevelPlanEditorBloc, LevelPlanEditorState>(
      builder: (context, state) {
        if (state is LevelPlanEditorMainState) {
          String title;
          if (state.selectedElementId != null) {
            title = state.mapOfPlanElements[state.selectedElementId]!.type.type;
          } else {
            if (state.mapOfPlanElements.length == 0) {
              title = "Добавьте место на\n карту из верхнего меню";
            } else {
              title = "Выберите место";
            }
          }
          return Container(
            child: Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.black54,
                  fontSize: 22,
                  fontWeight: FontWeight.w300),
              textAlign: TextAlign.center,
            ),
          );
        } else {
          throw Exception("unexpected state: $state");
        }
      },
    );
  }
}

class _LevelNumberField extends StatelessWidget {
  static final TextEditingController _levelNumberTextController =
      TextEditingController();

  _LevelNumberField() {
    _levelNumberTextController!.selection = TextSelection(
        baseOffset: 0, extentOffset: _levelNumberTextController!.text.length);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LevelPlanEditorBloc, LevelPlanEditorState>(
      builder: (context, state) {
        if (state is LevelPlanEditorMainState) {
          if (_levelNumberTextController.text != state.levelNumber.toString()) {
            _levelNumberTextController.text = state.levelNumber.toString();
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      Text("Номер этажа",
                          textAlign: TextAlign.right,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                  color: Colors.black54,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w300)),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        height: 60,
                        width: 0.3,
                        color: Colors.black54,
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      onTap: () {},
                      onChanged: (form) {
                        context.read<LevelPlanEditorBloc>().add(
                            LevelPlanEditorChangeLevelFieldEvent(
                                int.parse(form)));
                      },
                      controller: _levelNumberTextController,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: Colors.black, fontSize: 23),
                      //keyboardType: TextInputType.multiline,
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          throw Exception("unecpected state: $state");
        }
      },
    );
  }
}

class _BottomSheet extends StatelessWidget {
  const _BottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<LevelPlanEditorBloc, LevelPlanEditorState>(
          builder: (context, state) {
            if (state is LevelPlanEditorMainState) {
              return Text(
                  state.mapOfPlanElements[state.selectedElementId]!.type.type);
            } else {
              return ErrorWidget(Exception("unexpected state: $state"));
            }
          },
        ),
      ),
      body: Wrap(
        alignment: WrapAlignment.center,

        //mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const _DescriptionWorkspaceField(),
          _NumberOfWorkspacesField(),
          const _ActiveStatusAndButton(),
          const _SaveButton(),
        ],
      ),
    );
  }
}

class _DescriptionWorkspaceField extends StatelessWidget {
  static final TextEditingController _officeDescriptionController =
      TextEditingController();

  const _DescriptionWorkspaceField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LevelPlanEditorBloc, LevelPlanEditorState>(
      builder: (context, state) {
        if (state is LevelPlanEditorMainState) {
          var workspace = state.mapOfPlanElements[state.selectedElementId]!;
          if (_officeDescriptionController.text != workspace.description) {
            _officeDescriptionController.text = workspace.description;
          }
          ;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text("Описание",
                      textAlign: TextAlign.left,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                              color: Colors.black54,
                              fontSize: 24,
                              fontWeight: FontWeight.w300)),
                ),
                Container(
                  height: 0.3,
                  color: Colors.black54,
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextField(
                    keyboardType: TextInputType.streetAddress,
                    onTap: () {},
                    onChanged: (form) {
                      context.read<LevelPlanEditorBloc>().add(
                          LevelPlanEditorChangeDescriptionFieldEvent(form));
                    },
                    controller: _officeDescriptionController,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: Colors.black, fontSize: 23),
                    maxLines: 4,
                    minLines: 2,
                    maxLength: 1000,
                    //keyboardType: TextInputType.multiline,
                  ),
                )
              ],
            ),
          );
        } else {
          throw Exception("unexpected state: $state");
        }
      },
    );
  }
}

class _NumberOfWorkspacesField extends StatelessWidget {
  static final TextEditingController _numberOfWorkspacesController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LevelPlanEditorBloc, LevelPlanEditorState>(
      builder: (context, state) {
        if (state is LevelPlanEditorMainState) {
          var workspace = state.mapOfPlanElements[state.selectedElementId]!;
          if (_numberOfWorkspacesController.text !=
              workspace.numberOfWorkspaces.toString()) {
            _numberOfWorkspacesController.text =
                workspace.numberOfWorkspaces.toString();
          }
          if (workspace.type.id == 2) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Количество\nмест",
                            textAlign: TextAlign.right,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                    color: Colors.black54,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w300)),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          height: 60,
                          width: 0.3,
                          color: Colors.black54,
                        ),
                        const SizedBox(
                          width: 30,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        onTap: () {},
                        onChanged: (form) {
                          context.read<LevelPlanEditorBloc>().add(
                              LevelPlanEditorChangeNumberOfWorkplacesFieldEvent(
                                  int.parse(form)));
                        },
                        controller: _numberOfWorkspacesController,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(color: Colors.black, fontSize: 23),
                        //keyboardType: TextInputType.multiline,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        } else {
          throw Exception("unexpected state: $state");
        }
      },
    );
  }
}

class _ActiveStatusAndButton extends StatelessWidget {
  const _ActiveStatusAndButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: BlocBuilder<LevelPlanEditorBloc, LevelPlanEditorState>(
        builder: (context, state) {
          if (state is LevelPlanEditorMainState) {
            var workspace = state.mapOfPlanElements[state.selectedElementId]!;
            return Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(workspace.isActive ? "АКТИВНО" : "НЕ АКТИВНО",
                          textAlign: TextAlign.right,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                  color: workspace.isActive
                                      ? Colors.black54
                                      : Colors.red,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300)),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        height: 60,
                        width: 0.3,
                        color: Colors.black54,
                      ),
                      Container(
                        width: 30,
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: MaterialButton(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            width: 1, color: appThemeData.primaryColor),
                        borderRadius: BorderRadius.circular(7.0)),
                    onPressed: () {
                      context
                          .read<LevelPlanEditorBloc>()
                          .add(LevelPlanEditorChangeActiveStatusEvent());
                    },
                    color: appThemeData.primaryColor,
                    child: Text(
                      !workspace.isActive ? "Активировать" : "Деактивировать",
                      style: appThemeData.textTheme.titleMedium!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            throw Exception("Unexpected state: $state");
          }
        },
      ),
    );
  }
}

class _DeleteLevelConfirmationPopup extends StatelessWidget {
  const _DeleteLevelConfirmationPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Удалить этаж?'),
      content: Text(
        'После удаления все созданные брони на этом этаже будут отменены.\nВы уверены что хотите удалить этаж?',
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: Colors.black54, fontSize: 20, fontWeight: FontWeight.w300),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: Text(
            'Отмена',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.black54,
                fontSize: 20,
                fontWeight: FontWeight.w500),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: Text(
            'Удалить',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.black54,
                fontSize: 20,
                fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}

class _DeleteWorkspaceConfirmationPopup extends StatelessWidget {
  const _DeleteWorkspaceConfirmationPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Удалить место?'),
      content: Text(
        'После удаления все созданные брони этого места будут отменены.\nВы уверены что хотите удалить это место?',
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: Colors.black54, fontSize: 20, fontWeight: FontWeight.w300),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'Cancel');
          },
          child: Text(
            'Отмена',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.black54,
                fontSize: 20,
                fontWeight: FontWeight.w500),
          ),
        ),
        TextButton(
          onPressed: () {
            context
                .read<LevelPlanEditorBloc>()
                .add(LevelPlanEditorDeleteWorkspaceButtonPressEvent());
            Navigator.pop(context, 'OK');
          },
          child: Text(
            'Удалить',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.black54,
                fontSize: 20,
                fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}

class _UploadBackgroundImageButton extends StatelessWidget {
  const _UploadBackgroundImageButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: BlocBuilder<LevelPlanEditorBloc, LevelPlanEditorState>(
        builder: (context, state) {
          if (state is LevelPlanEditorMainState) {
            if (state.selectedElementId == null) {
              return MaterialButton(
                shape: RoundedRectangleBorder(
                    side:
                        BorderSide(width: 1, color: appThemeData.primaryColor),
                    borderRadius: BorderRadius.circular(7.0)),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (contextB) {
                        return BlocProvider.value(
                          value: context.read<LevelPlanEditorBloc>(),
                          child: _UploadImageToBackgroundPopup(),
                        );
                      });
                },
                color: appThemeData.primaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        "Изменить изображение\n"
                        "на заднем плане",
                        style: appThemeData.textTheme.titleMedium!.copyWith(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(Icons.image)
                    ],
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          } else {
            throw Exception("Unexpected state: $state");
          }
        },
      ),
    );
  }
}

class _UploadImageToBackgroundPopup extends StatelessWidget {
  const _UploadImageToBackgroundPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: 100,
        height: 100,
      ),
    );
  }
}
