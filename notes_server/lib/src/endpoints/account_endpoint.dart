import 'package:notes_server/src/generated/protocol.dart';
import 'package:notes_server/src/utility/utility.dart';
import 'package:serverpod/serverpod.dart';

class AccountManagerEndpoint extends Endpoint {
  static const channel = "account_manager_endpoint";

  @override
  bool get logSessions => false;

  @override
  Set<Scope> get requiredScopes {
    return <Scope>{
      Scope(TagType.admin.name),
      Scope(TagType.verified.name),
    };
  }

  Future<List<UserWithTags>> getUsers(Session session) async {
    final users = await User.db.find(
      session,
      include: User.include(
        tags: UserTag.includeList(
          include: UserTag.include(tag: Tag.include()),
        ),
      ),
    );

    return <UserWithTags>[
      for (final user in users)
        UserWithTags(
          user: user,
          tags: <TagType>[
            for (final userTag in user.tags!) userTag.tag!.type,
          ],
        ),
    ];
  }

  Future<bool> addTagTypes(
    Session session,
    int userId,
    Set<TagType> types,
  ) async {
    return UserExt.addTagsByType(session, userId, types);
  }

  Future<bool> removeTagTypes(
    Session session,
    int userId,
    Set<TagType> types,
  ) async {
    return UserExt.removeTagsByType(session, userId, types);
  }

  Future<void> block(Session session, int userId) async {
    final user = await UserExt.getById(session, userId);

    if (user.blocked) {
      return;
    }

    user.blocked = true;

    session.messages.postMessage(
      channel,
      UserMessage(
        user: await User.db.updateRow(session, user),
        type: UserMessageType.blocked,
      ),
    );

    UserExt.log(user, "User blocked.");
  }

  Future<void> unblock(Session session, int userId) async {
    final user = await UserExt.getById(session, userId);

    if (!user.blocked) {
      return;
    }

    user.blocked = false;

    session.messages.postMessage(
      channel,
      UserMessage(
        user: await User.db.updateRow(session, user),
        type: UserMessageType.unblocked,
      ),
    );

    UserExt.log(user, "User unblocked.");
  }
}
