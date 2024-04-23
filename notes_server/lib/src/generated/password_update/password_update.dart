/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

abstract class PasswordUpdate extends _i1.TableRow {
  PasswordUpdate._({
    int? id,
    required this.userId,
    required this.passcodeId,
  }) : super(id);

  factory PasswordUpdate({
    int? id,
    required int userId,
    required int passcodeId,
  }) = _PasswordUpdateImpl;

  factory PasswordUpdate.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return PasswordUpdate(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      userId:
          serializationManager.deserialize<int>(jsonSerialization['userId']),
      passcodeId: serializationManager
          .deserialize<int>(jsonSerialization['passcodeId']),
    );
  }

  static final t = PasswordUpdateTable();

  static const db = PasswordUpdateRepository._();

  int userId;

  int passcodeId;

  @override
  _i1.Table get table => t;

  PasswordUpdate copyWith({
    int? id,
    int? userId,
    int? passcodeId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'passcodeId': passcodeId,
    };
  }

  @override
  @Deprecated('Will be removed in 2.0.0')
  Map<String, dynamic> toJsonForDatabase() {
    return {
      'id': id,
      'userId': userId,
      'passcodeId': passcodeId,
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'passcodeId': passcodeId,
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
      case 'passcodeId':
        passcodeId = value;
        return;
      default:
        throw UnimplementedError();
    }
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.find instead.')
  static Future<List<PasswordUpdate>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PasswordUpdateTable>? where,
    int? limit,
    int? offset,
    _i1.Column? orderBy,
    List<_i1.Order>? orderByList,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<PasswordUpdate>(
      where: where != null ? where(PasswordUpdate.t) : null,
      limit: limit,
      offset: offset,
      orderBy: orderBy,
      orderByList: orderByList,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.findRow instead.')
  static Future<PasswordUpdate?> findSingleRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PasswordUpdateTable>? where,
    int? offset,
    _i1.Column? orderBy,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findSingleRow<PasswordUpdate>(
      where: where != null ? where(PasswordUpdate.t) : null,
      offset: offset,
      orderBy: orderBy,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.findById instead.')
  static Future<PasswordUpdate?> findById(
    _i1.Session session,
    int id,
  ) async {
    return session.db.findById<PasswordUpdate>(id);
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.deleteWhere instead.')
  static Future<int> delete(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<PasswordUpdateTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<PasswordUpdate>(
      where: where(PasswordUpdate.t),
      transaction: transaction,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.deleteRow instead.')
  static Future<bool> deleteRow(
    _i1.Session session,
    PasswordUpdate row, {
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
    PasswordUpdate row, {
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
    PasswordUpdate row, {
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
    _i1.WhereExpressionBuilder<PasswordUpdateTable>? where,
    int? limit,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<PasswordUpdate>(
      where: where != null ? where(PasswordUpdate.t) : null,
      limit: limit,
      useCache: useCache,
      transaction: transaction,
    );
  }

  static PasswordUpdateInclude include() {
    return PasswordUpdateInclude._();
  }

  static PasswordUpdateIncludeList includeList({
    _i1.WhereExpressionBuilder<PasswordUpdateTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PasswordUpdateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PasswordUpdateTable>? orderByList,
    PasswordUpdateInclude? include,
  }) {
    return PasswordUpdateIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PasswordUpdate.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(PasswordUpdate.t),
      include: include,
    );
  }
}

class _Undefined {}

class _PasswordUpdateImpl extends PasswordUpdate {
  _PasswordUpdateImpl({
    int? id,
    required int userId,
    required int passcodeId,
  }) : super._(
          id: id,
          userId: userId,
          passcodeId: passcodeId,
        );

  @override
  PasswordUpdate copyWith({
    Object? id = _Undefined,
    int? userId,
    int? passcodeId,
  }) {
    return PasswordUpdate(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      passcodeId: passcodeId ?? this.passcodeId,
    );
  }
}

class PasswordUpdateTable extends _i1.Table {
  PasswordUpdateTable({super.tableRelation})
      : super(tableName: 'password_update') {
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    passcodeId = _i1.ColumnInt(
      'passcodeId',
      this,
    );
  }

  late final _i1.ColumnInt userId;

  late final _i1.ColumnInt passcodeId;

  @override
  List<_i1.Column> get columns => [
        id,
        userId,
        passcodeId,
      ];
}

@Deprecated('Use PasswordUpdateTable.t instead.')
PasswordUpdateTable tPasswordUpdate = PasswordUpdateTable();

class PasswordUpdateInclude extends _i1.IncludeObject {
  PasswordUpdateInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table get table => PasswordUpdate.t;
}

class PasswordUpdateIncludeList extends _i1.IncludeList {
  PasswordUpdateIncludeList._({
    _i1.WhereExpressionBuilder<PasswordUpdateTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PasswordUpdate.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => PasswordUpdate.t;
}

class PasswordUpdateRepository {
  const PasswordUpdateRepository._();

  Future<List<PasswordUpdate>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PasswordUpdateTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PasswordUpdateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PasswordUpdateTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.find<PasswordUpdate>(
      where: where?.call(PasswordUpdate.t),
      orderBy: orderBy?.call(PasswordUpdate.t),
      orderByList: orderByList?.call(PasswordUpdate.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<PasswordUpdate?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PasswordUpdateTable>? where,
    int? offset,
    _i1.OrderByBuilder<PasswordUpdateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PasswordUpdateTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.findFirstRow<PasswordUpdate>(
      where: where?.call(PasswordUpdate.t),
      orderBy: orderBy?.call(PasswordUpdate.t),
      orderByList: orderByList?.call(PasswordUpdate.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<PasswordUpdate?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.findById<PasswordUpdate>(
      id,
      transaction: transaction,
    );
  }

  Future<List<PasswordUpdate>> insert(
    _i1.Session session,
    List<PasswordUpdate> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.insert<PasswordUpdate>(
      rows,
      transaction: transaction,
    );
  }

  Future<PasswordUpdate> insertRow(
    _i1.Session session,
    PasswordUpdate row, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.insertRow<PasswordUpdate>(
      row,
      transaction: transaction,
    );
  }

  Future<List<PasswordUpdate>> update(
    _i1.Session session,
    List<PasswordUpdate> rows, {
    _i1.ColumnSelections<PasswordUpdateTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.update<PasswordUpdate>(
      rows,
      columns: columns?.call(PasswordUpdate.t),
      transaction: transaction,
    );
  }

  Future<PasswordUpdate> updateRow(
    _i1.Session session,
    PasswordUpdate row, {
    _i1.ColumnSelections<PasswordUpdateTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.updateRow<PasswordUpdate>(
      row,
      columns: columns?.call(PasswordUpdate.t),
      transaction: transaction,
    );
  }

  Future<List<int>> delete(
    _i1.Session session,
    List<PasswordUpdate> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.delete<PasswordUpdate>(
      rows,
      transaction: transaction,
    );
  }

  Future<int> deleteRow(
    _i1.Session session,
    PasswordUpdate row, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.deleteRow<PasswordUpdate>(
      row,
      transaction: transaction,
    );
  }

  Future<List<int>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<PasswordUpdateTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.deleteWhere<PasswordUpdate>(
      where: where(PasswordUpdate.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PasswordUpdateTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.count<PasswordUpdate>(
      where: where?.call(PasswordUpdate.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
