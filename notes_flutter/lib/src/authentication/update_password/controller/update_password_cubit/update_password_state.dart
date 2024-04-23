part of 'update_password_cubit.dart';

/// The state of the password update process.
final class UpdatePasswordState extends Equatable {
  const UpdatePasswordState({
    required this.status,
    this.error,
  });

  const UpdatePasswordState.notRequested()
      : this(status: UpdatePasswordStatus.notRequested);

  /// Creates a new [UpdatePasswordState] with the provided [status], without an
  /// error, using the existing email input.
  const UpdatePasswordState.withoutError(this.status) : error = null;

  UpdatePasswordState withError(String error) {
    return copyWith(
      status: status == UpdatePasswordStatus.requesting
          ? UpdatePasswordStatus.notRequested
          : status == UpdatePasswordStatus.updating
              ? UpdatePasswordStatus.requested
              : status,
      error: error,
    );
  }

  /// The status of the password update process.
  final UpdatePasswordStatus status;

  /// The error message (if any) of the password update process.
  final String? error;

  UpdatePasswordState copyWith({
    UpdatePasswordStatus? status,
    String? error,
  }) {
    return UpdatePasswordState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        status,
        error,
      ];
}

/// The status of the password update process.
///
/// The password update process can be in one of the following states:
/// * [UpdatePasswordStatus.notRequested] - The user has not yet requested a
/// password update.
/// * [UpdatePasswordStatus.updating] - The user has requested a password
/// update, and a update validation code has been sent to the user's email
/// address.
/// * [UpdatePasswordStatus.updated] - The user has entered the correct
/// validation code and the password has been updated.
enum UpdatePasswordStatus {
  /// The user has not yet requested a password update.
  notRequested,

  /// A password update validation code is being requested.
  requesting,

  /// A password update validation code has been sent to the user's email
  /// address.
  requested,

  /// Validating the password update code.
  updating,

  /// The user has entered the correct validation code and the password has been
  /// updated.
  updated,
}
