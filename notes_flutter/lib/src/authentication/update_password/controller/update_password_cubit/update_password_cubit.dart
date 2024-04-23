import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_flutter/src/authentication/authentication.dart';

part 'update_password_state.dart';

/// Handles the password update process.
class UpdatePasswordCubit extends Cubit<UpdatePasswordState> {
  UpdatePasswordCubit(this._api)
      : super(const UpdatePasswordState.notRequested());

  final UpdatePasswordApi _api;

  Future<void> requestPasswordUpdate({required String email}) async {
    emit(
      const UpdatePasswordState.withoutError(UpdatePasswordStatus.requesting),
    );

    final requestPasswordUpdate = _api.requestPasswordUpdate(email: email);

    if (await requestPasswordUpdate case final String error) {
      emit(state.withError(error));
      return;
    }

    emit(
      const UpdatePasswordState.withoutError(UpdatePasswordStatus.requested),
    );
  }

  Future<void> updatePassword({
    required String email,
    required String newPassword,
    required String validationCode,
  }) async {
    emit(
      const UpdatePasswordState.withoutError(UpdatePasswordStatus.updating),
    );

    final updatePassword = _api.updatePassword(
      email: email,
      newPassword: newPassword,
      validationCode: validationCode,
    );

    if (await updatePassword case final String error) {
      emit(state.withError(error));
      return;
    }

    emit(
      const UpdatePasswordState.withoutError(UpdatePasswordStatus.updated),
    );
  }

  void clear() {
    emit(
      const UpdatePasswordState.withoutError(UpdatePasswordStatus.notRequested),
    );
  }
}
