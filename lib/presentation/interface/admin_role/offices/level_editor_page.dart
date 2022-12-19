import 'dart:convert';
import 'dart:io';

import 'package:atb_booking/data/models/workspace.dart';
import 'package:atb_booking/data/models/workspace_type.dart';
import 'package:atb_booking/data/services/image_provider.dart';
import 'package:atb_booking/data/services/network/network_controller.dart';
import 'package:atb_booking/data/services/workspace_type_repository.dart';
import 'package:atb_booking/logic/admin_role/offices/LevelPlanEditor/level_plan_editor_bloc.dart';
import 'package:atb_booking/logic/admin_role/offices/office_page/admin_office_page_bloc.dart';
import 'package:atb_booking/presentation/constants/styles.dart';
import 'package:atb_booking/presentation/widgets/elevated_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

//double SCALE_FACTOR = 0.5;

class LevelEditorPage extends StatelessWidget {
  const LevelEditorPage({Key? key}) : super(key: key);
  static double SCALE_FACTOR = 1.0; //MediaQuery.of(context).size.height * 0.75,
  @override
  Widget build(BuildContext pageContext) {
    SCALE_FACTOR = MediaQuery.of(pageContext).size.width / 1000.0;
    return WillPopScope(
      onWillPop: () async {
        pageContext.read<AdminOfficePageBloc>().add(OfficePageReloadEvent());
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Этаж"), //todo add level to string
          actions: [
            TextButton(
                onPressed: () async {
                  bool? wasDelete = await showDialog<bool>(
                      context: pageContext,
                      builder: (context) {
                        return const _DeleteLevelConfirmationPopup();
                      });
                  print("was delete:$wasDelete");
                  if (wasDelete != null && wasDelete) {
                    pageContext
                        .read<LevelPlanEditorBloc>()
                        .add(LevelPlanEditorDeleteLevelEvent());
                    try {
                      Navigator.of(pageContext).pop();
                    } catch (_) {}
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "удалить этаж",
                    style: Theme.of(pageContext)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(
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
              return SingleChildScrollView(
                child: Column(
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
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
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
        print("____________");
        var elements = <Widget>[];

        ///
        ///
        if (state.levelPlanImageId != null) {
          print("plan image id: ${state.levelPlanImageId}");
          var backgroundImage = Center(
            child: Container(
              width: double.infinity,
              //height:  double.infinity,
              child: CachedNetworkImage(
                  fit: BoxFit.fitHeight,
                  imageUrl: AppImageProvider.getImageUrlFromImageId(
                      state.levelPlanImageId!),
                  httpHeaders: NetworkController().getAuthHeader(),
                  progressIndicatorBuilder:
                      (context, url, downloadProgress) => Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress)),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error)),
            ),
          );
          elements.add(backgroundImage);
        }

        ///
        ///
        _LevelPlanEditorElementWidget? selectedElem;
        for (int i = 0; i < state.listOfPlanElements.length; i++) {
          bool isSelect = i == state.selectedElementIndex;
          if (isSelect) {
            selectedElem = _LevelPlanEditorElementWidget(
                data: state.listOfPlanElements[i],
                isSelect: isSelect,
                scaleInteractiveViewValue:
                    _transformationController.value.getMaxScaleOnAxis());
          } else {
            elements.add(_LevelPlanEditorElementWidget(
                data: state.listOfPlanElements[i],
                isSelect: isSelect,
                scaleInteractiveViewValue:
                    _transformationController.value.getMaxScaleOnAxis()));
          }
        }
        if (selectedElem != null) elements.add(selectedElem);

        ///кидаем наверх плана выбранный
        print("____________");
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
  final LevelPlanElementData data;
  final bool isSelect;
  final double scaleInteractiveViewValue;
  static const BLUE_PRINT_FRAME_WIDTH = 6.0;
  const _LevelPlanEditorElementWidget(
      {required this.data,
      required this.isSelect,
      required this.scaleInteractiveViewValue});

  @override
  Widget build(BuildContext context) {
    var cornerSize =
        35 * LevelEditorPage.SCALE_FACTOR / scaleInteractiveViewValue;
    return Positioned(
      left: data.positionX * LevelEditorPage.SCALE_FACTOR - cornerSize,
      top: data.positionY * LevelEditorPage.SCALE_FACTOR - cornerSize,
      child: SizedBox(
        //color: AtbAdditionalColors.debugTranslucent,
        height: data.height * LevelEditorPage.SCALE_FACTOR + (cornerSize * 2),
        width: data.width * LevelEditorPage.SCALE_FACTOR + (cornerSize * 2),
        child: GestureDetector(
          onPanUpdate: (details) {
            if (isSelect) {
              context.read<LevelPlanEditorBloc>().add(
                  LevelPlanEditorElementMoveEvent(
                      data.id!,
                      data.positionY +
                          (details.delta.dy / LevelEditorPage.SCALE_FACTOR),
                      data.positionX +
                          (details.delta.dx / LevelEditorPage.SCALE_FACTOR)));
            }
          },
          onTap: () {
            if(isSelect){
            context
                .read<LevelPlanEditorBloc>()
                .add(LevelPlanEditorDeselectElementEvent());}else{
              context
                  .read<LevelPlanEditorBloc>()
                  .add(LevelPlanEditorSelectElementEvent(data.id!));
            }
            
          },
          child: Stack(children: [
            Positioned(
              left: cornerSize,
              top: cornerSize,
              child: Container(
                width: data.width * LevelEditorPage.SCALE_FACTOR,
                height: data.height * LevelEditorPage.SCALE_FACTOR,
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                      side: !isSelect
                          ? const BorderSide(width: 0, color: Colors.grey)
                          : BorderSide(
                              width: 6 * LevelEditorPage.SCALE_FACTOR,
                              color: appThemeData.primaryColor),
                      borderRadius: BorderRadius.circular(
                          8 * LevelEditorPage.SCALE_FACTOR)),
                  shadowColor: Colors.black,
                  elevation: isSelect ? 8 : 3,
                  color: !data.isActive
                      ? Colors.black12
                      : isSelect
                          ? const Color.fromARGB(255, 255, 231, 226)
                          : const Color.fromARGB(255, 234, 255, 226),
                  child: SizedBox(
                    // width: data.width * LevelEditorPage.SCALE_FACTOR,
                    // height: data.height * LevelEditorPage.SCALE_FACTOR,
                    child: Padding(
                      padding: EdgeInsets.all(6 * LevelEditorPage.SCALE_FACTOR),
                      child: Container(child: data.type.cachedNetworkImage),
                    ),
                  ),
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
                                data.id!,
                                data.positionY +
                                    (details.delta.dy /
                                        LevelEditorPage.SCALE_FACTOR),
                                data.positionX +
                                    (details.delta.dx /
                                        LevelEditorPage.SCALE_FACTOR)));
                        context
                            .read<LevelPlanEditorBloc>()
                            .add(LevelPlanEditorElementChangeSizeEvent(
                              data.id!,
                              data.width +
                                  -(details.delta.dx /
                                      LevelEditorPage.SCALE_FACTOR),
                              data.height +
                                  -(details.delta.dy /
                                      LevelEditorPage.SCALE_FACTOR),
                            ));
                      },
                      child: Container(
                        width: cornerSize,
                        height: cornerSize,
                        //color: AtbAdditionalColors.debugTranslucent,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                BLUE_PRINT_FRAME_WIDTH *
                                    LevelEditorPage.SCALE_FACTOR),
                            border: Border.all(
                                color: AtbAdditionalColors
                                    .planBorderElementTranslucent,
                                width: BLUE_PRINT_FRAME_WIDTH *
                                    LevelEditorPage.SCALE_FACTOR),
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
                                data.id!,
                                data.positionY +
                                    (details.delta.dy /
                                        LevelEditorPage.SCALE_FACTOR),
                                data.positionX));
                        context
                            .read<LevelPlanEditorBloc>()
                            .add(LevelPlanEditorElementChangeSizeEvent(
                              data.id!,
                              data.width +
                                  (details.delta.dx /
                                      LevelEditorPage.SCALE_FACTOR),
                              data.height +
                                  -(details.delta.dy /
                                      LevelEditorPage.SCALE_FACTOR),
                            ));
                      },
                      child: SizedBox(
                        width: cornerSize,
                        height: cornerSize,
                        //color: AtbAdditionalColors.debugTranslucent,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                BLUE_PRINT_FRAME_WIDTH *
                                    LevelEditorPage.SCALE_FACTOR),
                            border: Border.all(
                                color: AtbAdditionalColors
                                    .planBorderElementTranslucent,
                                width: BLUE_PRINT_FRAME_WIDTH *
                                    LevelEditorPage.SCALE_FACTOR),
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
                                data.id!,
                                data.positionY,
                                data.positionX +
                                    (details.delta.dx /
                                        LevelEditorPage.SCALE_FACTOR)));
                        context
                            .read<LevelPlanEditorBloc>()
                            .add(LevelPlanEditorElementChangeSizeEvent(
                              data.id!,
                              data.width +
                                  -(details.delta.dx /
                                      LevelEditorPage.SCALE_FACTOR),
                              data.height +
                                  (details.delta.dy /
                                      LevelEditorPage.SCALE_FACTOR),
                            ));
                      },
                      child: SizedBox(
                        width: cornerSize,
                        height: cornerSize,
                        //color: AtbAdditionalColors.debugTranslucent,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                BLUE_PRINT_FRAME_WIDTH *
                                    LevelEditorPage.SCALE_FACTOR),
                            border: Border.all(
                                color: AtbAdditionalColors
                                    .planBorderElementTranslucent,
                                width: BLUE_PRINT_FRAME_WIDTH *
                                    LevelEditorPage.SCALE_FACTOR),
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
                              data.id!,
                              data.width +
                                  (details.delta.dx /
                                      LevelEditorPage.SCALE_FACTOR),
                              data.height +
                                  (details.delta.dy /
                                      LevelEditorPage.SCALE_FACTOR),
                            ));
                      },
                      child: SizedBox(
                        width: cornerSize,
                        height: cornerSize,
                        //color: AtbAdditionalColors.debugTranslucent,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                BLUE_PRINT_FRAME_WIDTH *
                                    LevelEditorPage.SCALE_FACTOR),
                            border: Border.all(
                                color: AtbAdditionalColors
                                    .planBorderElementTranslucent,
                                width: BLUE_PRINT_FRAME_WIDTH *
                                    LevelEditorPage.SCALE_FACTOR),
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
                                data.id!,
                                data.positionY,
                                data.positionX +
                                    (details.delta.dx /
                                        LevelEditorPage.SCALE_FACTOR)));
                        context
                            .read<LevelPlanEditorBloc>()
                            .add(LevelPlanEditorElementChangeSizeEvent(
                              data.id!,
                              data.width +
                                  -(details.delta.dx /
                                      LevelEditorPage.SCALE_FACTOR),
                              data.height,
                            ));
                      },
                      child: Container(
                        //color: AtbAdditionalColors.debugTranslucent,
                        color: Colors.transparent,
                        width: cornerSize,
                        height: ((data.height) * LevelEditorPage.SCALE_FACTOR),
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: BLUE_PRINT_FRAME_WIDTH *
                                LevelEditorPage.SCALE_FACTOR,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: AtbAdditionalColors
                                  .planBorderElementTranslucent,
                              borderRadius: BorderRadius.circular(
                                  BLUE_PRINT_FRAME_WIDTH *
                                      LevelEditorPage.SCALE_FACTOR),
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
                                data.id!, data.positionY, data.positionX));
                        context
                            .read<LevelPlanEditorBloc>()
                            .add(LevelPlanEditorElementChangeSizeEvent(
                              data.id!,
                              data.width +
                                  (details.delta.dx /
                                      LevelEditorPage.SCALE_FACTOR),
                              data.height,
                            ));
                      },
                      child: Container(
                        width: cornerSize,
                        height: ((data.height) * LevelEditorPage.SCALE_FACTOR),
                        //color: AtbAdditionalColors.debugTranslucent,
                        color: Colors.transparent,
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: BLUE_PRINT_FRAME_WIDTH *
                                LevelEditorPage.SCALE_FACTOR,
                            height: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    BLUE_PRINT_FRAME_WIDTH *
                                        LevelEditorPage.SCALE_FACTOR),
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
                                data.id!,
                                data.positionY +
                                    (details.delta.dy /
                                        LevelEditorPage.SCALE_FACTOR),
                                data.positionX));
                        context
                            .read<LevelPlanEditorBloc>()
                            .add(LevelPlanEditorElementChangeSizeEvent(
                              data.id!,
                              data.width,
                              data.height -
                                  (details.delta.dy /
                                      LevelEditorPage.SCALE_FACTOR),
                            ));
                      },
                      child: Container(
                        width: ((data.width) * LevelEditorPage.SCALE_FACTOR),
                        height: cornerSize,
                        //color: AtbAdditionalColors.debugTranslucent
                        color: Colors.transparent,
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: BLUE_PRINT_FRAME_WIDTH *
                                LevelEditorPage.SCALE_FACTOR,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AtbAdditionalColors
                                  .planBorderElementTranslucent,
                              borderRadius: BorderRadius.circular(
                                  BLUE_PRINT_FRAME_WIDTH *
                                      LevelEditorPage.SCALE_FACTOR),
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
                              data.id!,
                              data.width,
                              data.height +
                                  (details.delta.dy /
                                      LevelEditorPage.SCALE_FACTOR),
                            ));
                      },
                      child: Container(
                        width: ((data.width) * LevelEditorPage.SCALE_FACTOR),
                        height: cornerSize,
                        //color: AtbAdditionalColors.debugTranslucent
                        color: Colors.transparent,
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: BLUE_PRINT_FRAME_WIDTH *
                                LevelEditorPage.SCALE_FACTOR,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AtbAdditionalColors
                                  .planBorderElementTranslucent,
                              borderRadius: BorderRadius.circular(
                                  BLUE_PRINT_FRAME_WIDTH *
                                      LevelEditorPage.SCALE_FACTOR),
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
                      width: 120,
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
          if (state.selectedElementIndex != null) {
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
                          child: const _DeleteWorkspaceConfirmationPopup(),
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
            if (state.selectedElementIndex != null) {
              return MaterialButton(
                shape: RoundedRectangleBorder(
                    side:
                        BorderSide(width: 1, color: appThemeData.primaryColor),
                    borderRadius: BorderRadius.circular(7.0)),
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (_) {
                        return SingleChildScrollView(
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
          if (state.selectedElementIndex != null) {
            title = state.listOfPlanElements[state.selectedElementIndex!].type
                .type; // state.listOfPlanElements[state.selectedElementIndex!].type.type;
          } else {
            if (state.listOfPlanElements.isEmpty) {
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
                      //onSubmitted: ({),
                      onChanged: (form) {
                        context
                            .read<LevelPlanEditorBloc>()
                            .add(LevelPlanEditorChangeLevelFieldEvent((form)));
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
    return Container(

      height: MediaQuery.of(context).size.height * 0.78,
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<LevelPlanEditorBloc, LevelPlanEditorState>(
            builder: (context, state) {
              if (state is LevelPlanEditorMainState) {
                return Text(state
                    .listOfPlanElements[state.selectedElementIndex!].type.type);
              } else {
                return ErrorWidget(Exception("unexpected state: $state"));
              }
            },
          ),
        ),
        body:
        Scrollbar(
          thumbVisibility: true,
          child: SingleChildScrollView(
            child: Wrap(
              alignment: WrapAlignment.center,

              //mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _WorkSpacePhotos(),
                const _DescriptionWorkspaceField(),
                _NumberOfWorkspacesField(),
                const _ActiveStatusAndButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _WorkSpacePhotos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LevelPlanEditorBloc, LevelPlanEditorState>(
      builder: (context, state) {
        if (state is LevelPlanEditorMainState) {
          return Container(
            height: 200,
            child: state.selectedWorkspacePhotosIds.isNotEmpty
                ? Scrollbar(
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.selectedWorkspacePhotosIds.length,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              if (index == 0) _UploadImagePanel(),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl: AppImageProvider
                                              .getImageUrlFromImageId(state
                                                      .selectedWorkspacePhotosIds[
                                                  index]),
                                          httpHeaders: NetworkController()
                                              .getAuthHeader(),
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress)),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error)),
                                      IconButton(
                                          onPressed: () {
                                            context.read<LevelPlanEditorBloc>().add(
                                                LevelPlanEditorDeleteWorkspacePhotoEvent(
                                                    state.selectedWorkspacePhotosIds[
                                                        index]));
                                          },
                                          icon: Container(
                                              decoration: BoxDecoration(
                                                color:
                                                    appThemeData.primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                              ),
                                              child: const Icon(
                                                Icons.clear,
                                                color: Colors.white,
                                              )))
                                    ]),
                              )
                            ],
                          );
                          ;
                        }),
                  )
                : _UploadImagePanel(),
          );
        } else {
          return ErrorWidget(Exception("unexpected state: $state"));
        }
      },
    );
  }
}

class _UploadImagePanel extends StatelessWidget {
  //File? image;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: 240,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          MaterialButton(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: appThemeData.primaryColor),
                borderRadius: BorderRadius.circular(7.0)),
            onPressed: () {
              context.read<LevelPlanEditorBloc>().add(
                  LevelPlanEditorAddImageToWorkspaceButtonEvent(
                      ImageSource.gallery));
            },
            color: appThemeData.primaryColor,
            child: Container(
              width: 200,
              height: 40,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Выбрать из галереи",
                      style: appThemeData.textTheme.titleMedium!
                          .copyWith(color: Colors.white, fontSize: 15),
                    ),
                    Icon(Icons.image)
                  ],
                ),
              ),
            ),
          ),
          MaterialButton(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: appThemeData.primaryColor),
                borderRadius: BorderRadius.circular(7.0)),
            onPressed: () {
              context.read<LevelPlanEditorBloc>().add(
                  LevelPlanEditorAddImageToWorkspaceButtonEvent(
                      ImageSource.camera));
            },
            color: appThemeData.primaryColor,
            child: Container(
              width: 200,
              height: 40,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Сделать фото",
                      style: appThemeData.textTheme.titleMedium!
                          .copyWith(color: Colors.white, fontSize: 15),
                    ),
                    Icon(Icons.add_a_photo)
                  ],
                ),
              ),
            ),
          ),
        ]),
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
          var workspace = state.listOfPlanElements[state.selectedElementIndex!];
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
                        ?.copyWith(color: Colors.black, fontSize: 22),
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
          var workspace = state.listOfPlanElements[state.selectedElementIndex!];
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
            var workspace =
                state.listOfPlanElements[state.selectedElementIndex!];
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
                      if (workspace.isActive) {
                        showDialog(
                            context: context,
                            builder: (contextBuilder) {
                              return BlocProvider.value(
                                value: context.read<LevelPlanEditorBloc>(),
                                child:
                                    const _DeactivateWorkplaceConfirmationPopup(),
                              );
                            });
                      } else {
                        context
                            .read<LevelPlanEditorBloc>()
                            .add(LevelPlanEditorChangeActiveStatusEvent());
                      }
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
          onPressed: () => Navigator.pop(
            context,
            false,
          ),
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
            Navigator.pop(context, true);
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

class _DeactivateWorkplaceConfirmationPopup extends StatelessWidget {
  const _DeactivateWorkplaceConfirmationPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Деактивировать?'),
      content: Text(
        'Все созданные брони на это место будут отменены и создать новые бронирования на это место будет нельзя,\nВы уверены что хотите деактивировать рабочее место?',
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: Colors.black54, fontSize: 19, fontWeight: FontWeight.w300),
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
                fontSize: 18,
                fontWeight: FontWeight.w500),
          ),
        ),
        TextButton(
          onPressed: () {
            context
                .read<LevelPlanEditorBloc>()
                .add(LevelPlanEditorChangeActiveStatusEvent());
            Navigator.pop(context, 'OK');
          },
          child: Text(
            'Деактивировать',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.black54,
                fontSize: 18,
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
            if (state.selectedElementIndex == null) {
              return MaterialButton(
                shape: RoundedRectangleBorder(
                    side:
                        BorderSide(width: 1, color: appThemeData.primaryColor),
                    borderRadius: BorderRadius.circular(7.0)),
                onPressed: () {
                  context
                      .read<LevelPlanEditorBloc>()
                      .add(LevelPlanEditorChangeBackgroundButtonEvent());
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
