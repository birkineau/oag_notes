import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:notes_flutter/src/authentication/authentication.dart';

part 'sign_up_credentials_state.dart';

/// Handles the sign up credentials state input validation.
class SignUpCredentialsCubit extends Cubit<SignUpCredentialsState> {
  /// Creates an empty (no email or password) sign-up credentials cubit.
  SignUpCredentialsCubit() : super(SignUpCredentialsState());

  /// Updates the email input state.
  void setEmail(String email) {
    if (email == state.email.value) {
      return;
    }

    emit(state.copyWith(email: EmailInput.dirty(email)));
  }

  /// Updates the password input state.
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

  /// Updates the password confirm input state.
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

  /// Returns the email and password credentials.
  ///
  /// Throws a [StateError] if the state is invalid.
  ({String email, String password}) credentials() {
    if (!state.isValid) {
      throw StateError("Must not get sign-up credentials from invalid state.");
    }

    return (
      email: state.email.value,
      password: state.password.value,
    );
  }

  /// Clears the email, password, and password confirmation input fields.
  void clear() {
    emit(SignUpCredentialsState());
  }
}
