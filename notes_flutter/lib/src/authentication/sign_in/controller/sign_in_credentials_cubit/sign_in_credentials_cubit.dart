import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:notes_flutter/src/authentication/authentication.dart';

part 'sign_in_credentials_state.dart';

/// Handles the sign-in credentials state input validation.
class SignInCredentialsCubit extends Cubit<SignInCredentialsState> {
  /// Creates an empty (no email or password) sign-in credentials cubit.
  SignInCredentialsCubit() : super(SignInCredentialsState());

  /// Updates the email input state.
  void setEmail(String email) {
    emit(state.copyWith(email: EmailInput.dirty(email)));
  }

  /// Updates the password.
  void setPassword(String password) {
    emit(state.copyWith(password: password));
  }

  /// Returns the current email and password.
  ({String email, String password}) credentials() {
    if (!state.email.isValid || state.password.isEmpty) {
      throw StateError("Must not get sign-in credentials from invalid state.");
    }

    return (
      email: state.email.value,
      password: state.password,
    );
  }

  /// Clears the email and password.
  void clear() {
    emit(SignInCredentialsState());
  }
}
