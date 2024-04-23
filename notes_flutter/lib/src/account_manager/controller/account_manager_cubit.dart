import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_client/notes_client.dart';
import 'package:notes_flutter/notes_flutter.dart';

part 'account_manager_state.dart';

class AccountManagerCubit extends Cubit<AccountManagerState> {
  AccountManagerCubit() : super(const AccountManagerState.empty());

  Future<void> getUsers() async {
    emit(state.copyWith(users: await di<Client>().accountManager.getUsers()));
  }

  Future<void> addTagTypes(int userId, Set<TagType> types) async {
    await di<Client>().accountManager.addTagTypes(userId, types);

    emit(
      state.copyWith(
        users: [
          for (var i = 0; i < state.values.length; i++)
            if (state.values[i].user.id == userId)
              state.values[i]..tags.addAll(types),
        ],
      ),
    );
  }

  Future<void> block(int userId) async {
    await di<Client>().accountManager.block(userId);

    emit(
      state.copyWith(
        users: [
          for (var i = 0; i < state.values.length; i++)
            if (state.values[i].user.id == userId)
              state.values[i]..user.blocked = true,
        ],
      ),
    );
  }

  Future<void> unblock(int userId) async {
    await di<Client>().accountManager.unblock(userId);

    emit(
      state.copyWith(
        users: [
          for (var i = 0; i < state.values.length; i++)
            if (state.values[i].user.id == userId)
              state.values[i]..user.blocked = false,
        ],
      ),
    );
  }
}
