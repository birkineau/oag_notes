/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

abstract class FcmToken extends _i1.TableRow {
  FcmToken._({
    int? id,
    required this.userId,
    required this.token,
  }) : super(id);

  factory FcmToken({
    int? id,
    required int userId,
    required String token,
  }) = _FcmTokenImpl;

  factory FcmToken.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return FcmToken(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      userId:
          serializationManager.deserialize<int>(jsonSerialization['userId']),
      token:
          serializationManager.deserialize<String>(jsonSerialization['token']),
    );
  }

  static final t = FcmTokenTable();

  static const db = FcmTokenRepository._();

  int userId;

  String token;

  @override
  _i1.Table get table => t;

  FcmToken copyWith({
    int? id,
    int? userId,
    String? token,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'token': token,
    };
  }

  @override
  @Deprecated('Will be removed in 2.0.0')
  Map<String, dynamic> toJsonForDatabase() {
    return {
      'id': id,
      'userId': userId,
      'token': token,
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'token': token,
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
      case 'token':
        token = value;
        return;
      default:
        throw UnimplementedError();
    }
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.find instead.')
  static Future<List<FcmToken>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FcmTokenTable>? where,
    int? limit,
    int? offset,
    _i1.Column? orderBy,
    List<_i1.Order>? orderByList,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<FcmToken>(
      where: where != null ? where(FcmToken.t) : null,
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
  static Future<FcmToken?> findSingleRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FcmTokenTable>? where,
    int? offset,
    _i1.Column? orderBy,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findSingleRow<FcmToken>(
      where: where != null ? where(FcmToken.t) : null,
      offset: offset,
      orderBy: orderBy,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.findById instead.')
  static Future<FcmToken?> findById(
    _i1.Session session,
    int id,
  ) async {
    return session.db.findById<FcmToken>(id);
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.deleteWhere instead.')
  static Future<int> delete(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<FcmTokenTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<FcmToken>(
      where: where(FcmToken.t),
      transaction: transaction,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.deleteRow instead.')
  static Future<bool> deleteRow(
    _i1.Session session,
    FcmToken row, {
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
    FcmToken row, {
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
    FcmToken row, {
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
    _i1.WhereExpressionBuilder<FcmTokenTable>? where,
    int? limit,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<FcmToken>(
      where: where != null ? where(FcmToken.t) : null,
      limit: limit,
      useCache: useCache,
      transaction: transaction,
    );
  }

  static FcmTokenInclude include() {
    return FcmTokenInclude._();
  }

  static FcmTokenIncludeList includeList({
    _i1.WhereExpressionBuilder<FcmTokenTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FcmTokenTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FcmTokenTable>? orderByList,
    FcmTokenInclude? include,
  }) {
    return FcmTokenIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FcmToken.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(FcmToken.t),
      include: include,
    );
  }
}

class _Undefined {}

class _FcmTokenImpl extends FcmToken {
  _FcmTokenImpl({
    int? id,
    required int userId,
    required String token,
  }) : super._(
          id: id,
          userId: userId,
          token: token,
        );

  @override
  FcmToken copyWith({
    Object? id = _Undefined,
    int? userId,
    String? token,
  }) {
    return FcmToken(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      token: token ?? this.token,
    );
  }
}

class FcmTokenTable extends _i1.Table {
  FcmTokenTable({super.tableRelation}) : super(tableName: 'fcm_token') {
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    token = _i1.ColumnString(
      'token',
      this,
    );
  }

  late final _i1.ColumnInt userId;

  late final _i1.ColumnString token;

  @override
  List<_i1.Column> get columns => [
        id,
        userId,
        token,
      ];
}

@Deprecated('Use FcmTokenTable.t instead.')
FcmTokenTable tFcmToken = FcmTokenTable();

class FcmTokenInclude extends _i1.IncludeObject {
  FcmTokenInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table get table => FcmToken.t;
}

class FcmTokenIncludeList extends _i1.IncludeList {
  FcmTokenIncludeList._({
    _i1.WhereExpressionBuilder<FcmTokenTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FcmToken.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => FcmToken.t;
}

class FcmTokenRepository {
  const FcmTokenRepository._();

  Future<List<FcmToken>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FcmTokenTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FcmTokenTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FcmTokenTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.find<FcmToken>(
      where: where?.call(FcmToken.t),
      orderBy: orderBy?.call(FcmToken.t),
      orderByList: orderByList?.call(FcmToken.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<FcmToken?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FcmTokenTable>? where,
    int? offset,
    _i1.OrderByBuilder<FcmTokenTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FcmTokenTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.findFirstRow<FcmToken>(
      where: where?.call(FcmToken.t),
      orderBy: orderBy?.call(FcmToken.t),
      orderByList: orderByList?.call(FcmToken.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<FcmToken?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.findById<FcmToken>(
      id,
      transaction: transaction,
    );
  }

  Future<List<FcmToken>> insert(
    _i1.Session session,
    List<FcmToken> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.insert<FcmToken>(
      rows,
      transaction: transaction,
    );
  }

  Future<FcmToken> insertRow(
    _i1.Session session,
    FcmToken row, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.insertRow<FcmToken>(
      row,
      transaction: transaction,
    );
  }

  Future<List<FcmToken>> update(
    _i1.Session session,
    List<FcmToken> rows, {
    _i1.ColumnSelections<FcmTokenTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.update<FcmToken>(
      rows,
      columns: columns?.call(FcmToken.t),
      transaction: transaction,
    );
  }

  Future<FcmToken> updateRow(
    _i1.Session session,
    FcmToken row, {
    _i1.ColumnSelections<FcmTokenTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.updateRow<FcmToken>(
      row,
      columns: columns?.call(FcmToken.t),
      transaction: transaction,
    );
  }

  Future<List<int>> delete(
    _i1.Session session,
    List<FcmToken> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.delete<FcmToken>(
      rows,
      transaction: transaction,
    );
  }

  Future<int> deleteRow(
    _i1.Session session,
    FcmToken row, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.deleteRow<FcmToken>(
      row,
      transaction: transaction,
    );
  }

  Future<List<int>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<FcmTokenTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.deleteWhere<FcmToken>(
      where: where(FcmToken.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FcmTokenTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.count<FcmToken>(
      where: where?.call(FcmToken.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
