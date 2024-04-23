part of 'sign_in_cubit.dart';

/// The state of the sign-in process.
class SignInState extends Equatable {
  /// Creates a new [SignInState] with the provided [status] and [error].
  const SignInState({
    required this.status,
    this.error,
  });

  /// Creates a new [SignInState] with [SignInStatus.signedOut] status, without
  /// an error.
  const SignInState.signedOut()
      : status = SignInStatus.signedOut,
        error = null;

  /// Creates a new [SignInState] with [SignInStatus.signingIn] status, without
  /// an error.
  const SignInState.signedIn()
      : status = SignInStatus.signedIn,
        error = null;

  /// Creates a new [SignInState] with [SignInStatus.validationRequired] status,
  /// without an error.
  const SignInState.emailNotVerified()
      : status = SignInStatus.validationRequired,
        error = null;

  /// Creates a new [SignInState] with the provided [status] and without an
  /// error.
  const SignInState.withoutError(this.status) : error = null;

  /// Creates a new [SignInState] with the provided [error].
  ///
  /// If the current status is [SignInStatus.signingIn], the status will be
  /// reverted to [SignInStatus.signedOut].
  ///
  /// Otherwise, the status will remain the same.
  SignInState withError(String error) {
    return SignInState(
      status:
          status == SignInStatus.signingIn ? SignInStatus.signedOut : status,
      error: error,
    );
  }

  /// The current status of the sign-in process.
  final SignInStatus status;

  /// The error message (if any) of the sign-in process.
  final String? error;

  SignInState copyWith({
    SignInStatus? status,
    String? Function()? error,
  }) {
    return SignInState(
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

/// The status of the sign-in process.
///
/// The sign-in process can be in one of the following states:
/// * [SignInStatus.signedOut] - The user is not signed in.
/// * [SignInStatus.signingIn] - The user is currently signing in.
/// * [SignInStatus.validationRequired] - The user needs to validate their
/// account.
/// * [SignInStatus.signedIn] - The user is signed in.
enum SignInStatus {
  /// The user is not signed in.
  signedOut,

  /// The user is currently signing in.
  signingIn,

  /// The user needs to validate their account.
  validationRequired,

  /// The user is signed in.
  signedIn,
}
