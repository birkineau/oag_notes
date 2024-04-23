/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../protocol.dart' as _i2;

abstract class UserTag extends _i1.TableRow {
  UserTag._({
    int? id,
    required this.userId,
    this.user,
    required this.tagId,
    this.tag,
  }) : super(id);

  factory UserTag({
    int? id,
    required int userId,
    _i2.User? user,
    required int tagId,
    _i2.Tag? tag,
  }) = _UserTagImpl;

  factory UserTag.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return UserTag(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      userId:
          serializationManager.deserialize<int>(jsonSerialization['userId']),
      user: serializationManager
          .deserialize<_i2.User?>(jsonSerialization['user']),
      tagId: serializationManager.deserialize<int>(jsonSerialization['tagId']),
      tag: serializationManager.deserialize<_i2.Tag?>(jsonSerialization['tag']),
    );
  }

  static final t = UserTagTable();

  static const db = UserTagRepository._();

  int userId;

  _i2.User? user;

  int tagId;

  _i2.Tag? tag;

  @override
  _i1.Table get table => t;

  UserTag copyWith({
    int? id,
    int? userId,
    _i2.User? user,
    int? tagId,
    _i2.Tag? tag,
  });
  @override
  Map<String, dynamic> toJson() {
    return {if (id != null) 'id': id};
  }

  @override
  @Deprecated('Will be removed in 2.0.0')
  Map<String, dynamic> toJsonForDatabase() {
    return {
      'id': id,
      'userId': userId,
      'tagId': tagId,
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.allToJson(),
      'tagId': tagId,
      if (tag != null) 'tag': tag?.allToJson(),
    };
  }

  @override
  @Deprecated('Will be removed in 2.0.0')
  void setColumn(
    String columnName,
    value,
  ) {
    switch (columnName) {
      case 'id':
        id = value;
        return;
      case 'userId':
        userId = value;
        return;
      case 'tagId':
        tagId = value;
        return;
      default:
        throw UnimplementedError();
    }
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.find instead.')
  static Future<List<UserTag>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserTagTable>? where,
    int? limit,
    int? offset,
    _i1.Column? orderBy,
    List<_i1.Order>? orderByList,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
    UserTagInclude? include,
  }) async {
    return session.db.find<UserTag>(
      where: where != null ? where(UserTag.t) : null,
      limit: limit,
      offset: offset,
      orderBy: orderBy,
      orderByList: orderByList,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
      include: include,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.findRow instead.')
  static Future<UserTag?> findSingleRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserTagTable>? where,
    int? offset,
    _i1.Column? orderBy,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
    UserTagInclude? include,
  }) async {
    return session.db.findSingleRow<UserTag>(
      where: where != null ? where(UserTag.t) : null,
      offset: offset,
      orderBy: orderBy,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
      include: include,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.findById instead.')
  static Future<UserTag?> findById(
    _i1.Session session,
    int id, {
    UserTagInclude? include,
  }) async {
    return session.db.findById<UserTag>(
      id,
      include: include,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.deleteWhere instead.')
  static Future<int> delete(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<UserTagTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<UserTag>(
      where: where(UserTag.t),
      transaction: transaction,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.deleteRow instead.')
  static Future<bool> deleteRow(
    _i1.Session session,
    UserTag row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow(
      row,
      transaction: transaction,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.update instead.')
  static Future<bool> update(
    _i1.Session session,
    UserTag row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.update(
      row,
      transaction: transaction,
    );
  }

  @Deprecated(
      'Will be removed in 2.0.0. Use: db.insert instead. Important note: In db.insert, the object you pass in is no longer modified, instead a new copy with the added row is returned which contains the inserted id.')
  static Future<void> insert(
    _i1.Session session,
    UserTag row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert(
      row,
      transaction: transaction,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.count instead.')
  static Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserTagTable>? where,
    int? limit,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<UserTag>(
      where: where != null ? where(UserTag.t) : null,
      limit: limit,
      useCache: useCache,
      transaction: transaction,
    );
  }

  static UserTagInclude include({
    _i2.UserInclude? user,
    _i2.TagInclude? tag,
  }) {
    return UserTagInclude._(
      user: user,
      tag: tag,
    );
  }

  static UserTagIncludeList includeList({
    _i1.WhereExpressionBuilder<UserTagTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserTagTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserTagTable>? orderByList,
    UserTagInclude? include,
  }) {
    return UserTagIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserTag.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(UserTag.t),
      include: include,
    );
  }
}

class _Undefined {}

class _UserTagImpl extends UserTag {
  _UserTagImpl({
    int? id,
    required int userId,
    _i2.User? user,
    required int tagId,
    _i2.Tag? tag,
  }) : super._(
          id: id,
          userId: userId,
          user: user,
          tagId: tagId,
          tag: tag,
        );

  @override
  UserTag copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? user = _Undefined,
    int? tagId,
    Object? tag = _Undefined,
  }) {
    return UserTag(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.User? ? user : this.user?.copyWith(),
      tagId: tagId ?? this.tagId,
      tag: tag is _i2.Tag? ? tag : this.tag?.copyWith(),
    );
  }
}

class UserTagTable extends _i1.Table {
  UserTagTable({super.tableRelation}) : super(tableName: 'user_tag') {
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    tagId = _i1.ColumnInt(
      'tagId',
      this,
    );
  }

  late final _i1.ColumnInt userId;

  _i2.UserTable? _user;

  late final _i1.ColumnInt tagId;

  _i2.TagTable? _tag;

  _i2.UserTable get user {
    if (_user != null) return _user!;
    _user = _i1.createRelationTable(
      relationFieldName: 'user',
      field: UserTag.t.userId,
      foreignField: _i2.User.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.UserTable(tableRelation: foreignTableRelation),
    );
    return _user!;
  }

  _i2.TagTable get tag {
    if (_tag != null) return _tag!;
    _tag = _i1.createRelationTable(
      relationFieldName: 'tag',
      field: UserTag.t.tagId,
      foreignField: _i2.Tag.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.TagTable(tableRelation: foreignTableRelation),
    );
    return _tag!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        userId,
        tagId,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'user') {
      return user;
    }
    if (relationField == 'tag') {
      return tag;
    }
    return null;
  }
}

@Deprecated('Use UserTagTable.t instead.')
UserTagTable tUserTag = UserTagTable();

class UserTagInclude extends _i1.IncludeObject {
  UserTagInclude._({
    _i2.UserInclude? user,
    _i2.TagInclude? tag,
  }) {
    _user = user;
    _tag = tag;
  }

  _i2.UserInclude? _user;

  _i2.TagInclude? _tag;

  @override
  Map<String, _i1.Include?> get includes => {
        'user': _user,
        'tag': _tag,
      };

  @override
  _i1.Table get table => UserTag.t;
}

class UserTagIncludeList extends _i1.IncludeList {
  UserTagIncludeList._({
    _i1.WhereExpressionBuilder<UserTagTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(UserTag.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => UserTag.t;
}

class UserTagRepository {
  const UserTagRepository._();

  final attachRow = const UserTagAttachRowRepository._();

  Future<List<UserTag>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserTagTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserTagTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserTagTable>? orderByList,
    _i1.Transaction? transaction,
    UserTagInclude? include,
  }) async {
    return session.dbNext.find<UserTag>(
      where: where?.call(UserTag.t),
      orderBy: orderBy?.call(UserTag.t),
      orderByList: orderByList?.call(UserTag.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  Future<UserTag?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserTagTable>? where,
    int? offset,
    _i1.OrderByBuilder<UserTagTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserTagTable>? orderByList,
    _i1.Transaction? transaction,
    UserTagInclude? include,
  }) async {
    return session.dbNext.findFirstRow<UserTag>(
      where: where?.call(UserTag.t),
      orderBy: orderBy?.call(UserTag.t),
      orderByList: orderByList?.call(UserTag.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  Future<UserTag?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    UserTagInclude? include,
  }) async {
    return session.dbNext.findById<UserTag>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  Future<List<UserTag>> insert(
    _i1.Session session,
    List<UserTag> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.insert<UserTag>(
      rows,
      transaction: transaction,
    );
  }

  Future<UserTag> insertRow(
    _i1.Session session,
    UserTag row, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.insertRow<UserTag>(
      row,
      transaction: transaction,
    );
  }

  Future<List<UserTag>> update(
    _i1.Session session,
    List<UserTag> rows, {
    _i1.ColumnSelections<UserTagTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.update<UserTag>(
      rows,
      columns: columns?.call(UserTag.t),
      transaction: transaction,
    );
  }

  Future<UserTag> updateRow(
    _i1.Session session,
    UserTag row, {
    _i1.ColumnSelections<UserTagTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.updateRow<UserTag>(
      row,
      columns: columns?.call(UserTag.t),
      transaction: transaction,
    );
  }

  Future<List<int>> delete(
    _i1.Session session,
    List<UserTag> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.delete<UserTag>(
      rows,
      transaction: transaction,
    );
  }

  Future<int> deleteRow(
    _i1.Session session,
    UserTag row, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.deleteRow<UserTag>(
      row,
      transaction: transaction,
    );
  }

  Future<List<int>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<UserTagTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.deleteWhere<UserTag>(
      where: where(UserTag.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserTagTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.count<UserTag>(
      where: where?.call(UserTag.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class UserTagAttachRowRepository {
  const UserTagAttachRowRepository._();

  Future<void> user(
    _i1.Session session,
    UserTag userTag,
    _i2.User user,
  ) async {
    if (userTag.id == null) {
      throw ArgumentError.notNull('userTag.id');
    }
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $userTag = userTag.copyWith(userId: user.id);
    await session.dbNext.updateRow<UserTag>(
      $userTag,
      columns: [UserTag.t.userId],
    );
  }

  Future<void> tag(
    _i1.Session session,
    UserTag userTag,
    _i2.Tag tag,
  ) async {
    if (userTag.id == null) {
      throw ArgumentError.notNull('userTag.id');
    }
    if (tag.id == null) {
      throw ArgumentError.notNull('tag.id');
    }

    var $userTag = userTag.copyWith(tagId: tag.id);
    await session.dbNext.updateRow<UserTag>(
      $userTag,
      columns: [UserTag.t.tagId],
    );
  }
}
