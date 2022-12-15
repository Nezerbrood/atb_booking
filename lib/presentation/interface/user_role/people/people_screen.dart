import 'dart:async';
import 'package:atb_booking/logic/user_role/people_bloc/people_bloc.dart';
import 'package:atb_booking/presentation/constants/styles.dart';
import 'package:atb_booking/presentation/interface/user_role/people/person_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PeopleScreen extends StatelessWidget {
  const PeopleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PeopleBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Люди"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            SearchPeopleTextField(),
            SearchResultList(),
          ],
        ),
      ),
    );
  }
}

class SearchPeopleTextField extends StatelessWidget {
  final _controller = TextEditingController();
  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    _onSearchChanged(String query) {
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () {
        context.read<PeopleBloc>().add(PeopleLoadEvent(query, true));
      });
    }

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 20,
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Кого ищем?",
                ),
                textInputAction: TextInputAction.search,
                controller: _controller,
                onChanged: (pattern) {
                  // при добавлении или стирании в поле
                  _onSearchChanged(pattern);
                },
              ),
            ),
            Expanded(
              flex: 12,
              child: BlocBuilder<PeopleBloc, PeopleState>(
                builder: (context, state) {
                  return IconButton(
                      onPressed: () {
                        context
                            .read<PeopleBloc>()
                            .add(PeopleIsFavoriteChangeEvent(_controller.text));
                      },
                      icon: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text("Только\nизбранные",
                              textAlign: TextAlign.right),
                          const SizedBox(width: 10),
                          state.isFavoriteOn
                              ? Icon(Icons.star, color: appThemeData.primaryColor)
                              : Icon(
                                  Icons.star_border,
                                  color: appThemeData.primaryColor,
                                ),
                        ],
                      ));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SearchResultList extends StatelessWidget {
  SearchResultList({super.key});
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        context.read<PeopleBloc>().add(PeopleLoadNextPageEvent());
      }
    });
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: BlocBuilder<PeopleBloc, PeopleState>(
          builder: (context, state) {
            if (state is PeopleLoadedState) {
              if (state.formHasBeenChanged) {
                _scrollController.jumpTo(0);
              }
            }

            if (state is PeopleEmptyState) {
              return const Center(
                child: Text("Ничего не найдено"),
              );
            }
            if (state is PeopleInitialState) {
              return const Center(
                child: Text("Заполните поле"),
              );
            }

            return ListView.builder(
              controller: _scrollController,
              shrinkWrap: true,
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    PersonCard(state.users[index]),
                    (state is PeopleLoadingState &&
                            index == state.users.length - 1)
                        ? Container(
                            height: 150,
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 100),
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ))
                        : const SizedBox.shrink(),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
