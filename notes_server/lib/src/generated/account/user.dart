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
import 'package:serverpod_serialization/serverpod_serialization.dart';

abstract class User extends _i1.TableRow {
  User._({
    int? id,
    required this.uid,
    required this.email,
    required this.created,
    this.tags,
    required this.blocked,
  }) : super(id);

  factory User({
    int? id,
    required String uid,
    required String email,
    required DateTime created,
    List<_i2.UserTag>? tags,
    required bool blocked,
  }) = _UserImpl;

  factory User.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return User(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      uid: serializationManager.deserialize<String>(jsonSerialization['uid']),
      email:
          serializationManager.deserialize<String>(jsonSerialization['email']),
      created: serializationManager
          .deserialize<DateTime>(jsonSerialization['created']),
      tags: serializationManager
          .deserialize<List<_i2.UserTag>?>(jsonSerialization['tags']),
      blocked:
          serializationManager.deserialize<bool>(jsonSerialization['blocked']),
    );
  }

  static final t = UserTable();

  static const db = UserRepository._();

  String uid;

  String email;

  DateTime created;

  List<_i2.UserTag>? tags;

  bool blocked;

  @override
  _i1.Table get table => t;

  User copyWith({
    int? id,
    String? uid,
    String? email,
    DateTime? created,
    List<_i2.UserTag>? tags,
    bool? blocked,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'uid': uid,
      'email': email,
      'created': created.toJson(),
      'blocked': blocked,
    };
  }

  @override
  @Deprecated('Will be removed in 2.0.0')
  Map<String, dynamic> toJsonForDatabase() {
    return {
      'id': id,
      'uid': uid,
      'email': email,
      'created': created,
      'blocked': blocked,
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      if (id != null) 'id': id,
      'uid': uid,
      'email': email,
      'created': created.toJson(),
      if (tags != null) 'tags': tags?.toJson(valueToJson: (v) => v.allToJson()),
      'blocked': blocked,
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
      case 'uid':
        uid = value;
        return;
      case 'email':
        email = value;
        return;
      case 'created':
        created = value;
        return;
      case 'blocked':
        blocked = value;
        return;
      default:
        throw UnimplementedError();
    }
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.find instead.')
  static Future<List<User>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserTable>? where,
    int? limit,
    int? offset,
    _i1.Column? orderBy,
    List<_i1.Order>? orderByList,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
    UserInclude? include,
  }) async {
    return session.db.find<User>(
      where: where != null ? where(User.t) : null,
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
  static Future<User?> findSingleRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserTable>? where,
    int? offset,
    _i1.Column? orderBy,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
    UserInclude? include,
  }) async {
    return session.db.findSingleRow<User>(
      where: where != null ? where(User.t) : null,
      offset: offset,
      orderBy: orderBy,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
      include: include,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.findById instead.')
  static Future<User?> findById(
    _i1.Session session,
    int id, {
    UserInclude? include,
  }) async {
    return session.db.findById<User>(
      id,
      include: include,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.deleteWhere instead.')
  static Future<int> delete(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<UserTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<User>(
      where: where(User.t),
      transaction: transaction,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.deleteRow instead.')
  static Future<bool> deleteRow(
    _i1.Session session,
    User row, {
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
    User row, {
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
    User row, {
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
    _i1.WhereExpressionBuilder<UserTable>? where,
    int? limit,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<User>(
      where: where != null ? where(User.t) : null,
      limit: limit,
      useCache: useCache,
      transaction: transaction,
    );
  }

  static UserInclude include({_i2.UserTagIncludeList? tags}) {
    return UserInclude._(tags: tags);
  }

  static UserIncludeList includeList({
    _i1.WhereExpressionBuilder<UserTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserTable>? orderByList,
    UserInclude? include,
  }) {
    return UserIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(User.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(User.t),
      include: include,
    );
  }
}

class _Undefined {}

class _UserImpl extends User {
  _UserImpl({
    int? id,
    required String uid,
    required String email,
    required DateTime created,
    List<_i2.UserTag>? tags,
    required bool blocked,
  }) : super._(
          id: id,
          uid: uid,
          email: email,
          created: created,
          tags: tags,
          blocked: blocked,
        );

  @override
  User copyWith({
    Object? id = _Undefined,
    String? uid,
    String? email,
    DateTime? created,
    Object? tags = _Undefined,
    bool? blocked,
  }) {
    return User(
      id: id is int? ? id : this.id,
      uid: uid ?? this.uid,
      email: email ?? this.email,
      created: created ?? this.created,
      tags: tags is List<_i2.UserTag>? ? tags : this.tags?.clone(),
      blocked: blocked ?? this.blocked,
    );
  }
}

class UserTable extends _i1.Table {
  UserTable({super.tableRelation}) : super(tableName: 'user') {
    uid = _i1.ColumnString(
      'uid',
      this,
    );
    email = _i1.ColumnString(
      'email',
      this,
    );
    created = _i1.ColumnDateTime(
      'created',
      this,
    );
    blocked = _i1.ColumnBool(
      'blocked',
      this,
    );
  }

  late final _i1.ColumnString uid;

  late final _i1.ColumnString email;

  late final _i1.ColumnDateTime created;

  _i2.UserTagTable? ___tags;

  _i1.ManyRelation<_i2.UserTagTable>? _tags;

  late final _i1.ColumnBool blocked;

  _i2.UserTagTable get __tags {
    if (___tags != null) return ___tags!;
    ___tags = _i1.createRelationTable(
      relationFieldName: '__tags',
      field: User.t.id,
      foreignField: _i2.UserTag.t.userId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.UserTagTable(tableRelation: foreignTableRelation),
    );
    return ___tags!;
  }

  _i1.ManyRelation<_i2.UserTagTable> get tags {
    if (_tags != null) return _tags!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'tags',
      field: User.t.id,
      foreignField: _i2.UserTag.t.userId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.UserTagTable(tableRelation: foreignTableRelation),
    );
    _tags = _i1.ManyRelation<_i2.UserTagTable>(
      tableWithRelations: relationTable,
      table: _i2.UserTagTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _tags!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        uid,
        email,
        created,
        blocked,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'tags') {
      return __tags;
    }
    return null;
  }
}

@Deprecated('Use UserTable.t instead.')
UserTable tUser = UserTable();

class UserInclude extends _i1.IncludeObject {
  UserInclude._({_i2.UserTagIncludeList? tags}) {
    _tags = tags;
  }

  _i2.UserTagIncludeList? _tags;

  @override
  Map<String, _i1.Include?> get includes => {'tags': _tags};

  @override
  _i1.Table get table => User.t;
}

class UserIncludeList extends _i1.IncludeList {
  UserIncludeList._({
    _i1.WhereExpressionBuilder<UserTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(User.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => User.t;
}

class UserRepository {
  const UserRepository._();

  final attach = const UserAttachRepository._();

  final attachRow = const UserAttachRowRepository._();

  final detach = const UserDetachRepository._();

  final detachRow = const UserDetachRowRepository._();

  Future<List<User>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserTable>? orderByList,
    _i1.Transaction? transaction,
    UserInclude? include,
  }) async {
    return session.dbNext.find<User>(
      where: where?.call(User.t),
      orderBy: orderBy?.call(User.t),
      orderByList: orderByList?.call(User.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  Future<User?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserTable>? where,
    int? offset,
    _i1.OrderByBuilder<UserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserTable>? orderByList,
    _i1.Transaction? transaction,
    UserInclude? include,
  }) async {
    return session.dbNext.findFirstRow<User>(
      where: where?.call(User.t),
      orderBy: orderBy?.call(User.t),
      orderByList: orderByList?.call(User.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  Future<User?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    UserInclude? include,
  }) async {
    return session.dbNext.findById<User>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  Future<List<User>> insert(
    _i1.Session session,
    List<User> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.insert<User>(
      rows,
      transaction: transaction,
    );
  }

  Future<User> insertRow(
    _i1.Session session,
    User row, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.insertRow<User>(
      row,
      transaction: transaction,
    );
  }

  Future<List<User>> update(
    _i1.Session session,
    List<User> rows, {
    _i1.ColumnSelections<UserTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.update<User>(
      rows,
      columns: columns?.call(User.t),
      transaction: transaction,
    );
  }

  Future<User> updateRow(
    _i1.Session session,
    User row, {
    _i1.ColumnSelections<UserTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.updateRow<User>(
      row,
      columns: columns?.call(User.t),
      transaction: transaction,
    );
  }

  Future<List<int>> delete(
    _i1.Session session,
    List<User> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.delete<User>(
      rows,
      transaction: transaction,
    );
  }

  Future<int> deleteRow(
    _i1.Session session,
    User row, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.deleteRow<User>(
      row,
      transaction: transaction,
    );
  }

  Future<List<int>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<UserTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.deleteWhere<User>(
      where: where(User.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.count<User>(
      where: where?.call(User.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class UserAttachRepository {
  const UserAttachRepository._();

  Future<void> tags(
    _i1.Session session,
    User user,
    List<_i2.UserTag> userTag,
  ) async {
    if (userTag.any((e) => e.id == null)) {
      throw ArgumentError.notNull('userTag.id');
    }
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $userTag = userTag.map((e) => e.copyWith(userId: user.id)).toList();
    await session.dbNext.update<_i2.UserTag>(
      $userTag,
      columns: [_i2.UserTag.t.userId],
    );
  }
}

class UserAttachRowRepository {
  const UserAttachRowRepository._();

  Future<void> tags(
    _i1.Session session,
    User user,
    _i2.UserTag userTag,
  ) async {
    if (userTag.id == null) {
      throw ArgumentError.notNull('userTag.id');
    }
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $userTag = userTag.copyWith(userId: user.id);
    await session.dbNext.updateRow<_i2.UserTag>(
      $userTag,
      columns: [_i2.UserTag.t.userId],
    );
  }
}

class UserDetachRepository {
  const UserDetachRepository._();

  Future<void> tags(
    _i1.Session session,
    List<_i2.UserTag> userTag,
  ) async {
    if (userTag.any((e) => e.id == null)) {
      throw ArgumentError.notNull('userTag.id');
    }

    var $userTag = userTag.map((e) => e.copyWith(userId: null)).toList();
    await session.dbNext.update<_i2.UserTag>(
      $userTag,
      columns: [_i2.UserTag.t.userId],
    );
  }
}

class UserDetachRowRepository {
  const UserDetachRowRepository._();

  Future<void> tags(
    _i1.Session session,
    _i2.UserTag userTag,
  ) async {
    if (userTag.id == null) {
      throw ArgumentError.notNull('userTag.id');
    }

    var $userTag = userTag.copyWith(userId: null);
    await session.dbNext.updateRow<_i2.UserTag>(
      $userTag,
      columns: [_i2.UserTag.t.userId],
    );
  }
}
