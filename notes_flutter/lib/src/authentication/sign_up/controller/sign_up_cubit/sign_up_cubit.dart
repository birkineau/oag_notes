import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_flutter/src/authentication/authentication.dart';

part 'sign_up_state.dart';

/// Provides the sign-up functionality.
///
/// This Cubit is responsible for creating a new account, requesting a
/// validation code, and validating the account using a code.
class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._api) : super(const SignUpState.pending());

  /// The API used to handle sign-up operations.
  final SignUpApi _api;

  /// Creates a new account with the specified [email] and [password].
  Future<bool> createAccount({
    required String email,
    required String password,
  }) async {
    emit(const SignUpState.withoutError(SignUpStatus.creating));

    if (await _api.createAccount(email, password) case final String error) {
      emit(state.withError(error));
      return false;
    }

    emit(const SignUpState.withoutError(SignUpStatus.validationRequired));
    return true;
  }

  /// Requests a validation code for the specified [email].
  ///
  /// The server will send an email with a validation code to the specified
  /// email address.
  ///
  /// The validation code must be entered by the user to validate the account
  /// through the [SignUpValidationCodeInput] in the [SignUpValidationPage].
  Future<void> requestValidationCode(String email) async {
    if (state.status == SignUpStatus.validating ||
        state.status == SignUpStatus.validated) {
      return;
    }

    emit(const SignUpState.validating());

    if (await _api.requestValidationCode(email) case final String error) {
      emit(state.withError(error));
      return;
    }

    emit(const SignUpState.validationRequired());
  }

  /// Validates the account with the server using the [email] and [code].
  Future<bool> validateAccount(String email, String code) async {
    emit(const SignUpState.validating());

    if (await _api.validateAccount(email, code) case final String error) {
      emit(state.withError(error));
      return false;
    }

    emit(const SignUpState.validated());
    return true;
  }

  /// Resets the state of the Cubit.
  void reset() {
    emit(const SignUpState.pending());
  }
}
