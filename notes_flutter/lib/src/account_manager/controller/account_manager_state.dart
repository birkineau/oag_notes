part of 'account_manager_cubit.dart';

class AccountManagerState extends Equatable {
  const AccountManagerState({
    required this.values,
  });

  const AccountManagerState.empty() : values = const [];

  final List<UserWithTags> values;

  AccountManagerState copyWith({
    List<UserWithTags>? users,
  }) {
    return AccountManagerState(
      values: users ?? values,
    );
  }

  @override
  List<Object?> get props => [
        values,
      ];
}
