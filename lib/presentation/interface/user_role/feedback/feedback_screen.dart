import 'package:atb_booking/data/models/city.dart';
import 'package:atb_booking/data/models/office.dart';
import 'package:atb_booking/logic/user_role/feedback_bloc/feedback_bloc.dart';
import 'package:atb_booking/presentation/widgets/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class FeedBackScreen extends StatelessWidget {
  static final TextEditingController typeInputController =
      TextEditingController();
  static final TextEditingController cityInputController =
      TextEditingController();
  static final TextEditingController officeInputController =
      TextEditingController();
  static final TextEditingController messageInputController =
      TextEditingController();
  const FeedBackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('context A: $context');
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Обратная связь",
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.only(top: 45, left: 30, right: 30),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _TypeField(),

                  /// Инпут Город и Офис
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 0, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        /// Инпут Города
                        Expanded(flex: 10, child: _CityField()),
                        const SizedBox(width: 10),

                        ///Инпут Офиса
                        Expanded(flex: 13, child: _OfficeField()),
                      ],
                    ),
                  ),
                  const SizedBox(height: 45),

                  /// Поля для сообщения
                  const _MessageField(),
                  const SizedBox(height: 45),

                  /// Кнопка отправить
                  _Button(),
                  const SizedBox(height: 10)
                ]),
          ),
        ),
      ),
    );
  }
}

class _TypeField extends StatelessWidget {
  _TypeField();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedbackBloc, FeedbackState>(
        buildWhen: (previous, current) => (current is FeedbackInputFieldsState),
        builder: (context, state) {
          print('context B: $context');
          if (state is FeedbackInputFieldsState) {
            if (state.isInitialState) {
              FeedBackScreen.typeInputController.clear();
              FeedBackScreen.cityInputController.clear();
              FeedBackScreen.officeInputController.clear();
              FeedBackScreen.messageInputController.clear();
            }
            if (state.typeFieldVisible) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TypeAheadFormField(
                  textFieldConfiguration: TextFieldConfiguration(
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: Colors.black, fontSize: 20),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Выберите тип обращения...",
                    ),
                    controller: FeedBackScreen.typeInputController,
                  ),
                  // После каждого ввода буквы в textField
                  suggestionsCallback: (pattern) {
                    return (state).futureTypeList;
                  },
                  itemBuilder: (context, String suggestion) {
                    return ListTile(
                      title: Text(suggestion),
                    );
                  },
                  transitionBuilder: (context, suggestionsBox, controller) {
                    return suggestionsBox;
                  },
                  onSuggestionSelected: (String suggestion) {
                    FeedBackScreen.cityInputController.clear();
                    FeedBackScreen.officeInputController.clear();

                    FeedBackScreen.typeInputController.text = suggestion;
                    context
                        .read<FeedbackBloc>()
                        .add(FeedbackTypeFormEvent(suggestion));
                  },
                  validator: (value) =>
                      value!.isEmpty ? 'Please select a type' : null,
                ),
              );
            } else {
              return Container();
            }
          } else {
            throw Exception("Bad state: $state");
          }
        });
  }
}

class _CityField extends StatelessWidget {
  _CityField();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeedbackBloc, FeedbackState>(
        listener: (context, state) {},
        buildWhen: (previous, current) => (current is FeedbackInputFieldsState),
        builder: (context, state) {
          if (state is FeedbackInputFieldsState) {
            if (state.cityFieldVisible) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                child: TypeAheadFormField(
                  textFieldConfiguration: TextFieldConfiguration(
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: Colors.black, fontSize: 20),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Выберите город...",
                    ),
                    controller: FeedBackScreen.cityInputController,
                  ),
                  suggestionsCallback: (pattern) {
                    return (state).futureCityList!;
                  },
                  itemBuilder: (context, City suggestion) {
                    return ListTile(
                      title: Text(suggestion.name),
                    );
                  },
                  transitionBuilder: (context, suggestionsBox, controller) {
                    return suggestionsBox;
                  },
                  onSuggestionSelected: (City suggestion) {
                    FeedBackScreen.officeInputController.clear();
                    FeedBackScreen.cityInputController.text = suggestion.name;
                    context
                        .read<FeedbackBloc>()
                        .add(FeedbackCityFormEvent(suggestion));
                  },
                  validator: (value) =>
                      value!.isEmpty ? 'Please select a city' : null,
                ),
              );
            } else {
              FeedBackScreen.cityInputController.clear();
              return const Center();
            }
          } else {
            throw Exception("Bad state: $state");
          }
        });
  }
}

class _OfficeField extends StatelessWidget {
  _OfficeField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeedbackBloc, FeedbackState>(
      listener: (context, state) {},
      buildWhen: (previous, current) => (current is FeedbackInputFieldsState),
      builder: (context, state) {
        if (state is FeedbackInputFieldsState) {
          if (state.officeFieldVisible) {
            return TypeAheadFormField(
              textFieldConfiguration: TextFieldConfiguration(
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: Colors.black, fontSize: 20),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Выберите офис...",
                ),
                controller: FeedBackScreen.officeInputController,
              ),
              suggestionsCallback: (pattern) {
                return (state).futureOfficeList!;
              },
              itemBuilder: (context, Office suggestion) {
                return ListTile(
                  title: Text(suggestion.address),
                );
              },
              transitionBuilder: (context, suggestionsBox, controller) {
                return suggestionsBox;
              },
              onSuggestionSelected: (Office suggestion) {
                FeedBackScreen.officeInputController.text = suggestion.address;
                context
                    .read<FeedbackBloc>()
                    .add(FeedbackOfficeFormEvent(suggestion));
              },
              validator: (value) =>
                  value!.isEmpty ? 'Please select a office' : null,
            );
          } else {
            FeedBackScreen.officeInputController.clear();
            return const Center();
          }
        } else {
          throw Exception("Bad state: $state");
        }
      },
    );
  }
}

class _MessageField extends StatelessWidget {
  const _MessageField();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedbackBloc, FeedbackState>(
      buildWhen: (previous, current) => (current is FeedbackInputFieldsState),
      builder: (context, state) {
        if (state is FeedbackInputFieldsState) {
          if (state.messageFieldVisible) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text("Сообщение",
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
                      onChanged: (form) {
                        context
                            .read<FeedbackBloc>()
                            .add(FeedbackMessageInputEvent(form));
                      },
                      controller: FeedBackScreen.messageInputController,
                      decoration:
                          const InputDecoration(hintText: 'Введите текст \n\n'),
                      keyboardType: TextInputType.streetAddress,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: Colors.black, fontSize: 20),
                      maxLines: 20,
                      minLines: 1,
                      maxLength: 1000,
                    ),
                  )
                ],
              ),
            );
          } else {
            return Container();
          }
        } else {
          throw Exception("Bad state: $state");
        }
      },
    );
  }
}

class _Button extends StatelessWidget {
  void _submitButton(BuildContext popupContext) async {
    bool _exit = false;
    
    await showDialog(
        context: popupContext,
        builder: (context) {
          return BlocProvider<FeedbackBloc>.value(
            value: popupContext.read<FeedbackBloc>(),
            child: BlocBuilder<FeedbackBloc, FeedbackState>(
              buildWhen: (previous, current) => current is FeedbackPopupState,
              builder: (popupContext, state) {
                if (state is FeedbackPopupLoadingState) {
                  return const AlertDialog(
                    title: Center(child: CircularProgressIndicator()),
                  );
                }
                if (state == FeedbackSuccessState) {
                  _exit = true;
                  AlertDialog(
                    title: Text(
                      "Сообщение отправлено",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.green.shade900),
                    ),
                  );
                }
                if (state is FeedbackPopupErrorState) {
                  return AlertDialog(
                    title: Text(
                      "Не удалось отправить сообщение",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.green.shade900),
                    ),
                  );
                }
                throw Exception('Bad State: $state');
                //todo FIX STATE
              },
            ),
          );
        });
    if (_exit) {
      Navigator.pop(popupContext);
    }
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedbackBloc, FeedbackState>(
      buildWhen: (previous, current) => (current is FeedbackInputFieldsState),
      builder: (context, state) {
        if (state is FeedbackInputFieldsState) {
          if (state.buttonVisible) {
            return Center(
              child: AtbElevatedButton(
                  onPressed: () {
                    context.read<FeedbackBloc>().add(FeedbackButtonSubmitEvent());
                    _submitButton(context);
                  },
                  text: "Отправить"),
            );
          } else {
            return Container();
          }
        } else {
          throw Exception("Bad state: $state");
        }
      },
    );
  }
}
