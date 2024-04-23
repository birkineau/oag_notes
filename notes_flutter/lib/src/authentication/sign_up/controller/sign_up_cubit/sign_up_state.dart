part of 'sign_up_cubit.dart';

/// The state of the sign-up process.
///
/// This includes the current status of the sign-up process and any error that
/// occurred during the process.
final class SignUpState extends Equatable {
  const SignUpState({
    required this.status,
    this.error,
  });

  /// The user has not yet created an account.
  const SignUpState.pending()
      : status = SignUpStatus.creationRequired,
        error = null;

  /// The user sent an account validation request.
  const SignUpState.validating()
      : status = SignUpStatus.validating,
        error = null;

  const SignUpState.validationRequired()
      : status = SignUpStatus.validationRequired,
        error = null;

  /// The user's account has been validated.
  const SignUpState.validated()
      : status = SignUpStatus.validated,
        error = null;

  /// Sets the [status] to [status] and clears any error.
  const SignUpState.withoutError(this.status) : error = null;

  /// Creates a new [SignUpState] with the specified [error].
  ///
  /// The following status changes occur when an error is set:
  /// * The [status] is set to [SignUpStatus.creationRequired] if the error
  /// occurred during the account creation process.
  /// * The [status] is set to [SignUpStatus.validationRequired] if the error
  /// occurred during the account validation process.
  SignUpState withError(String error) {
    return SignUpState(
      /// The sign-up process can fail while creating or validating an account.
      ///
      /// * If the sign-up process fails while creating an account, the status
      /// is set to [SignUpStatus.create].
      /// * If the sign-up process fails while validating an account, the status
      /// is set to [SignUpStatus.validate].
      ///
      /// This allows the user can retry the failed step.
      status: status == SignUpStatus.validating
          ? SignUpStatus.validationRequired
          : SignUpStatus.creationRequired,
      error: error,
    );
  }

  /// The current status of the sign-up process.
  final SignUpStatus status;

  /// The error (if any) that occurred during the sign-up process.
  final String? error;

  SignUpState copyWith({
    SignUpStatus? status,
    String? Function()? error,
  }) {
    return SignUpState(
      status: status ?? this.status,
      error: error != null ? error() : this.error,
    );
  }

  @override
  List<Object?> get props => [
        status,
        error,
      ];
}

/// The status of the sign-up process.
///
/// The sign-up process can be in one of the following states:
/// * [SignUpStatus.creationRequired] - The user has not yet created an account.
/// * [SignUpStatus.creating] - The user sent an account creation request.
/// * [SignUpStatus.validationRequired] - The user's account was created, but
/// requires validation.
/// * [SignUpStatus.validating] - The user sent a validation request.
/// * [SignUpStatus.validated] - The user's account has been validated.
enum SignUpStatus {
  /// The user has not yet created an account.
  creationRequired,

  /// The user sent an account creation request.
  creating,

  /// The user's account was created, but requires validation.
  validationRequired,

  /// The user sent a validation request.
  validating,

  /// The user's account has been validated.
  validated,
}
