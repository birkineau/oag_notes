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

abstract class Tag extends _i1.TableRow {
  Tag._({
    int? id,
    required this.type,
    this.users,
  }) : super(id);

  factory Tag({
    int? id,
    required _i2.TagType type,
    List<_i2.UserTag>? users,
  }) = _TagImpl;

  factory Tag.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return Tag(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      type: serializationManager
          .deserialize<_i2.TagType>(jsonSerialization['type']),
      users: serializationManager
          .deserialize<List<_i2.UserTag>?>(jsonSerialization['users']),
    );
  }

  static final t = TagTable();

  static const db = TagRepository._();

  _i2.TagType type;

  List<_i2.UserTag>? users;

  @override
  _i1.Table get table => t;

  Tag copyWith({
    int? id,
    _i2.TagType? type,
    List<_i2.UserTag>? users,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'type': type.toJson(),
      if (users != null) 'users': users?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  @Deprecated('Will be removed in 2.0.0')
  Map<String, dynamic> toJsonForDatabase() {
    return {
      'id': id,
      'type': type,
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      if (id != null) 'id': id,
      'type': type.toJson(),
      if (users != null)
        'users': users?.toJson(valueToJson: (v) => v.allToJson()),
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
      case 'type':
        type = value;
        return;
      default:
        throw UnimplementedError();
    }
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.find instead.')
  static Future<List<Tag>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TagTable>? where,
    int? limit,
    int? offset,
    _i1.Column? orderBy,
    List<_i1.Order>? orderByList,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
    TagInclude? include,
  }) async {
    return session.db.find<Tag>(
      where: where != null ? where(Tag.t) : null,
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
  static Future<Tag?> findSingleRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TagTable>? where,
    int? offset,
    _i1.Column? orderBy,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
    TagInclude? include,
  }) async {
    return session.db.findSingleRow<Tag>(
      where: where != null ? where(Tag.t) : null,
      offset: offset,
      orderBy: orderBy,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
      include: include,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.findById instead.')
  static Future<Tag?> findById(
    _i1.Session session,
    int id, {
    TagInclude? include,
  }) async {
    return session.db.findById<Tag>(
      id,
      include: include,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.deleteWhere instead.')
  static Future<int> delete(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<TagTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Tag>(
      where: where(Tag.t),
      transaction: transaction,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.deleteRow instead.')
  static Future<bool> deleteRow(
    _i1.Session session,
    Tag row, {
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
    Tag row, {
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
    Tag row, {
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
    _i1.WhereExpressionBuilder<TagTable>? where,
    int? limit,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Tag>(
      where: where != null ? where(Tag.t) : null,
      limit: limit,
      useCache: useCache,
      transaction: transaction,
    );
  }

  static TagInclude include({_i2.UserTagIncludeList? users}) {
    return TagInclude._(users: users);
  }

  static TagIncludeList includeList({
    _i1.WhereExpressionBuilder<TagTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TagTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TagTable>? orderByList,
    TagInclude? include,
  }) {
    return TagIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Tag.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Tag.t),
      include: include,
    );
  }
}

class _Undefined {}

class _TagImpl extends Tag {
  _TagImpl({
    int? id,
    required _i2.TagType type,
    List<_i2.UserTag>? users,
  }) : super._(
          id: id,
          type: type,
          users: users,
        );

  @override
  Tag copyWith({
    Object? id = _Undefined,
    _i2.TagType? type,
    Object? users = _Undefined,
  }) {
    return Tag(
      id: id is int? ? id : this.id,
      type: type ?? this.type,
      users: users is List<_i2.UserTag>? ? users : this.users?.clone(),
    );
  }
}

class TagTable extends _i1.Table {
  TagTable({super.tableRelation}) : super(tableName: 'tag') {
    type = _i1.ColumnEnum(
      'type',
      this,
      _i1.EnumSerialization.byName,
    );
  }

  late final _i1.ColumnEnum<_i2.TagType> type;

  _i2.UserTagTable? ___users;

  _i1.ManyRelation<_i2.UserTagTable>? _users;

  _i2.UserTagTable get __users {
    if (___users != null) return ___users!;
    ___users = _i1.createRelationTable(
      relationFieldName: '__users',
      field: Tag.t.id,
      foreignField: _i2.UserTag.t.tagId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.UserTagTable(tableRelation: foreignTableRelation),
    );
    return ___users!;
  }

  _i1.ManyRelation<_i2.UserTagTable> get users {
    if (_users != null) return _users!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'users',
      field: Tag.t.id,
      foreignField: _i2.UserTag.t.tagId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.UserTagTable(tableRelation: foreignTableRelation),
    );
    _users = _i1.ManyRelation<_i2.UserTagTable>(
      tableWithRelations: relationTable,
      table: _i2.UserTagTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _users!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        type,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'users') {
      return __users;
    }
    return null;
  }
}

@Deprecated('Use TagTable.t instead.')
TagTable tTag = TagTable();

class TagInclude extends _i1.IncludeObject {
  TagInclude._({_i2.UserTagIncludeList? users}) {
    _users = users;
  }

  _i2.UserTagIncludeList? _users;

  @override
  Map<String, _i1.Include?> get includes => {'users': _users};

  @override
  _i1.Table get table => Tag.t;
}

class TagIncludeList extends _i1.IncludeList {
  TagIncludeList._({
    _i1.WhereExpressionBuilder<TagTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Tag.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => Tag.t;
}

class TagRepository {
  const TagRepository._();

  final attach = const TagAttachRepository._();

  final attachRow = const TagAttachRowRepository._();

  final detach = const TagDetachRepository._();

  final detachRow = const TagDetachRowRepository._();

  Future<List<Tag>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TagTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TagTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TagTable>? orderByList,
    _i1.Transaction? transaction,
    TagInclude? include,
  }) async {
    return session.dbNext.find<Tag>(
      where: where?.call(Tag.t),
      orderBy: orderBy?.call(Tag.t),
      orderByList: orderByList?.call(Tag.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  Future<Tag?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TagTable>? where,
    int? offset,
    _i1.OrderByBuilder<TagTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TagTable>? orderByList,
    _i1.Transaction? transaction,
    TagInclude? include,
  }) async {
    return session.dbNext.findFirstRow<Tag>(
      where: where?.call(Tag.t),
      orderBy: orderBy?.call(Tag.t),
      orderByList: orderByList?.call(Tag.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  Future<Tag?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    TagInclude? include,
  }) async {
    return session.dbNext.findById<Tag>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  Future<List<Tag>> insert(
    _i1.Session session,
    List<Tag> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.insert<Tag>(
      rows,
      transaction: transaction,
    );
  }

  Future<Tag> insertRow(
    _i1.Session session,
    Tag row, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.insertRow<Tag>(
      row,
      transaction: transaction,
    );
  }

  Future<List<Tag>> update(
    _i1.Session session,
    List<Tag> rows, {
    _i1.ColumnSelections<TagTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.update<Tag>(
      rows,
      columns: columns?.call(Tag.t),
      transaction: transaction,
    );
  }

  Future<Tag> updateRow(
    _i1.Session session,
    Tag row, {
    _i1.ColumnSelections<TagTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.updateRow<Tag>(
      row,
      columns: columns?.call(Tag.t),
      transaction: transaction,
    );
  }

  Future<List<int>> delete(
    _i1.Session session,
    List<Tag> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.delete<Tag>(
      rows,
      transaction: transaction,
    );
  }

  Future<int> deleteRow(
    _i1.Session session,
    Tag row, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.deleteRow<Tag>(
      row,
      transaction: transaction,
    );
  }

  Future<List<int>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<TagTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.deleteWhere<Tag>(
      where: where(Tag.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TagTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.count<Tag>(
      where: where?.call(Tag.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class TagAttachRepository {
  const TagAttachRepository._();

  Future<void> users(
    _i1.Session session,
    Tag tag,
    List<_i2.UserTag> userTag,
  ) async {
    if (userTag.any((e) => e.id == null)) {
      throw ArgumentError.notNull('userTag.id');
    }
    if (tag.id == null) {
      throw ArgumentError.notNull('tag.id');
    }

    var $userTag = userTag.map((e) => e.copyWith(tagId: tag.id)).toList();
    await session.dbNext.update<_i2.UserTag>(
      $userTag,
      columns: [_i2.UserTag.t.tagId],
    );
  }
}

class TagAttachRowRepository {
  const TagAttachRowRepository._();

  Future<void> users(
    _i1.Session session,
    Tag tag,
    _i2.UserTag userTag,
  ) async {
    if (userTag.id == null) {
      throw ArgumentError.notNull('userTag.id');
    }
    if (tag.id == null) {
      throw ArgumentError.notNull('tag.id');
    }

    var $userTag = userTag.copyWith(tagId: tag.id);
    await session.dbNext.updateRow<_i2.UserTag>(
      $userTag,
      columns: [_i2.UserTag.t.tagId],
    );
  }
}

class TagDetachRepository {
  const TagDetachRepository._();

  Future<void> users(
    _i1.Session session,
    List<_i2.UserTag> userTag,
  ) async {
    if (userTag.any((e) => e.id == null)) {
      throw ArgumentError.notNull('userTag.id');
    }

    var $userTag = userTag.map((e) => e.copyWith(tagId: null)).toList();
    await session.dbNext.update<_i2.UserTag>(
      $userTag,
      columns: [_i2.UserTag.t.tagId],
    );
  }
}

class TagDetachRowRepository {
  const TagDetachRowRepository._();

  Future<void> users(
    _i1.Session session,
    _i2.UserTag userTag,
  ) async {
    if (userTag.id == null) {
      throw ArgumentError.notNull('userTag.id');
    }

    var $userTag = userTag.copyWith(tagId: null);
    await session.dbNext.updateRow<_i2.UserTag>(
      $userTag,
      columns: [_i2.UserTag.t.tagId],
    );
  }
}
