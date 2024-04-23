import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:notes_flutter/src/authentication/authentication.dart';

part 'update_password_form_state.dart';

class UpdatePasswordFormCubit extends Cubit<UpdatePasswordFormState> {
  UpdatePasswordFormCubit() : super(UpdatePasswordFormState());

  void setEmail(String email) {
    emit(state.copyWith(email: EmailInput.dirty(email)));
  }

  void setPassword(String password) {
    if (password == state.password.value) {
      return;
    }

    emit(
      state.copyWith(
        password: PasswordInput.dirty(password),
        passwordConfirm: PasswordConfirmInput.dirty(
          password,
          state.passwordConfirm.value,
        ),
      ),
    );
  }

  void setPasswordConfirm(String passwordConfirm) {
    if (passwordConfirm == state.passwordConfirm.value) {
      return;
    }

    emit(
      state.copyWith(
        passwordConfirm: PasswordConfirmInput.dirty(
          state.password.value,
          passwordConfirm,
        ),
      ),
    );
  }

  void clear() {
    emit(UpdatePasswordFormState());
  }
}
