/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import 'package:serverpod_serialization/serverpod_serialization.dart';

abstract class Passcode extends _i1.TableRow {
  Passcode._({
    int? id,
    required this.userId,
    required this.value,
    required this.created,
  }) : super(id);

  factory Passcode({
    int? id,
    required int userId,
    required String value,
    required DateTime created,
  }) = _PasscodeImpl;

  factory Passcode.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return Passcode(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      userId:
          serializationManager.deserialize<int>(jsonSerialization['userId']),
      value:
          serializationManager.deserialize<String>(jsonSerialization['value']),
      created: serializationManager
          .deserialize<DateTime>(jsonSerialization['created']),
    );
  }

  static final t = PasscodeTable();

  static const db = PasscodeRepository._();

  int userId;

  String value;

  DateTime created;

  @override
  _i1.Table get table => t;

  Passcode copyWith({
    int? id,
    int? userId,
    String? value,
    DateTime? created,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'value': value,
      'created': created.toJson(),
    };
  }

  @override
  @Deprecated('Will be removed in 2.0.0')
  Map<String, dynamic> toJsonForDatabase() {
    return {
      'id': id,
      'userId': userId,
      'value': value,
      'created': created,
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'value': value,
      'created': created.toJson(),
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
      case 'value':
        value = value;
        return;
      case 'created':
        created = value;
        return;
      default:
        throw UnimplementedError();
    }
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.find instead.')
  static Future<List<Passcode>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PasscodeTable>? where,
    int? limit,
    int? offset,
    _i1.Column? orderBy,
    List<_i1.Order>? orderByList,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Passcode>(
      where: where != null ? where(Passcode.t) : null,
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
  static Future<Passcode?> findSingleRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PasscodeTable>? where,
    int? offset,
    _i1.Column? orderBy,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findSingleRow<Passcode>(
      where: where != null ? where(Passcode.t) : null,
      offset: offset,
      orderBy: orderBy,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.findById instead.')
  static Future<Passcode?> findById(
    _i1.Session session,
    int id,
  ) async {
    return session.db.findById<Passcode>(id);
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.deleteWhere instead.')
  static Future<int> delete(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<PasscodeTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Passcode>(
      where: where(Passcode.t),
      transaction: transaction,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.deleteRow instead.')
  static Future<bool> deleteRow(
    _i1.Session session,
    Passcode row, {
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
    Passcode row, {
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
    Passcode row, {
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
    _i1.WhereExpressionBuilder<PasscodeTable>? where,
    int? limit,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Passcode>(
      where: where != null ? where(Passcode.t) : null,
      limit: limit,
      useCache: useCache,
      transaction: transaction,
    );
  }

  static PasscodeInclude include() {
    return PasscodeInclude._();
  }

  static PasscodeIncludeList includeList({
    _i1.WhereExpressionBuilder<PasscodeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PasscodeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PasscodeTable>? orderByList,
    PasscodeInclude? include,
  }) {
    return PasscodeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Passcode.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Passcode.t),
      include: include,
    );
  }
}

class _Undefined {}

class _PasscodeImpl extends Passcode {
  _PasscodeImpl({
    int? id,
    required int userId,
    required String value,
    required DateTime created,
  }) : super._(
          id: id,
          userId: userId,
          value: value,
          created: created,
        );

  @override
  Passcode copyWith({
    Object? id = _Undefined,
    int? userId,
    String? value,
    DateTime? created,
  }) {
    return Passcode(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      value: value ?? this.value,
      created: created ?? this.created,
    );
  }
}

class PasscodeTable extends _i1.Table {
  PasscodeTable({super.tableRelation}) : super(tableName: 'passcode') {
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    value = _i1.ColumnString(
      'value',
      this,
    );
    created = _i1.ColumnDateTime(
      'created',
      this,
    );
  }

  late final _i1.ColumnInt userId;

  late final _i1.ColumnString value;

  late final _i1.ColumnDateTime created;

  @override
  List<_i1.Column> get columns => [
        id,
        userId,
        value,
        created,
      ];
}

@Deprecated('Use PasscodeTable.t instead.')
PasscodeTable tPasscode = PasscodeTable();

class PasscodeInclude extends _i1.IncludeObject {
  PasscodeInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table get table => Passcode.t;
}

class PasscodeIncludeList extends _i1.IncludeList {
  PasscodeIncludeList._({
    _i1.WhereExpressionBuilder<PasscodeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Passcode.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => Passcode.t;
}

class PasscodeRepository {
  const PasscodeRepository._();

  Future<List<Passcode>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PasscodeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PasscodeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PasscodeTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.find<Passcode>(
      where: where?.call(Passcode.t),
      orderBy: orderBy?.call(Passcode.t),
      orderByList: orderByList?.call(Passcode.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<Passcode?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PasscodeTable>? where,
    int? offset,
    _i1.OrderByBuilder<PasscodeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PasscodeTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.findFirstRow<Passcode>(
      where: where?.call(Passcode.t),
      orderBy: orderBy?.call(Passcode.t),
      orderByList: orderByList?.call(Passcode.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<Passcode?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.findById<Passcode>(
      id,
      transaction: transaction,
    );
  }

  Future<List<Passcode>> insert(
    _i1.Session session,
    List<Passcode> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.insert<Passcode>(
      rows,
      transaction: transaction,
    );
  }

  Future<Passcode> insertRow(
    _i1.Session session,
    Passcode row, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.insertRow<Passcode>(
      row,
      transaction: transaction,
    );
  }

  Future<List<Passcode>> update(
    _i1.Session session,
    List<Passcode> rows, {
    _i1.ColumnSelections<PasscodeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.update<Passcode>(
      rows,
      columns: columns?.call(Passcode.t),
      transaction: transaction,
    );
  }

  Future<Passcode> updateRow(
    _i1.Session session,
    Passcode row, {
    _i1.ColumnSelections<PasscodeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.updateRow<Passcode>(
      row,
      columns: columns?.call(Passcode.t),
      transaction: transaction,
    );
  }

  Future<List<int>> delete(
    _i1.Session session,
    List<Passcode> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.delete<Passcode>(
      rows,
      transaction: transaction,
    );
  }

  Future<int> deleteRow(
    _i1.Session session,
    Passcode row, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.deleteRow<Passcode>(
      row,
      transaction: transaction,
    );
  }

  Future<List<int>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<PasscodeTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.deleteWhere<Passcode>(
      where: where(Passcode.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PasscodeTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.count<Passcode>(
      where: where?.call(Passcode.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
