
import 'package:atb_booking/data/models/user.dart';
import 'package:atb_booking/data/services/users_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'admin_people_event.dart';

part 'admin_people_state.dart';

class AdminPeopleBloc extends Bloc<AdminPeopleEvent, AdminPeopleState> {
  int page = 0;
  String currentForm = '';
  List<User> loadedUsers = [];

  AdminPeopleBloc() : super(const AdminPeopleInitialState([])) {
    on<AdminPeopleLoadEvent>((event, emit) async {
      emit(AdminPeopleLoadingState(loadedUsers));
      currentForm = event.form;
      if (event.formHasBeenChanged) page = 0;
      if (page == 0) {
        loadedUsers = [];
      }
      var users = await UsersRepository()
          .getAllUsers(page, 10, "fullName"); //todo crate search api
      loadedUsers.addAll(users);
      emit(AdminPeopleLoadedState(loadedUsers, event.formHasBeenChanged));
    });
    on<AdminPeopleLoadNextPageEvent>((event, emit) async {
      page++;
      add(AdminPeopleLoadEvent(currentForm, false));
    });
  }
}
