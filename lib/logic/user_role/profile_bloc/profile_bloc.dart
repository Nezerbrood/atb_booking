import 'package:atb_booking/logic/secure_storage_api.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../data/models/user.dart';
import '../../../data/services/users_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  static final ProfileBloc _singleton = ProfileBloc._internal();

  factory ProfileBloc() {
    return _singleton;
  }

  ProfileBloc._internal() : super(ProfileInitialState()) {
    on<ProfileLoadEvent>((event, emit) async {
      try {
        emit(ProfileLoadingState());
        int id = await SecurityStorage().getIdStorage();
        User user = await UsersRepository().getUserById(id);
        emit(ProfileLoadedState(userPerson: user));
      } catch (e) {
        emit(ProfileErrorState());
      }
    });

    on<ProfileExitToAuthEvent>((event, emit) async {
      await SecurityStorage().clearValueStorage();
      
    });
    emit(ProfileLoadingState());
    add(ProfileLoadEvent());
  }
}
