import 'dart:async';

import 'package:atb_booking/logic/admin_role/people/admin_people_bloc.dart';
import 'package:atb_booking/presentation/interface/admin_role/people/admin_person_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminPeopleScreen extends StatelessWidget {
  const AdminPeopleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        _PeopleSearchField(),
        _PeopleSearchResultList(),
      ],),
    );
  }
}

class _PeopleSearchField extends StatelessWidget {
  final _controller = TextEditingController();
  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    _onSearchChanged(String query) {
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () {
        context.read<AdminPeopleBloc>().add(AdminPeopleLoadEvent(query, true));
      });
    }

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
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
        ],
      ),
    );
  }
}

class _PeopleSearchResultList extends StatelessWidget {
  _PeopleSearchResultList({super.key});
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        context.read<AdminPeopleBloc>().add(AdminPeopleLoadNextPageEvent());
      }
    });
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: BlocBuilder<AdminPeopleBloc, AdminPeopleState>(
          builder: (context, state) {
            if (state is AdminPeopleLoadedState) {
              if (state.formHasBeenChanged) {
                _scrollController.jumpTo(0);
              }
            }

            if (state is AdminPeopleEmptyState) {
              return const Center(
                child: Text("Ничего не найдено"),
              );
            }
            if (state is AdminPeopleInitialState) {
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
                    AdminPersonCard(state.users[index]),
                    (state is AdminPeopleLoadingState &&
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
