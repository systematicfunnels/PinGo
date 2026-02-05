// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $SavedMapsTable extends SavedMaps
    with TableInfo<$SavedMapsTable, SavedMap> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SavedMapsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _isSyncedMeta =
      const VerificationMeta('isSynced');
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
      'is_synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _visibilityMeta =
      const VerificationMeta('visibility');
  @override
  late final GeneratedColumn<int> visibility = GeneratedColumn<int>(
      'visibility', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _sourceUrlMeta =
      const VerificationMeta('sourceUrl');
  @override
  late final GeneratedColumn<String> sourceUrl = GeneratedColumn<String>(
      'source_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _authorNameMeta =
      const VerificationMeta('authorName');
  @override
  late final GeneratedColumn<String> authorName = GeneratedColumn<String>(
      'author_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        description,
        createdAt,
        isSynced,
        visibility,
        sourceUrl,
        authorName
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'saved_maps';
  @override
  VerificationContext validateIntegrity(Insertable<SavedMap> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('is_synced')) {
      context.handle(_isSyncedMeta,
          isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta));
    }
    if (data.containsKey('visibility')) {
      context.handle(
          _visibilityMeta,
          visibility.isAcceptableOrUnknown(
              data['visibility']!, _visibilityMeta));
    }
    if (data.containsKey('source_url')) {
      context.handle(_sourceUrlMeta,
          sourceUrl.isAcceptableOrUnknown(data['source_url']!, _sourceUrlMeta));
    }
    if (data.containsKey('author_name')) {
      context.handle(
          _authorNameMeta,
          authorName.isAcceptableOrUnknown(
              data['author_name']!, _authorNameMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SavedMap map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SavedMap(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      isSynced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_synced'])!,
      visibility: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}visibility'])!,
      sourceUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source_url']),
      authorName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}author_name']),
    );
  }

  @override
  $SavedMapsTable createAlias(String alias) {
    return $SavedMapsTable(attachedDatabase, alias);
  }
}

class SavedMap extends DataClass implements Insertable<SavedMap> {
  final int id;
  final String name;
  final String? description;
  final DateTime createdAt;
  final bool isSynced;
  final int visibility;
  final String? sourceUrl;
  final String? authorName;
  const SavedMap(
      {required this.id,
      required this.name,
      this.description,
      required this.createdAt,
      required this.isSynced,
      required this.visibility,
      this.sourceUrl,
      this.authorName});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['is_synced'] = Variable<bool>(isSynced);
    map['visibility'] = Variable<int>(visibility);
    if (!nullToAbsent || sourceUrl != null) {
      map['source_url'] = Variable<String>(sourceUrl);
    }
    if (!nullToAbsent || authorName != null) {
      map['author_name'] = Variable<String>(authorName);
    }
    return map;
  }

  SavedMapsCompanion toCompanion(bool nullToAbsent) {
    return SavedMapsCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      createdAt: Value(createdAt),
      isSynced: Value(isSynced),
      visibility: Value(visibility),
      sourceUrl: sourceUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceUrl),
      authorName: authorName == null && nullToAbsent
          ? const Value.absent()
          : Value(authorName),
    );
  }

  factory SavedMap.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SavedMap(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      visibility: serializer.fromJson<int>(json['visibility']),
      sourceUrl: serializer.fromJson<String?>(json['sourceUrl']),
      authorName: serializer.fromJson<String?>(json['authorName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'isSynced': serializer.toJson<bool>(isSynced),
      'visibility': serializer.toJson<int>(visibility),
      'sourceUrl': serializer.toJson<String?>(sourceUrl),
      'authorName': serializer.toJson<String?>(authorName),
    };
  }

  SavedMap copyWith(
          {int? id,
          String? name,
          Value<String?> description = const Value.absent(),
          DateTime? createdAt,
          bool? isSynced,
          int? visibility,
          Value<String?> sourceUrl = const Value.absent(),
          Value<String?> authorName = const Value.absent()}) =>
      SavedMap(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        createdAt: createdAt ?? this.createdAt,
        isSynced: isSynced ?? this.isSynced,
        visibility: visibility ?? this.visibility,
        sourceUrl: sourceUrl.present ? sourceUrl.value : this.sourceUrl,
        authorName: authorName.present ? authorName.value : this.authorName,
      );
  SavedMap copyWithCompanion(SavedMapsCompanion data) {
    return SavedMap(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      visibility:
          data.visibility.present ? data.visibility.value : this.visibility,
      sourceUrl: data.sourceUrl.present ? data.sourceUrl.value : this.sourceUrl,
      authorName:
          data.authorName.present ? data.authorName.value : this.authorName,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SavedMap(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('visibility: $visibility, ')
          ..write('sourceUrl: $sourceUrl, ')
          ..write('authorName: $authorName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, createdAt, isSynced,
      visibility, sourceUrl, authorName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SavedMap &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.createdAt == this.createdAt &&
          other.isSynced == this.isSynced &&
          other.visibility == this.visibility &&
          other.sourceUrl == this.sourceUrl &&
          other.authorName == this.authorName);
}

class SavedMapsCompanion extends UpdateCompanion<SavedMap> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<DateTime> createdAt;
  final Value<bool> isSynced;
  final Value<int> visibility;
  final Value<String?> sourceUrl;
  final Value<String?> authorName;
  const SavedMapsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.visibility = const Value.absent(),
    this.sourceUrl = const Value.absent(),
    this.authorName = const Value.absent(),
  });
  SavedMapsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.visibility = const Value.absent(),
    this.sourceUrl = const Value.absent(),
    this.authorName = const Value.absent(),
  }) : name = Value(name);
  static Insertable<SavedMap> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<DateTime>? createdAt,
    Expression<bool>? isSynced,
    Expression<int>? visibility,
    Expression<String>? sourceUrl,
    Expression<String>? authorName,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (createdAt != null) 'created_at': createdAt,
      if (isSynced != null) 'is_synced': isSynced,
      if (visibility != null) 'visibility': visibility,
      if (sourceUrl != null) 'source_url': sourceUrl,
      if (authorName != null) 'author_name': authorName,
    });
  }

  SavedMapsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? description,
      Value<DateTime>? createdAt,
      Value<bool>? isSynced,
      Value<int>? visibility,
      Value<String?>? sourceUrl,
      Value<String?>? authorName}) {
    return SavedMapsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      isSynced: isSynced ?? this.isSynced,
      visibility: visibility ?? this.visibility,
      sourceUrl: sourceUrl ?? this.sourceUrl,
      authorName: authorName ?? this.authorName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (visibility.present) {
      map['visibility'] = Variable<int>(visibility.value);
    }
    if (sourceUrl.present) {
      map['source_url'] = Variable<String>(sourceUrl.value);
    }
    if (authorName.present) {
      map['author_name'] = Variable<String>(authorName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SavedMapsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('visibility: $visibility, ')
          ..write('sourceUrl: $sourceUrl, ')
          ..write('authorName: $authorName')
          ..write(')'))
        .toString();
  }
}

class $TroupesTable extends Troupes with TableInfo<$TroupesTable, Troupe> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TroupesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
      'start_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _endDateMeta =
      const VerificationMeta('endDate');
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
      'end_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _isSyncedMeta =
      const VerificationMeta('isSynced');
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
      'is_synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _visibilityMeta =
      const VerificationMeta('visibility');
  @override
  late final GeneratedColumn<int> visibility = GeneratedColumn<int>(
      'visibility', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        description,
        startDate,
        endDate,
        createdAt,
        isSynced,
        visibility
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'troupes';
  @override
  VerificationContext validateIntegrity(Insertable<Troupe> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(_endDateMeta,
          endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('is_synced')) {
      context.handle(_isSyncedMeta,
          isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta));
    }
    if (data.containsKey('visibility')) {
      context.handle(
          _visibilityMeta,
          visibility.isAcceptableOrUnknown(
              data['visibility']!, _visibilityMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Troupe map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Troupe(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_date'])!,
      endDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_date']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      isSynced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_synced'])!,
      visibility: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}visibility'])!,
    );
  }

  @override
  $TroupesTable createAlias(String alias) {
    return $TroupesTable(attachedDatabase, alias);
  }
}

class Troupe extends DataClass implements Insertable<Troupe> {
  final int id;
  final String name;
  final String? description;
  final DateTime startDate;
  final DateTime? endDate;
  final DateTime createdAt;
  final bool isSynced;
  final int visibility;
  const Troupe(
      {required this.id,
      required this.name,
      this.description,
      required this.startDate,
      this.endDate,
      required this.createdAt,
      required this.isSynced,
      required this.visibility});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['start_date'] = Variable<DateTime>(startDate);
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<DateTime>(endDate);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['is_synced'] = Variable<bool>(isSynced);
    map['visibility'] = Variable<int>(visibility);
    return map;
  }

  TroupesCompanion toCompanion(bool nullToAbsent) {
    return TroupesCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      startDate: Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      createdAt: Value(createdAt),
      isSynced: Value(isSynced),
      visibility: Value(visibility),
    );
  }

  factory Troupe.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Troupe(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime?>(json['endDate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      visibility: serializer.fromJson<int>(json['visibility']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime?>(endDate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'isSynced': serializer.toJson<bool>(isSynced),
      'visibility': serializer.toJson<int>(visibility),
    };
  }

  Troupe copyWith(
          {int? id,
          String? name,
          Value<String?> description = const Value.absent(),
          DateTime? startDate,
          Value<DateTime?> endDate = const Value.absent(),
          DateTime? createdAt,
          bool? isSynced,
          int? visibility}) =>
      Troupe(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        startDate: startDate ?? this.startDate,
        endDate: endDate.present ? endDate.value : this.endDate,
        createdAt: createdAt ?? this.createdAt,
        isSynced: isSynced ?? this.isSynced,
        visibility: visibility ?? this.visibility,
      );
  Troupe copyWithCompanion(TroupesCompanion data) {
    return Troupe(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      visibility:
          data.visibility.present ? data.visibility.value : this.visibility,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Troupe(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('visibility: $visibility')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, startDate, endDate,
      createdAt, isSynced, visibility);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Troupe &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.createdAt == this.createdAt &&
          other.isSynced == this.isSynced &&
          other.visibility == this.visibility);
}

class TroupesCompanion extends UpdateCompanion<Troupe> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<DateTime> startDate;
  final Value<DateTime?> endDate;
  final Value<DateTime> createdAt;
  final Value<bool> isSynced;
  final Value<int> visibility;
  const TroupesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.visibility = const Value.absent(),
  });
  TroupesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    required DateTime startDate,
    this.endDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.visibility = const Value.absent(),
  })  : name = Value(name),
        startDate = Value(startDate);
  static Insertable<Troupe> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<DateTime>? createdAt,
    Expression<bool>? isSynced,
    Expression<int>? visibility,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (createdAt != null) 'created_at': createdAt,
      if (isSynced != null) 'is_synced': isSynced,
      if (visibility != null) 'visibility': visibility,
    });
  }

  TroupesCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? description,
      Value<DateTime>? startDate,
      Value<DateTime?>? endDate,
      Value<DateTime>? createdAt,
      Value<bool>? isSynced,
      Value<int>? visibility}) {
    return TroupesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      createdAt: createdAt ?? this.createdAt,
      isSynced: isSynced ?? this.isSynced,
      visibility: visibility ?? this.visibility,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (visibility.present) {
      map['visibility'] = Variable<int>(visibility.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TroupesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('visibility: $visibility')
          ..write(')'))
        .toString();
  }
}

class $JourneysTable extends Journeys with TableInfo<$JourneysTable, Journey> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JourneysTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _startTimeMeta =
      const VerificationMeta('startTime');
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
      'start_time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _endTimeMeta =
      const VerificationMeta('endTime');
  @override
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
      'end_time', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _routeDataMeta =
      const VerificationMeta('routeData');
  @override
  late final GeneratedColumn<String> routeData = GeneratedColumn<String>(
      'route_data', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _totalDistanceMeta =
      const VerificationMeta('totalDistance');
  @override
  late final GeneratedColumn<double> totalDistance = GeneratedColumn<double>(
      'total_distance', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _durationSecondsMeta =
      const VerificationMeta('durationSeconds');
  @override
  late final GeneratedColumn<int> durationSeconds = GeneratedColumn<int>(
      'duration_seconds', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _isSyncedMeta =
      const VerificationMeta('isSynced');
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
      'is_synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _visibilityMeta =
      const VerificationMeta('visibility');
  @override
  late final GeneratedColumn<int> visibility = GeneratedColumn<int>(
      'visibility', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        description,
        startTime,
        endTime,
        routeData,
        totalDistance,
        durationSeconds,
        isSynced,
        visibility
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'journeys';
  @override
  VerificationContext validateIntegrity(Insertable<Journey> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('start_time')) {
      context.handle(_startTimeMeta,
          startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta));
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(_endTimeMeta,
          endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta));
    }
    if (data.containsKey('route_data')) {
      context.handle(_routeDataMeta,
          routeData.isAcceptableOrUnknown(data['route_data']!, _routeDataMeta));
    }
    if (data.containsKey('total_distance')) {
      context.handle(
          _totalDistanceMeta,
          totalDistance.isAcceptableOrUnknown(
              data['total_distance']!, _totalDistanceMeta));
    }
    if (data.containsKey('duration_seconds')) {
      context.handle(
          _durationSecondsMeta,
          durationSeconds.isAcceptableOrUnknown(
              data['duration_seconds']!, _durationSecondsMeta));
    }
    if (data.containsKey('is_synced')) {
      context.handle(_isSyncedMeta,
          isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta));
    }
    if (data.containsKey('visibility')) {
      context.handle(
          _visibilityMeta,
          visibility.isAcceptableOrUnknown(
              data['visibility']!, _visibilityMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Journey map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Journey(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      startTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_time'])!,
      endTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_time']),
      routeData: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}route_data']),
      totalDistance: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total_distance'])!,
      durationSeconds: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration_seconds'])!,
      isSynced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_synced'])!,
      visibility: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}visibility'])!,
    );
  }

  @override
  $JourneysTable createAlias(String alias) {
    return $JourneysTable(attachedDatabase, alias);
  }
}

class Journey extends DataClass implements Insertable<Journey> {
  final int id;
  final String? name;
  final String? description;
  final DateTime startTime;
  final DateTime? endTime;
  final String? routeData;
  final double totalDistance;
  final int durationSeconds;
  final bool isSynced;
  final int visibility;
  const Journey(
      {required this.id,
      this.name,
      this.description,
      required this.startTime,
      this.endTime,
      this.routeData,
      required this.totalDistance,
      required this.durationSeconds,
      required this.isSynced,
      required this.visibility});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['start_time'] = Variable<DateTime>(startTime);
    if (!nullToAbsent || endTime != null) {
      map['end_time'] = Variable<DateTime>(endTime);
    }
    if (!nullToAbsent || routeData != null) {
      map['route_data'] = Variable<String>(routeData);
    }
    map['total_distance'] = Variable<double>(totalDistance);
    map['duration_seconds'] = Variable<int>(durationSeconds);
    map['is_synced'] = Variable<bool>(isSynced);
    map['visibility'] = Variable<int>(visibility);
    return map;
  }

  JourneysCompanion toCompanion(bool nullToAbsent) {
    return JourneysCompanion(
      id: Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      startTime: Value(startTime),
      endTime: endTime == null && nullToAbsent
          ? const Value.absent()
          : Value(endTime),
      routeData: routeData == null && nullToAbsent
          ? const Value.absent()
          : Value(routeData),
      totalDistance: Value(totalDistance),
      durationSeconds: Value(durationSeconds),
      isSynced: Value(isSynced),
      visibility: Value(visibility),
    );
  }

  factory Journey.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Journey(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      startTime: serializer.fromJson<DateTime>(json['startTime']),
      endTime: serializer.fromJson<DateTime?>(json['endTime']),
      routeData: serializer.fromJson<String?>(json['routeData']),
      totalDistance: serializer.fromJson<double>(json['totalDistance']),
      durationSeconds: serializer.fromJson<int>(json['durationSeconds']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      visibility: serializer.fromJson<int>(json['visibility']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String?>(name),
      'description': serializer.toJson<String?>(description),
      'startTime': serializer.toJson<DateTime>(startTime),
      'endTime': serializer.toJson<DateTime?>(endTime),
      'routeData': serializer.toJson<String?>(routeData),
      'totalDistance': serializer.toJson<double>(totalDistance),
      'durationSeconds': serializer.toJson<int>(durationSeconds),
      'isSynced': serializer.toJson<bool>(isSynced),
      'visibility': serializer.toJson<int>(visibility),
    };
  }

  Journey copyWith(
          {int? id,
          Value<String?> name = const Value.absent(),
          Value<String?> description = const Value.absent(),
          DateTime? startTime,
          Value<DateTime?> endTime = const Value.absent(),
          Value<String?> routeData = const Value.absent(),
          double? totalDistance,
          int? durationSeconds,
          bool? isSynced,
          int? visibility}) =>
      Journey(
        id: id ?? this.id,
        name: name.present ? name.value : this.name,
        description: description.present ? description.value : this.description,
        startTime: startTime ?? this.startTime,
        endTime: endTime.present ? endTime.value : this.endTime,
        routeData: routeData.present ? routeData.value : this.routeData,
        totalDistance: totalDistance ?? this.totalDistance,
        durationSeconds: durationSeconds ?? this.durationSeconds,
        isSynced: isSynced ?? this.isSynced,
        visibility: visibility ?? this.visibility,
      );
  Journey copyWithCompanion(JourneysCompanion data) {
    return Journey(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      routeData: data.routeData.present ? data.routeData.value : this.routeData,
      totalDistance: data.totalDistance.present
          ? data.totalDistance.value
          : this.totalDistance,
      durationSeconds: data.durationSeconds.present
          ? data.durationSeconds.value
          : this.durationSeconds,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      visibility:
          data.visibility.present ? data.visibility.value : this.visibility,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Journey(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('routeData: $routeData, ')
          ..write('totalDistance: $totalDistance, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('isSynced: $isSynced, ')
          ..write('visibility: $visibility')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, startTime, endTime,
      routeData, totalDistance, durationSeconds, isSynced, visibility);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Journey &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.routeData == this.routeData &&
          other.totalDistance == this.totalDistance &&
          other.durationSeconds == this.durationSeconds &&
          other.isSynced == this.isSynced &&
          other.visibility == this.visibility);
}

class JourneysCompanion extends UpdateCompanion<Journey> {
  final Value<int> id;
  final Value<String?> name;
  final Value<String?> description;
  final Value<DateTime> startTime;
  final Value<DateTime?> endTime;
  final Value<String?> routeData;
  final Value<double> totalDistance;
  final Value<int> durationSeconds;
  final Value<bool> isSynced;
  final Value<int> visibility;
  const JourneysCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.routeData = const Value.absent(),
    this.totalDistance = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.visibility = const Value.absent(),
  });
  JourneysCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    required DateTime startTime,
    this.endTime = const Value.absent(),
    this.routeData = const Value.absent(),
    this.totalDistance = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.visibility = const Value.absent(),
  }) : startTime = Value(startTime);
  static Insertable<Journey> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
    Expression<String>? routeData,
    Expression<double>? totalDistance,
    Expression<int>? durationSeconds,
    Expression<bool>? isSynced,
    Expression<int>? visibility,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (routeData != null) 'route_data': routeData,
      if (totalDistance != null) 'total_distance': totalDistance,
      if (durationSeconds != null) 'duration_seconds': durationSeconds,
      if (isSynced != null) 'is_synced': isSynced,
      if (visibility != null) 'visibility': visibility,
    });
  }

  JourneysCompanion copyWith(
      {Value<int>? id,
      Value<String?>? name,
      Value<String?>? description,
      Value<DateTime>? startTime,
      Value<DateTime?>? endTime,
      Value<String?>? routeData,
      Value<double>? totalDistance,
      Value<int>? durationSeconds,
      Value<bool>? isSynced,
      Value<int>? visibility}) {
    return JourneysCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      routeData: routeData ?? this.routeData,
      totalDistance: totalDistance ?? this.totalDistance,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      isSynced: isSynced ?? this.isSynced,
      visibility: visibility ?? this.visibility,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<DateTime>(endTime.value);
    }
    if (routeData.present) {
      map['route_data'] = Variable<String>(routeData.value);
    }
    if (totalDistance.present) {
      map['total_distance'] = Variable<double>(totalDistance.value);
    }
    if (durationSeconds.present) {
      map['duration_seconds'] = Variable<int>(durationSeconds.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (visibility.present) {
      map['visibility'] = Variable<int>(visibility.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JourneysCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('routeData: $routeData, ')
          ..write('totalDistance: $totalDistance, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('isSynced: $isSynced, ')
          ..write('visibility: $visibility')
          ..write(')'))
        .toString();
  }
}

class $PinsTable extends Pins with TableInfo<$PinsTable, Pin> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PinsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _latitudeMeta =
      const VerificationMeta('latitude');
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
      'latitude', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _longitudeMeta =
      const VerificationMeta('longitude');
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
      'longitude', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _isSyncedMeta =
      const VerificationMeta('isSynced');
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
      'is_synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _visibilityMeta =
      const VerificationMeta('visibility');
  @override
  late final GeneratedColumn<int> visibility = GeneratedColumn<int>(
      'visibility', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<int> type = GeneratedColumn<int>(
      'type', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _mapIdMeta = const VerificationMeta('mapId');
  @override
  late final GeneratedColumn<int> mapId = GeneratedColumn<int>(
      'map_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES saved_maps (id)'));
  static const VerificationMeta _troupeIdMeta =
      const VerificationMeta('troupeId');
  @override
  late final GeneratedColumn<int> troupeId = GeneratedColumn<int>(
      'troupe_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES troupes (id)'));
  static const VerificationMeta _journeyIdMeta =
      const VerificationMeta('journeyId');
  @override
  late final GeneratedColumn<int> journeyId = GeneratedColumn<int>(
      'journey_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES journeys (id)'));
  static const VerificationMeta _isDraftMeta =
      const VerificationMeta('isDraft');
  @override
  late final GeneratedColumn<bool> isDraft = GeneratedColumn<bool>(
      'is_draft', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_draft" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        description,
        latitude,
        longitude,
        createdAt,
        isSynced,
        visibility,
        type,
        mapId,
        troupeId,
        journeyId,
        isDraft
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pins';
  @override
  VerificationContext validateIntegrity(Insertable<Pin> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('latitude')) {
      context.handle(_latitudeMeta,
          latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta));
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(_longitudeMeta,
          longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta));
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('is_synced')) {
      context.handle(_isSyncedMeta,
          isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta));
    }
    if (data.containsKey('visibility')) {
      context.handle(
          _visibilityMeta,
          visibility.isAcceptableOrUnknown(
              data['visibility']!, _visibilityMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    }
    if (data.containsKey('map_id')) {
      context.handle(
          _mapIdMeta, mapId.isAcceptableOrUnknown(data['map_id']!, _mapIdMeta));
    }
    if (data.containsKey('troupe_id')) {
      context.handle(_troupeIdMeta,
          troupeId.isAcceptableOrUnknown(data['troupe_id']!, _troupeIdMeta));
    }
    if (data.containsKey('journey_id')) {
      context.handle(_journeyIdMeta,
          journeyId.isAcceptableOrUnknown(data['journey_id']!, _journeyIdMeta));
    }
    if (data.containsKey('is_draft')) {
      context.handle(_isDraftMeta,
          isDraft.isAcceptableOrUnknown(data['is_draft']!, _isDraftMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Pin map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Pin(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      latitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}latitude'])!,
      longitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}longitude'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      isSynced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_synced'])!,
      visibility: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}visibility'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type'])!,
      mapId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}map_id']),
      troupeId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}troupe_id']),
      journeyId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}journey_id']),
      isDraft: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_draft'])!,
    );
  }

  @override
  $PinsTable createAlias(String alias) {
    return $PinsTable(attachedDatabase, alias);
  }
}

class Pin extends DataClass implements Insertable<Pin> {
  final int id;
  final String? title;
  final String? description;
  final double latitude;
  final double longitude;
  final DateTime createdAt;
  final bool isSynced;
  final int visibility;
  final int type;
  final int? mapId;
  final int? troupeId;
  final int? journeyId;
  final bool isDraft;
  const Pin(
      {required this.id,
      this.title,
      this.description,
      required this.latitude,
      required this.longitude,
      required this.createdAt,
      required this.isSynced,
      required this.visibility,
      required this.type,
      this.mapId,
      this.troupeId,
      this.journeyId,
      required this.isDraft});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['latitude'] = Variable<double>(latitude);
    map['longitude'] = Variable<double>(longitude);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['is_synced'] = Variable<bool>(isSynced);
    map['visibility'] = Variable<int>(visibility);
    map['type'] = Variable<int>(type);
    if (!nullToAbsent || mapId != null) {
      map['map_id'] = Variable<int>(mapId);
    }
    if (!nullToAbsent || troupeId != null) {
      map['troupe_id'] = Variable<int>(troupeId);
    }
    if (!nullToAbsent || journeyId != null) {
      map['journey_id'] = Variable<int>(journeyId);
    }
    map['is_draft'] = Variable<bool>(isDraft);
    return map;
  }

  PinsCompanion toCompanion(bool nullToAbsent) {
    return PinsCompanion(
      id: Value(id),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      latitude: Value(latitude),
      longitude: Value(longitude),
      createdAt: Value(createdAt),
      isSynced: Value(isSynced),
      visibility: Value(visibility),
      type: Value(type),
      mapId:
          mapId == null && nullToAbsent ? const Value.absent() : Value(mapId),
      troupeId: troupeId == null && nullToAbsent
          ? const Value.absent()
          : Value(troupeId),
      journeyId: journeyId == null && nullToAbsent
          ? const Value.absent()
          : Value(journeyId),
      isDraft: Value(isDraft),
    );
  }

  factory Pin.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Pin(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String?>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      latitude: serializer.fromJson<double>(json['latitude']),
      longitude: serializer.fromJson<double>(json['longitude']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      visibility: serializer.fromJson<int>(json['visibility']),
      type: serializer.fromJson<int>(json['type']),
      mapId: serializer.fromJson<int?>(json['mapId']),
      troupeId: serializer.fromJson<int?>(json['troupeId']),
      journeyId: serializer.fromJson<int?>(json['journeyId']),
      isDraft: serializer.fromJson<bool>(json['isDraft']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String?>(title),
      'description': serializer.toJson<String?>(description),
      'latitude': serializer.toJson<double>(latitude),
      'longitude': serializer.toJson<double>(longitude),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'isSynced': serializer.toJson<bool>(isSynced),
      'visibility': serializer.toJson<int>(visibility),
      'type': serializer.toJson<int>(type),
      'mapId': serializer.toJson<int?>(mapId),
      'troupeId': serializer.toJson<int?>(troupeId),
      'journeyId': serializer.toJson<int?>(journeyId),
      'isDraft': serializer.toJson<bool>(isDraft),
    };
  }

  Pin copyWith(
          {int? id,
          Value<String?> title = const Value.absent(),
          Value<String?> description = const Value.absent(),
          double? latitude,
          double? longitude,
          DateTime? createdAt,
          bool? isSynced,
          int? visibility,
          int? type,
          Value<int?> mapId = const Value.absent(),
          Value<int?> troupeId = const Value.absent(),
          Value<int?> journeyId = const Value.absent(),
          bool? isDraft}) =>
      Pin(
        id: id ?? this.id,
        title: title.present ? title.value : this.title,
        description: description.present ? description.value : this.description,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        createdAt: createdAt ?? this.createdAt,
        isSynced: isSynced ?? this.isSynced,
        visibility: visibility ?? this.visibility,
        type: type ?? this.type,
        mapId: mapId.present ? mapId.value : this.mapId,
        troupeId: troupeId.present ? troupeId.value : this.troupeId,
        journeyId: journeyId.present ? journeyId.value : this.journeyId,
        isDraft: isDraft ?? this.isDraft,
      );
  Pin copyWithCompanion(PinsCompanion data) {
    return Pin(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      visibility:
          data.visibility.present ? data.visibility.value : this.visibility,
      type: data.type.present ? data.type.value : this.type,
      mapId: data.mapId.present ? data.mapId.value : this.mapId,
      troupeId: data.troupeId.present ? data.troupeId.value : this.troupeId,
      journeyId: data.journeyId.present ? data.journeyId.value : this.journeyId,
      isDraft: data.isDraft.present ? data.isDraft.value : this.isDraft,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Pin(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('createdAt: $createdAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('visibility: $visibility, ')
          ..write('type: $type, ')
          ..write('mapId: $mapId, ')
          ..write('troupeId: $troupeId, ')
          ..write('journeyId: $journeyId, ')
          ..write('isDraft: $isDraft')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      title,
      description,
      latitude,
      longitude,
      createdAt,
      isSynced,
      visibility,
      type,
      mapId,
      troupeId,
      journeyId,
      isDraft);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Pin &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.createdAt == this.createdAt &&
          other.isSynced == this.isSynced &&
          other.visibility == this.visibility &&
          other.type == this.type &&
          other.mapId == this.mapId &&
          other.troupeId == this.troupeId &&
          other.journeyId == this.journeyId &&
          other.isDraft == this.isDraft);
}

class PinsCompanion extends UpdateCompanion<Pin> {
  final Value<int> id;
  final Value<String?> title;
  final Value<String?> description;
  final Value<double> latitude;
  final Value<double> longitude;
  final Value<DateTime> createdAt;
  final Value<bool> isSynced;
  final Value<int> visibility;
  final Value<int> type;
  final Value<int?> mapId;
  final Value<int?> troupeId;
  final Value<int?> journeyId;
  final Value<bool> isDraft;
  const PinsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.visibility = const Value.absent(),
    this.type = const Value.absent(),
    this.mapId = const Value.absent(),
    this.troupeId = const Value.absent(),
    this.journeyId = const Value.absent(),
    this.isDraft = const Value.absent(),
  });
  PinsCompanion.insert({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    required double latitude,
    required double longitude,
    this.createdAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.visibility = const Value.absent(),
    this.type = const Value.absent(),
    this.mapId = const Value.absent(),
    this.troupeId = const Value.absent(),
    this.journeyId = const Value.absent(),
    this.isDraft = const Value.absent(),
  })  : latitude = Value(latitude),
        longitude = Value(longitude);
  static Insertable<Pin> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<DateTime>? createdAt,
    Expression<bool>? isSynced,
    Expression<int>? visibility,
    Expression<int>? type,
    Expression<int>? mapId,
    Expression<int>? troupeId,
    Expression<int>? journeyId,
    Expression<bool>? isDraft,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (createdAt != null) 'created_at': createdAt,
      if (isSynced != null) 'is_synced': isSynced,
      if (visibility != null) 'visibility': visibility,
      if (type != null) 'type': type,
      if (mapId != null) 'map_id': mapId,
      if (troupeId != null) 'troupe_id': troupeId,
      if (journeyId != null) 'journey_id': journeyId,
      if (isDraft != null) 'is_draft': isDraft,
    });
  }

  PinsCompanion copyWith(
      {Value<int>? id,
      Value<String?>? title,
      Value<String?>? description,
      Value<double>? latitude,
      Value<double>? longitude,
      Value<DateTime>? createdAt,
      Value<bool>? isSynced,
      Value<int>? visibility,
      Value<int>? type,
      Value<int?>? mapId,
      Value<int?>? troupeId,
      Value<int?>? journeyId,
      Value<bool>? isDraft}) {
    return PinsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      createdAt: createdAt ?? this.createdAt,
      isSynced: isSynced ?? this.isSynced,
      visibility: visibility ?? this.visibility,
      type: type ?? this.type,
      mapId: mapId ?? this.mapId,
      troupeId: troupeId ?? this.troupeId,
      journeyId: journeyId ?? this.journeyId,
      isDraft: isDraft ?? this.isDraft,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (visibility.present) {
      map['visibility'] = Variable<int>(visibility.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(type.value);
    }
    if (mapId.present) {
      map['map_id'] = Variable<int>(mapId.value);
    }
    if (troupeId.present) {
      map['troupe_id'] = Variable<int>(troupeId.value);
    }
    if (journeyId.present) {
      map['journey_id'] = Variable<int>(journeyId.value);
    }
    if (isDraft.present) {
      map['is_draft'] = Variable<bool>(isDraft.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PinsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('createdAt: $createdAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('visibility: $visibility, ')
          ..write('type: $type, ')
          ..write('mapId: $mapId, ')
          ..write('troupeId: $troupeId, ')
          ..write('journeyId: $journeyId, ')
          ..write('isDraft: $isDraft')
          ..write(')'))
        .toString();
  }
}

class $PinMediasTable extends PinMedias
    with TableInfo<$PinMediasTable, PinMedia> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PinMediasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _pinIdMeta = const VerificationMeta('pinId');
  @override
  late final GeneratedColumn<int> pinId = GeneratedColumn<int>(
      'pin_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES pins (id) ON DELETE CASCADE'));
  static const VerificationMeta _filePathMeta =
      const VerificationMeta('filePath');
  @override
  late final GeneratedColumn<String> filePath = GeneratedColumn<String>(
      'file_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<int> type = GeneratedColumn<int>(
      'type', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _isSyncedMeta =
      const VerificationMeta('isSynced');
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
      'is_synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, pinId, filePath, type, createdAt, isSynced];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pin_medias';
  @override
  VerificationContext validateIntegrity(Insertable<PinMedia> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('pin_id')) {
      context.handle(
          _pinIdMeta, pinId.isAcceptableOrUnknown(data['pin_id']!, _pinIdMeta));
    } else if (isInserting) {
      context.missing(_pinIdMeta);
    }
    if (data.containsKey('file_path')) {
      context.handle(_filePathMeta,
          filePath.isAcceptableOrUnknown(data['file_path']!, _filePathMeta));
    } else if (isInserting) {
      context.missing(_filePathMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('is_synced')) {
      context.handle(_isSyncedMeta,
          isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PinMedia map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PinMedia(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      pinId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}pin_id'])!,
      filePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}file_path'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      isSynced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_synced'])!,
    );
  }

  @override
  $PinMediasTable createAlias(String alias) {
    return $PinMediasTable(attachedDatabase, alias);
  }
}

class PinMedia extends DataClass implements Insertable<PinMedia> {
  final int id;
  final int pinId;
  final String filePath;
  final int type;
  final DateTime createdAt;
  final bool isSynced;
  const PinMedia(
      {required this.id,
      required this.pinId,
      required this.filePath,
      required this.type,
      required this.createdAt,
      required this.isSynced});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['pin_id'] = Variable<int>(pinId);
    map['file_path'] = Variable<String>(filePath);
    map['type'] = Variable<int>(type);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  PinMediasCompanion toCompanion(bool nullToAbsent) {
    return PinMediasCompanion(
      id: Value(id),
      pinId: Value(pinId),
      filePath: Value(filePath),
      type: Value(type),
      createdAt: Value(createdAt),
      isSynced: Value(isSynced),
    );
  }

  factory PinMedia.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PinMedia(
      id: serializer.fromJson<int>(json['id']),
      pinId: serializer.fromJson<int>(json['pinId']),
      filePath: serializer.fromJson<String>(json['filePath']),
      type: serializer.fromJson<int>(json['type']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'pinId': serializer.toJson<int>(pinId),
      'filePath': serializer.toJson<String>(filePath),
      'type': serializer.toJson<int>(type),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  PinMedia copyWith(
          {int? id,
          int? pinId,
          String? filePath,
          int? type,
          DateTime? createdAt,
          bool? isSynced}) =>
      PinMedia(
        id: id ?? this.id,
        pinId: pinId ?? this.pinId,
        filePath: filePath ?? this.filePath,
        type: type ?? this.type,
        createdAt: createdAt ?? this.createdAt,
        isSynced: isSynced ?? this.isSynced,
      );
  PinMedia copyWithCompanion(PinMediasCompanion data) {
    return PinMedia(
      id: data.id.present ? data.id.value : this.id,
      pinId: data.pinId.present ? data.pinId.value : this.pinId,
      filePath: data.filePath.present ? data.filePath.value : this.filePath,
      type: data.type.present ? data.type.value : this.type,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PinMedia(')
          ..write('id: $id, ')
          ..write('pinId: $pinId, ')
          ..write('filePath: $filePath, ')
          ..write('type: $type, ')
          ..write('createdAt: $createdAt, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, pinId, filePath, type, createdAt, isSynced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PinMedia &&
          other.id == this.id &&
          other.pinId == this.pinId &&
          other.filePath == this.filePath &&
          other.type == this.type &&
          other.createdAt == this.createdAt &&
          other.isSynced == this.isSynced);
}

class PinMediasCompanion extends UpdateCompanion<PinMedia> {
  final Value<int> id;
  final Value<int> pinId;
  final Value<String> filePath;
  final Value<int> type;
  final Value<DateTime> createdAt;
  final Value<bool> isSynced;
  const PinMediasCompanion({
    this.id = const Value.absent(),
    this.pinId = const Value.absent(),
    this.filePath = const Value.absent(),
    this.type = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isSynced = const Value.absent(),
  });
  PinMediasCompanion.insert({
    this.id = const Value.absent(),
    required int pinId,
    required String filePath,
    this.type = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isSynced = const Value.absent(),
  })  : pinId = Value(pinId),
        filePath = Value(filePath);
  static Insertable<PinMedia> custom({
    Expression<int>? id,
    Expression<int>? pinId,
    Expression<String>? filePath,
    Expression<int>? type,
    Expression<DateTime>? createdAt,
    Expression<bool>? isSynced,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (pinId != null) 'pin_id': pinId,
      if (filePath != null) 'file_path': filePath,
      if (type != null) 'type': type,
      if (createdAt != null) 'created_at': createdAt,
      if (isSynced != null) 'is_synced': isSynced,
    });
  }

  PinMediasCompanion copyWith(
      {Value<int>? id,
      Value<int>? pinId,
      Value<String>? filePath,
      Value<int>? type,
      Value<DateTime>? createdAt,
      Value<bool>? isSynced}) {
    return PinMediasCompanion(
      id: id ?? this.id,
      pinId: pinId ?? this.pinId,
      filePath: filePath ?? this.filePath,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      isSynced: isSynced ?? this.isSynced,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (pinId.present) {
      map['pin_id'] = Variable<int>(pinId.value);
    }
    if (filePath.present) {
      map['file_path'] = Variable<String>(filePath.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(type.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PinMediasCompanion(')
          ..write('id: $id, ')
          ..write('pinId: $pinId, ')
          ..write('filePath: $filePath, ')
          ..write('type: $type, ')
          ..write('createdAt: $createdAt, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }
}

class $JourneyPointsTable extends JourneyPoints
    with TableInfo<$JourneyPointsTable, JourneyPoint> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JourneyPointsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _journeyIdMeta =
      const VerificationMeta('journeyId');
  @override
  late final GeneratedColumn<int> journeyId = GeneratedColumn<int>(
      'journey_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES journeys (id) ON DELETE CASCADE'));
  static const VerificationMeta _latitudeMeta =
      const VerificationMeta('latitude');
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
      'latitude', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _longitudeMeta =
      const VerificationMeta('longitude');
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
      'longitude', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _altitudeMeta =
      const VerificationMeta('altitude');
  @override
  late final GeneratedColumn<double> altitude = GeneratedColumn<double>(
      'altitude', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _speedMeta = const VerificationMeta('speed');
  @override
  late final GeneratedColumn<double> speed = GeneratedColumn<double>(
      'speed', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _accuracyMeta =
      const VerificationMeta('accuracy');
  @override
  late final GeneratedColumn<double> accuracy = GeneratedColumn<double>(
      'accuracy', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _timestampMeta =
      const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
      'timestamp', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        journeyId,
        latitude,
        longitude,
        altitude,
        speed,
        accuracy,
        timestamp
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'journey_points';
  @override
  VerificationContext validateIntegrity(Insertable<JourneyPoint> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('journey_id')) {
      context.handle(_journeyIdMeta,
          journeyId.isAcceptableOrUnknown(data['journey_id']!, _journeyIdMeta));
    } else if (isInserting) {
      context.missing(_journeyIdMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(_latitudeMeta,
          latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta));
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(_longitudeMeta,
          longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta));
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    if (data.containsKey('altitude')) {
      context.handle(_altitudeMeta,
          altitude.isAcceptableOrUnknown(data['altitude']!, _altitudeMeta));
    }
    if (data.containsKey('speed')) {
      context.handle(
          _speedMeta, speed.isAcceptableOrUnknown(data['speed']!, _speedMeta));
    }
    if (data.containsKey('accuracy')) {
      context.handle(_accuracyMeta,
          accuracy.isAcceptableOrUnknown(data['accuracy']!, _accuracyMeta));
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  JourneyPoint map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return JourneyPoint(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      journeyId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}journey_id'])!,
      latitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}latitude'])!,
      longitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}longitude'])!,
      altitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}altitude']),
      speed: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}speed']),
      accuracy: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}accuracy']),
      timestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}timestamp'])!,
    );
  }

  @override
  $JourneyPointsTable createAlias(String alias) {
    return $JourneyPointsTable(attachedDatabase, alias);
  }
}

class JourneyPoint extends DataClass implements Insertable<JourneyPoint> {
  final int id;
  final int journeyId;
  final double latitude;
  final double longitude;
  final double? altitude;
  final double? speed;
  final double? accuracy;
  final DateTime timestamp;
  const JourneyPoint(
      {required this.id,
      required this.journeyId,
      required this.latitude,
      required this.longitude,
      this.altitude,
      this.speed,
      this.accuracy,
      required this.timestamp});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['journey_id'] = Variable<int>(journeyId);
    map['latitude'] = Variable<double>(latitude);
    map['longitude'] = Variable<double>(longitude);
    if (!nullToAbsent || altitude != null) {
      map['altitude'] = Variable<double>(altitude);
    }
    if (!nullToAbsent || speed != null) {
      map['speed'] = Variable<double>(speed);
    }
    if (!nullToAbsent || accuracy != null) {
      map['accuracy'] = Variable<double>(accuracy);
    }
    map['timestamp'] = Variable<DateTime>(timestamp);
    return map;
  }

  JourneyPointsCompanion toCompanion(bool nullToAbsent) {
    return JourneyPointsCompanion(
      id: Value(id),
      journeyId: Value(journeyId),
      latitude: Value(latitude),
      longitude: Value(longitude),
      altitude: altitude == null && nullToAbsent
          ? const Value.absent()
          : Value(altitude),
      speed:
          speed == null && nullToAbsent ? const Value.absent() : Value(speed),
      accuracy: accuracy == null && nullToAbsent
          ? const Value.absent()
          : Value(accuracy),
      timestamp: Value(timestamp),
    );
  }

  factory JourneyPoint.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return JourneyPoint(
      id: serializer.fromJson<int>(json['id']),
      journeyId: serializer.fromJson<int>(json['journeyId']),
      latitude: serializer.fromJson<double>(json['latitude']),
      longitude: serializer.fromJson<double>(json['longitude']),
      altitude: serializer.fromJson<double?>(json['altitude']),
      speed: serializer.fromJson<double?>(json['speed']),
      accuracy: serializer.fromJson<double?>(json['accuracy']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'journeyId': serializer.toJson<int>(journeyId),
      'latitude': serializer.toJson<double>(latitude),
      'longitude': serializer.toJson<double>(longitude),
      'altitude': serializer.toJson<double?>(altitude),
      'speed': serializer.toJson<double?>(speed),
      'accuracy': serializer.toJson<double?>(accuracy),
      'timestamp': serializer.toJson<DateTime>(timestamp),
    };
  }

  JourneyPoint copyWith(
          {int? id,
          int? journeyId,
          double? latitude,
          double? longitude,
          Value<double?> altitude = const Value.absent(),
          Value<double?> speed = const Value.absent(),
          Value<double?> accuracy = const Value.absent(),
          DateTime? timestamp}) =>
      JourneyPoint(
        id: id ?? this.id,
        journeyId: journeyId ?? this.journeyId,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        altitude: altitude.present ? altitude.value : this.altitude,
        speed: speed.present ? speed.value : this.speed,
        accuracy: accuracy.present ? accuracy.value : this.accuracy,
        timestamp: timestamp ?? this.timestamp,
      );
  JourneyPoint copyWithCompanion(JourneyPointsCompanion data) {
    return JourneyPoint(
      id: data.id.present ? data.id.value : this.id,
      journeyId: data.journeyId.present ? data.journeyId.value : this.journeyId,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      altitude: data.altitude.present ? data.altitude.value : this.altitude,
      speed: data.speed.present ? data.speed.value : this.speed,
      accuracy: data.accuracy.present ? data.accuracy.value : this.accuracy,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('JourneyPoint(')
          ..write('id: $id, ')
          ..write('journeyId: $journeyId, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('altitude: $altitude, ')
          ..write('speed: $speed, ')
          ..write('accuracy: $accuracy, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, journeyId, latitude, longitude, altitude, speed, accuracy, timestamp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JourneyPoint &&
          other.id == this.id &&
          other.journeyId == this.journeyId &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.altitude == this.altitude &&
          other.speed == this.speed &&
          other.accuracy == this.accuracy &&
          other.timestamp == this.timestamp);
}

class JourneyPointsCompanion extends UpdateCompanion<JourneyPoint> {
  final Value<int> id;
  final Value<int> journeyId;
  final Value<double> latitude;
  final Value<double> longitude;
  final Value<double?> altitude;
  final Value<double?> speed;
  final Value<double?> accuracy;
  final Value<DateTime> timestamp;
  const JourneyPointsCompanion({
    this.id = const Value.absent(),
    this.journeyId = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.altitude = const Value.absent(),
    this.speed = const Value.absent(),
    this.accuracy = const Value.absent(),
    this.timestamp = const Value.absent(),
  });
  JourneyPointsCompanion.insert({
    this.id = const Value.absent(),
    required int journeyId,
    required double latitude,
    required double longitude,
    this.altitude = const Value.absent(),
    this.speed = const Value.absent(),
    this.accuracy = const Value.absent(),
    this.timestamp = const Value.absent(),
  })  : journeyId = Value(journeyId),
        latitude = Value(latitude),
        longitude = Value(longitude);
  static Insertable<JourneyPoint> custom({
    Expression<int>? id,
    Expression<int>? journeyId,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<double>? altitude,
    Expression<double>? speed,
    Expression<double>? accuracy,
    Expression<DateTime>? timestamp,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (journeyId != null) 'journey_id': journeyId,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (altitude != null) 'altitude': altitude,
      if (speed != null) 'speed': speed,
      if (accuracy != null) 'accuracy': accuracy,
      if (timestamp != null) 'timestamp': timestamp,
    });
  }

  JourneyPointsCompanion copyWith(
      {Value<int>? id,
      Value<int>? journeyId,
      Value<double>? latitude,
      Value<double>? longitude,
      Value<double?>? altitude,
      Value<double?>? speed,
      Value<double?>? accuracy,
      Value<DateTime>? timestamp}) {
    return JourneyPointsCompanion(
      id: id ?? this.id,
      journeyId: journeyId ?? this.journeyId,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      altitude: altitude ?? this.altitude,
      speed: speed ?? this.speed,
      accuracy: accuracy ?? this.accuracy,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (journeyId.present) {
      map['journey_id'] = Variable<int>(journeyId.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (altitude.present) {
      map['altitude'] = Variable<double>(altitude.value);
    }
    if (speed.present) {
      map['speed'] = Variable<double>(speed.value);
    }
    if (accuracy.present) {
      map['accuracy'] = Variable<double>(accuracy.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JourneyPointsCompanion(')
          ..write('id: $id, ')
          ..write('journeyId: $journeyId, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('altitude: $altitude, ')
          ..write('speed: $speed, ')
          ..write('accuracy: $accuracy, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SavedMapsTable savedMaps = $SavedMapsTable(this);
  late final $TroupesTable troupes = $TroupesTable(this);
  late final $JourneysTable journeys = $JourneysTable(this);
  late final $PinsTable pins = $PinsTable(this);
  late final $PinMediasTable pinMedias = $PinMediasTable(this);
  late final $JourneyPointsTable journeyPoints = $JourneyPointsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [savedMaps, troupes, journeys, pins, pinMedias, journeyPoints];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('pins',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('pin_medias', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('journeys',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('journey_points', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $$SavedMapsTableCreateCompanionBuilder = SavedMapsCompanion Function({
  Value<int> id,
  required String name,
  Value<String?> description,
  Value<DateTime> createdAt,
  Value<bool> isSynced,
  Value<int> visibility,
  Value<String?> sourceUrl,
  Value<String?> authorName,
});
typedef $$SavedMapsTableUpdateCompanionBuilder = SavedMapsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String?> description,
  Value<DateTime> createdAt,
  Value<bool> isSynced,
  Value<int> visibility,
  Value<String?> sourceUrl,
  Value<String?> authorName,
});

final class $$SavedMapsTableReferences
    extends BaseReferences<_$AppDatabase, $SavedMapsTable, SavedMap> {
  $$SavedMapsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PinsTable, List<Pin>> _pinsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.pins,
          aliasName: $_aliasNameGenerator(db.savedMaps.id, db.pins.mapId));

  $$PinsTableProcessedTableManager get pinsRefs {
    final manager = $$PinsTableTableManager($_db, $_db.pins)
        .filter((f) => f.mapId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_pinsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$SavedMapsTableFilterComposer
    extends Composer<_$AppDatabase, $SavedMapsTable> {
  $$SavedMapsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get visibility => $composableBuilder(
      column: $table.visibility, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sourceUrl => $composableBuilder(
      column: $table.sourceUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get authorName => $composableBuilder(
      column: $table.authorName, builder: (column) => ColumnFilters(column));

  Expression<bool> pinsRefs(
      Expression<bool> Function($$PinsTableFilterComposer f) f) {
    final $$PinsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.pins,
        getReferencedColumn: (t) => t.mapId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PinsTableFilterComposer(
              $db: $db,
              $table: $db.pins,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$SavedMapsTableOrderingComposer
    extends Composer<_$AppDatabase, $SavedMapsTable> {
  $$SavedMapsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get visibility => $composableBuilder(
      column: $table.visibility, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sourceUrl => $composableBuilder(
      column: $table.sourceUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get authorName => $composableBuilder(
      column: $table.authorName, builder: (column) => ColumnOrderings(column));
}

class $$SavedMapsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SavedMapsTable> {
  $$SavedMapsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<int> get visibility => $composableBuilder(
      column: $table.visibility, builder: (column) => column);

  GeneratedColumn<String> get sourceUrl =>
      $composableBuilder(column: $table.sourceUrl, builder: (column) => column);

  GeneratedColumn<String> get authorName => $composableBuilder(
      column: $table.authorName, builder: (column) => column);

  Expression<T> pinsRefs<T extends Object>(
      Expression<T> Function($$PinsTableAnnotationComposer a) f) {
    final $$PinsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.pins,
        getReferencedColumn: (t) => t.mapId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PinsTableAnnotationComposer(
              $db: $db,
              $table: $db.pins,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$SavedMapsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SavedMapsTable,
    SavedMap,
    $$SavedMapsTableFilterComposer,
    $$SavedMapsTableOrderingComposer,
    $$SavedMapsTableAnnotationComposer,
    $$SavedMapsTableCreateCompanionBuilder,
    $$SavedMapsTableUpdateCompanionBuilder,
    (SavedMap, $$SavedMapsTableReferences),
    SavedMap,
    PrefetchHooks Function({bool pinsRefs})> {
  $$SavedMapsTableTableManager(_$AppDatabase db, $SavedMapsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SavedMapsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SavedMapsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SavedMapsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<int> visibility = const Value.absent(),
            Value<String?> sourceUrl = const Value.absent(),
            Value<String?> authorName = const Value.absent(),
          }) =>
              SavedMapsCompanion(
            id: id,
            name: name,
            description: description,
            createdAt: createdAt,
            isSynced: isSynced,
            visibility: visibility,
            sourceUrl: sourceUrl,
            authorName: authorName,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<String?> description = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<int> visibility = const Value.absent(),
            Value<String?> sourceUrl = const Value.absent(),
            Value<String?> authorName = const Value.absent(),
          }) =>
              SavedMapsCompanion.insert(
            id: id,
            name: name,
            description: description,
            createdAt: createdAt,
            isSynced: isSynced,
            visibility: visibility,
            sourceUrl: sourceUrl,
            authorName: authorName,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$SavedMapsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({pinsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (pinsRefs) db.pins],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (pinsRefs)
                    await $_getPrefetchedData<SavedMap, $SavedMapsTable, Pin>(
                        currentTable: table,
                        referencedTable:
                            $$SavedMapsTableReferences._pinsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$SavedMapsTableReferences(db, table, p0).pinsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.mapId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$SavedMapsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SavedMapsTable,
    SavedMap,
    $$SavedMapsTableFilterComposer,
    $$SavedMapsTableOrderingComposer,
    $$SavedMapsTableAnnotationComposer,
    $$SavedMapsTableCreateCompanionBuilder,
    $$SavedMapsTableUpdateCompanionBuilder,
    (SavedMap, $$SavedMapsTableReferences),
    SavedMap,
    PrefetchHooks Function({bool pinsRefs})>;
typedef $$TroupesTableCreateCompanionBuilder = TroupesCompanion Function({
  Value<int> id,
  required String name,
  Value<String?> description,
  required DateTime startDate,
  Value<DateTime?> endDate,
  Value<DateTime> createdAt,
  Value<bool> isSynced,
  Value<int> visibility,
});
typedef $$TroupesTableUpdateCompanionBuilder = TroupesCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String?> description,
  Value<DateTime> startDate,
  Value<DateTime?> endDate,
  Value<DateTime> createdAt,
  Value<bool> isSynced,
  Value<int> visibility,
});

final class $$TroupesTableReferences
    extends BaseReferences<_$AppDatabase, $TroupesTable, Troupe> {
  $$TroupesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PinsTable, List<Pin>> _pinsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.pins,
          aliasName: $_aliasNameGenerator(db.troupes.id, db.pins.troupeId));

  $$PinsTableProcessedTableManager get pinsRefs {
    final manager = $$PinsTableTableManager($_db, $_db.pins)
        .filter((f) => f.troupeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_pinsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$TroupesTableFilterComposer
    extends Composer<_$AppDatabase, $TroupesTable> {
  $$TroupesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get visibility => $composableBuilder(
      column: $table.visibility, builder: (column) => ColumnFilters(column));

  Expression<bool> pinsRefs(
      Expression<bool> Function($$PinsTableFilterComposer f) f) {
    final $$PinsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.pins,
        getReferencedColumn: (t) => t.troupeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PinsTableFilterComposer(
              $db: $db,
              $table: $db.pins,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TroupesTableOrderingComposer
    extends Composer<_$AppDatabase, $TroupesTable> {
  $$TroupesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get visibility => $composableBuilder(
      column: $table.visibility, builder: (column) => ColumnOrderings(column));
}

class $$TroupesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TroupesTable> {
  $$TroupesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<int> get visibility => $composableBuilder(
      column: $table.visibility, builder: (column) => column);

  Expression<T> pinsRefs<T extends Object>(
      Expression<T> Function($$PinsTableAnnotationComposer a) f) {
    final $$PinsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.pins,
        getReferencedColumn: (t) => t.troupeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PinsTableAnnotationComposer(
              $db: $db,
              $table: $db.pins,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TroupesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TroupesTable,
    Troupe,
    $$TroupesTableFilterComposer,
    $$TroupesTableOrderingComposer,
    $$TroupesTableAnnotationComposer,
    $$TroupesTableCreateCompanionBuilder,
    $$TroupesTableUpdateCompanionBuilder,
    (Troupe, $$TroupesTableReferences),
    Troupe,
    PrefetchHooks Function({bool pinsRefs})> {
  $$TroupesTableTableManager(_$AppDatabase db, $TroupesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TroupesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TroupesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TroupesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<DateTime> startDate = const Value.absent(),
            Value<DateTime?> endDate = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<int> visibility = const Value.absent(),
          }) =>
              TroupesCompanion(
            id: id,
            name: name,
            description: description,
            startDate: startDate,
            endDate: endDate,
            createdAt: createdAt,
            isSynced: isSynced,
            visibility: visibility,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<String?> description = const Value.absent(),
            required DateTime startDate,
            Value<DateTime?> endDate = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<int> visibility = const Value.absent(),
          }) =>
              TroupesCompanion.insert(
            id: id,
            name: name,
            description: description,
            startDate: startDate,
            endDate: endDate,
            createdAt: createdAt,
            isSynced: isSynced,
            visibility: visibility,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$TroupesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({pinsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (pinsRefs) db.pins],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (pinsRefs)
                    await $_getPrefetchedData<Troupe, $TroupesTable, Pin>(
                        currentTable: table,
                        referencedTable:
                            $$TroupesTableReferences._pinsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TroupesTableReferences(db, table, p0).pinsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.troupeId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$TroupesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TroupesTable,
    Troupe,
    $$TroupesTableFilterComposer,
    $$TroupesTableOrderingComposer,
    $$TroupesTableAnnotationComposer,
    $$TroupesTableCreateCompanionBuilder,
    $$TroupesTableUpdateCompanionBuilder,
    (Troupe, $$TroupesTableReferences),
    Troupe,
    PrefetchHooks Function({bool pinsRefs})>;
typedef $$JourneysTableCreateCompanionBuilder = JourneysCompanion Function({
  Value<int> id,
  Value<String?> name,
  Value<String?> description,
  required DateTime startTime,
  Value<DateTime?> endTime,
  Value<String?> routeData,
  Value<double> totalDistance,
  Value<int> durationSeconds,
  Value<bool> isSynced,
  Value<int> visibility,
});
typedef $$JourneysTableUpdateCompanionBuilder = JourneysCompanion Function({
  Value<int> id,
  Value<String?> name,
  Value<String?> description,
  Value<DateTime> startTime,
  Value<DateTime?> endTime,
  Value<String?> routeData,
  Value<double> totalDistance,
  Value<int> durationSeconds,
  Value<bool> isSynced,
  Value<int> visibility,
});

final class $$JourneysTableReferences
    extends BaseReferences<_$AppDatabase, $JourneysTable, Journey> {
  $$JourneysTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PinsTable, List<Pin>> _pinsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.pins,
          aliasName: $_aliasNameGenerator(db.journeys.id, db.pins.journeyId));

  $$PinsTableProcessedTableManager get pinsRefs {
    final manager = $$PinsTableTableManager($_db, $_db.pins)
        .filter((f) => f.journeyId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_pinsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$JourneyPointsTable, List<JourneyPoint>>
      _journeyPointsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.journeyPoints,
              aliasName: $_aliasNameGenerator(
                  db.journeys.id, db.journeyPoints.journeyId));

  $$JourneyPointsTableProcessedTableManager get journeyPointsRefs {
    final manager = $$JourneyPointsTableTableManager($_db, $_db.journeyPoints)
        .filter((f) => f.journeyId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_journeyPointsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$JourneysTableFilterComposer
    extends Composer<_$AppDatabase, $JourneysTable> {
  $$JourneysTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startTime => $composableBuilder(
      column: $table.startTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endTime => $composableBuilder(
      column: $table.endTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get routeData => $composableBuilder(
      column: $table.routeData, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalDistance => $composableBuilder(
      column: $table.totalDistance, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get durationSeconds => $composableBuilder(
      column: $table.durationSeconds,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get visibility => $composableBuilder(
      column: $table.visibility, builder: (column) => ColumnFilters(column));

  Expression<bool> pinsRefs(
      Expression<bool> Function($$PinsTableFilterComposer f) f) {
    final $$PinsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.pins,
        getReferencedColumn: (t) => t.journeyId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PinsTableFilterComposer(
              $db: $db,
              $table: $db.pins,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> journeyPointsRefs(
      Expression<bool> Function($$JourneyPointsTableFilterComposer f) f) {
    final $$JourneyPointsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.journeyPoints,
        getReferencedColumn: (t) => t.journeyId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$JourneyPointsTableFilterComposer(
              $db: $db,
              $table: $db.journeyPoints,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$JourneysTableOrderingComposer
    extends Composer<_$AppDatabase, $JourneysTable> {
  $$JourneysTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startTime => $composableBuilder(
      column: $table.startTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endTime => $composableBuilder(
      column: $table.endTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get routeData => $composableBuilder(
      column: $table.routeData, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalDistance => $composableBuilder(
      column: $table.totalDistance,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get durationSeconds => $composableBuilder(
      column: $table.durationSeconds,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get visibility => $composableBuilder(
      column: $table.visibility, builder: (column) => ColumnOrderings(column));
}

class $$JourneysTableAnnotationComposer
    extends Composer<_$AppDatabase, $JourneysTable> {
  $$JourneysTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<DateTime> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<DateTime> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<String> get routeData =>
      $composableBuilder(column: $table.routeData, builder: (column) => column);

  GeneratedColumn<double> get totalDistance => $composableBuilder(
      column: $table.totalDistance, builder: (column) => column);

  GeneratedColumn<int> get durationSeconds => $composableBuilder(
      column: $table.durationSeconds, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<int> get visibility => $composableBuilder(
      column: $table.visibility, builder: (column) => column);

  Expression<T> pinsRefs<T extends Object>(
      Expression<T> Function($$PinsTableAnnotationComposer a) f) {
    final $$PinsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.pins,
        getReferencedColumn: (t) => t.journeyId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PinsTableAnnotationComposer(
              $db: $db,
              $table: $db.pins,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> journeyPointsRefs<T extends Object>(
      Expression<T> Function($$JourneyPointsTableAnnotationComposer a) f) {
    final $$JourneyPointsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.journeyPoints,
        getReferencedColumn: (t) => t.journeyId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$JourneyPointsTableAnnotationComposer(
              $db: $db,
              $table: $db.journeyPoints,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$JourneysTableTableManager extends RootTableManager<
    _$AppDatabase,
    $JourneysTable,
    Journey,
    $$JourneysTableFilterComposer,
    $$JourneysTableOrderingComposer,
    $$JourneysTableAnnotationComposer,
    $$JourneysTableCreateCompanionBuilder,
    $$JourneysTableUpdateCompanionBuilder,
    (Journey, $$JourneysTableReferences),
    Journey,
    PrefetchHooks Function({bool pinsRefs, bool journeyPointsRefs})> {
  $$JourneysTableTableManager(_$AppDatabase db, $JourneysTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JourneysTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$JourneysTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$JourneysTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<DateTime> startTime = const Value.absent(),
            Value<DateTime?> endTime = const Value.absent(),
            Value<String?> routeData = const Value.absent(),
            Value<double> totalDistance = const Value.absent(),
            Value<int> durationSeconds = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<int> visibility = const Value.absent(),
          }) =>
              JourneysCompanion(
            id: id,
            name: name,
            description: description,
            startTime: startTime,
            endTime: endTime,
            routeData: routeData,
            totalDistance: totalDistance,
            durationSeconds: durationSeconds,
            isSynced: isSynced,
            visibility: visibility,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<String?> description = const Value.absent(),
            required DateTime startTime,
            Value<DateTime?> endTime = const Value.absent(),
            Value<String?> routeData = const Value.absent(),
            Value<double> totalDistance = const Value.absent(),
            Value<int> durationSeconds = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<int> visibility = const Value.absent(),
          }) =>
              JourneysCompanion.insert(
            id: id,
            name: name,
            description: description,
            startTime: startTime,
            endTime: endTime,
            routeData: routeData,
            totalDistance: totalDistance,
            durationSeconds: durationSeconds,
            isSynced: isSynced,
            visibility: visibility,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$JourneysTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {pinsRefs = false, journeyPointsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (pinsRefs) db.pins,
                if (journeyPointsRefs) db.journeyPoints
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (pinsRefs)
                    await $_getPrefetchedData<Journey, $JourneysTable, Pin>(
                        currentTable: table,
                        referencedTable:
                            $$JourneysTableReferences._pinsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$JourneysTableReferences(db, table, p0).pinsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.journeyId == item.id),
                        typedResults: items),
                  if (journeyPointsRefs)
                    await $_getPrefetchedData<Journey, $JourneysTable,
                            JourneyPoint>(
                        currentTable: table,
                        referencedTable: $$JourneysTableReferences
                            ._journeyPointsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$JourneysTableReferences(db, table, p0)
                                .journeyPointsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.journeyId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$JourneysTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $JourneysTable,
    Journey,
    $$JourneysTableFilterComposer,
    $$JourneysTableOrderingComposer,
    $$JourneysTableAnnotationComposer,
    $$JourneysTableCreateCompanionBuilder,
    $$JourneysTableUpdateCompanionBuilder,
    (Journey, $$JourneysTableReferences),
    Journey,
    PrefetchHooks Function({bool pinsRefs, bool journeyPointsRefs})>;
typedef $$PinsTableCreateCompanionBuilder = PinsCompanion Function({
  Value<int> id,
  Value<String?> title,
  Value<String?> description,
  required double latitude,
  required double longitude,
  Value<DateTime> createdAt,
  Value<bool> isSynced,
  Value<int> visibility,
  Value<int> type,
  Value<int?> mapId,
  Value<int?> troupeId,
  Value<int?> journeyId,
  Value<bool> isDraft,
});
typedef $$PinsTableUpdateCompanionBuilder = PinsCompanion Function({
  Value<int> id,
  Value<String?> title,
  Value<String?> description,
  Value<double> latitude,
  Value<double> longitude,
  Value<DateTime> createdAt,
  Value<bool> isSynced,
  Value<int> visibility,
  Value<int> type,
  Value<int?> mapId,
  Value<int?> troupeId,
  Value<int?> journeyId,
  Value<bool> isDraft,
});

final class $$PinsTableReferences
    extends BaseReferences<_$AppDatabase, $PinsTable, Pin> {
  $$PinsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SavedMapsTable _mapIdTable(_$AppDatabase db) => db.savedMaps
      .createAlias($_aliasNameGenerator(db.pins.mapId, db.savedMaps.id));

  $$SavedMapsTableProcessedTableManager? get mapId {
    final $_column = $_itemColumn<int>('map_id');
    if ($_column == null) return null;
    final manager = $$SavedMapsTableTableManager($_db, $_db.savedMaps)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mapIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $TroupesTable _troupeIdTable(_$AppDatabase db) => db.troupes
      .createAlias($_aliasNameGenerator(db.pins.troupeId, db.troupes.id));

  $$TroupesTableProcessedTableManager? get troupeId {
    final $_column = $_itemColumn<int>('troupe_id');
    if ($_column == null) return null;
    final manager = $$TroupesTableTableManager($_db, $_db.troupes)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_troupeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $JourneysTable _journeyIdTable(_$AppDatabase db) => db.journeys
      .createAlias($_aliasNameGenerator(db.pins.journeyId, db.journeys.id));

  $$JourneysTableProcessedTableManager? get journeyId {
    final $_column = $_itemColumn<int>('journey_id');
    if ($_column == null) return null;
    final manager = $$JourneysTableTableManager($_db, $_db.journeys)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_journeyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$PinMediasTable, List<PinMedia>>
      _pinMediasRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.pinMedias,
              aliasName: $_aliasNameGenerator(db.pins.id, db.pinMedias.pinId));

  $$PinMediasTableProcessedTableManager get pinMediasRefs {
    final manager = $$PinMediasTableTableManager($_db, $_db.pinMedias)
        .filter((f) => f.pinId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_pinMediasRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$PinsTableFilterComposer extends Composer<_$AppDatabase, $PinsTable> {
  $$PinsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get latitude => $composableBuilder(
      column: $table.latitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get longitude => $composableBuilder(
      column: $table.longitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get visibility => $composableBuilder(
      column: $table.visibility, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDraft => $composableBuilder(
      column: $table.isDraft, builder: (column) => ColumnFilters(column));

  $$SavedMapsTableFilterComposer get mapId {
    final $$SavedMapsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.mapId,
        referencedTable: $db.savedMaps,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SavedMapsTableFilterComposer(
              $db: $db,
              $table: $db.savedMaps,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TroupesTableFilterComposer get troupeId {
    final $$TroupesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.troupeId,
        referencedTable: $db.troupes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TroupesTableFilterComposer(
              $db: $db,
              $table: $db.troupes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$JourneysTableFilterComposer get journeyId {
    final $$JourneysTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.journeyId,
        referencedTable: $db.journeys,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$JourneysTableFilterComposer(
              $db: $db,
              $table: $db.journeys,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> pinMediasRefs(
      Expression<bool> Function($$PinMediasTableFilterComposer f) f) {
    final $$PinMediasTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.pinMedias,
        getReferencedColumn: (t) => t.pinId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PinMediasTableFilterComposer(
              $db: $db,
              $table: $db.pinMedias,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PinsTableOrderingComposer extends Composer<_$AppDatabase, $PinsTable> {
  $$PinsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get latitude => $composableBuilder(
      column: $table.latitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get longitude => $composableBuilder(
      column: $table.longitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get visibility => $composableBuilder(
      column: $table.visibility, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDraft => $composableBuilder(
      column: $table.isDraft, builder: (column) => ColumnOrderings(column));

  $$SavedMapsTableOrderingComposer get mapId {
    final $$SavedMapsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.mapId,
        referencedTable: $db.savedMaps,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SavedMapsTableOrderingComposer(
              $db: $db,
              $table: $db.savedMaps,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TroupesTableOrderingComposer get troupeId {
    final $$TroupesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.troupeId,
        referencedTable: $db.troupes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TroupesTableOrderingComposer(
              $db: $db,
              $table: $db.troupes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$JourneysTableOrderingComposer get journeyId {
    final $$JourneysTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.journeyId,
        referencedTable: $db.journeys,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$JourneysTableOrderingComposer(
              $db: $db,
              $table: $db.journeys,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PinsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PinsTable> {
  $$PinsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<int> get visibility => $composableBuilder(
      column: $table.visibility, builder: (column) => column);

  GeneratedColumn<int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<bool> get isDraft =>
      $composableBuilder(column: $table.isDraft, builder: (column) => column);

  $$SavedMapsTableAnnotationComposer get mapId {
    final $$SavedMapsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.mapId,
        referencedTable: $db.savedMaps,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SavedMapsTableAnnotationComposer(
              $db: $db,
              $table: $db.savedMaps,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TroupesTableAnnotationComposer get troupeId {
    final $$TroupesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.troupeId,
        referencedTable: $db.troupes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TroupesTableAnnotationComposer(
              $db: $db,
              $table: $db.troupes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$JourneysTableAnnotationComposer get journeyId {
    final $$JourneysTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.journeyId,
        referencedTable: $db.journeys,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$JourneysTableAnnotationComposer(
              $db: $db,
              $table: $db.journeys,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> pinMediasRefs<T extends Object>(
      Expression<T> Function($$PinMediasTableAnnotationComposer a) f) {
    final $$PinMediasTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.pinMedias,
        getReferencedColumn: (t) => t.pinId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PinMediasTableAnnotationComposer(
              $db: $db,
              $table: $db.pinMedias,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PinsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PinsTable,
    Pin,
    $$PinsTableFilterComposer,
    $$PinsTableOrderingComposer,
    $$PinsTableAnnotationComposer,
    $$PinsTableCreateCompanionBuilder,
    $$PinsTableUpdateCompanionBuilder,
    (Pin, $$PinsTableReferences),
    Pin,
    PrefetchHooks Function(
        {bool mapId, bool troupeId, bool journeyId, bool pinMediasRefs})> {
  $$PinsTableTableManager(_$AppDatabase db, $PinsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PinsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PinsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PinsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> title = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<double> latitude = const Value.absent(),
            Value<double> longitude = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<int> visibility = const Value.absent(),
            Value<int> type = const Value.absent(),
            Value<int?> mapId = const Value.absent(),
            Value<int?> troupeId = const Value.absent(),
            Value<int?> journeyId = const Value.absent(),
            Value<bool> isDraft = const Value.absent(),
          }) =>
              PinsCompanion(
            id: id,
            title: title,
            description: description,
            latitude: latitude,
            longitude: longitude,
            createdAt: createdAt,
            isSynced: isSynced,
            visibility: visibility,
            type: type,
            mapId: mapId,
            troupeId: troupeId,
            journeyId: journeyId,
            isDraft: isDraft,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> title = const Value.absent(),
            Value<String?> description = const Value.absent(),
            required double latitude,
            required double longitude,
            Value<DateTime> createdAt = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<int> visibility = const Value.absent(),
            Value<int> type = const Value.absent(),
            Value<int?> mapId = const Value.absent(),
            Value<int?> troupeId = const Value.absent(),
            Value<int?> journeyId = const Value.absent(),
            Value<bool> isDraft = const Value.absent(),
          }) =>
              PinsCompanion.insert(
            id: id,
            title: title,
            description: description,
            latitude: latitude,
            longitude: longitude,
            createdAt: createdAt,
            isSynced: isSynced,
            visibility: visibility,
            type: type,
            mapId: mapId,
            troupeId: troupeId,
            journeyId: journeyId,
            isDraft: isDraft,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$PinsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {mapId = false,
              troupeId = false,
              journeyId = false,
              pinMediasRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (pinMediasRefs) db.pinMedias],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (mapId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.mapId,
                    referencedTable: $$PinsTableReferences._mapIdTable(db),
                    referencedColumn: $$PinsTableReferences._mapIdTable(db).id,
                  ) as T;
                }
                if (troupeId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.troupeId,
                    referencedTable: $$PinsTableReferences._troupeIdTable(db),
                    referencedColumn:
                        $$PinsTableReferences._troupeIdTable(db).id,
                  ) as T;
                }
                if (journeyId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.journeyId,
                    referencedTable: $$PinsTableReferences._journeyIdTable(db),
                    referencedColumn:
                        $$PinsTableReferences._journeyIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (pinMediasRefs)
                    await $_getPrefetchedData<Pin, $PinsTable, PinMedia>(
                        currentTable: table,
                        referencedTable:
                            $$PinsTableReferences._pinMediasRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PinsTableReferences(db, table, p0).pinMediasRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.pinId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$PinsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PinsTable,
    Pin,
    $$PinsTableFilterComposer,
    $$PinsTableOrderingComposer,
    $$PinsTableAnnotationComposer,
    $$PinsTableCreateCompanionBuilder,
    $$PinsTableUpdateCompanionBuilder,
    (Pin, $$PinsTableReferences),
    Pin,
    PrefetchHooks Function(
        {bool mapId, bool troupeId, bool journeyId, bool pinMediasRefs})>;
typedef $$PinMediasTableCreateCompanionBuilder = PinMediasCompanion Function({
  Value<int> id,
  required int pinId,
  required String filePath,
  Value<int> type,
  Value<DateTime> createdAt,
  Value<bool> isSynced,
});
typedef $$PinMediasTableUpdateCompanionBuilder = PinMediasCompanion Function({
  Value<int> id,
  Value<int> pinId,
  Value<String> filePath,
  Value<int> type,
  Value<DateTime> createdAt,
  Value<bool> isSynced,
});

final class $$PinMediasTableReferences
    extends BaseReferences<_$AppDatabase, $PinMediasTable, PinMedia> {
  $$PinMediasTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PinsTable _pinIdTable(_$AppDatabase db) =>
      db.pins.createAlias($_aliasNameGenerator(db.pinMedias.pinId, db.pins.id));

  $$PinsTableProcessedTableManager get pinId {
    final $_column = $_itemColumn<int>('pin_id')!;

    final manager = $$PinsTableTableManager($_db, $_db.pins)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pinIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$PinMediasTableFilterComposer
    extends Composer<_$AppDatabase, $PinMediasTable> {
  $$PinMediasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get filePath => $composableBuilder(
      column: $table.filePath, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnFilters(column));

  $$PinsTableFilterComposer get pinId {
    final $$PinsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.pinId,
        referencedTable: $db.pins,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PinsTableFilterComposer(
              $db: $db,
              $table: $db.pins,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PinMediasTableOrderingComposer
    extends Composer<_$AppDatabase, $PinMediasTable> {
  $$PinMediasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get filePath => $composableBuilder(
      column: $table.filePath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnOrderings(column));

  $$PinsTableOrderingComposer get pinId {
    final $$PinsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.pinId,
        referencedTable: $db.pins,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PinsTableOrderingComposer(
              $db: $db,
              $table: $db.pins,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PinMediasTableAnnotationComposer
    extends Composer<_$AppDatabase, $PinMediasTable> {
  $$PinMediasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get filePath =>
      $composableBuilder(column: $table.filePath, builder: (column) => column);

  GeneratedColumn<int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  $$PinsTableAnnotationComposer get pinId {
    final $$PinsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.pinId,
        referencedTable: $db.pins,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PinsTableAnnotationComposer(
              $db: $db,
              $table: $db.pins,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PinMediasTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PinMediasTable,
    PinMedia,
    $$PinMediasTableFilterComposer,
    $$PinMediasTableOrderingComposer,
    $$PinMediasTableAnnotationComposer,
    $$PinMediasTableCreateCompanionBuilder,
    $$PinMediasTableUpdateCompanionBuilder,
    (PinMedia, $$PinMediasTableReferences),
    PinMedia,
    PrefetchHooks Function({bool pinId})> {
  $$PinMediasTableTableManager(_$AppDatabase db, $PinMediasTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PinMediasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PinMediasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PinMediasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> pinId = const Value.absent(),
            Value<String> filePath = const Value.absent(),
            Value<int> type = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
          }) =>
              PinMediasCompanion(
            id: id,
            pinId: pinId,
            filePath: filePath,
            type: type,
            createdAt: createdAt,
            isSynced: isSynced,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int pinId,
            required String filePath,
            Value<int> type = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
          }) =>
              PinMediasCompanion.insert(
            id: id,
            pinId: pinId,
            filePath: filePath,
            type: type,
            createdAt: createdAt,
            isSynced: isSynced,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$PinMediasTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({pinId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (pinId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.pinId,
                    referencedTable: $$PinMediasTableReferences._pinIdTable(db),
                    referencedColumn:
                        $$PinMediasTableReferences._pinIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$PinMediasTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PinMediasTable,
    PinMedia,
    $$PinMediasTableFilterComposer,
    $$PinMediasTableOrderingComposer,
    $$PinMediasTableAnnotationComposer,
    $$PinMediasTableCreateCompanionBuilder,
    $$PinMediasTableUpdateCompanionBuilder,
    (PinMedia, $$PinMediasTableReferences),
    PinMedia,
    PrefetchHooks Function({bool pinId})>;
typedef $$JourneyPointsTableCreateCompanionBuilder = JourneyPointsCompanion
    Function({
  Value<int> id,
  required int journeyId,
  required double latitude,
  required double longitude,
  Value<double?> altitude,
  Value<double?> speed,
  Value<double?> accuracy,
  Value<DateTime> timestamp,
});
typedef $$JourneyPointsTableUpdateCompanionBuilder = JourneyPointsCompanion
    Function({
  Value<int> id,
  Value<int> journeyId,
  Value<double> latitude,
  Value<double> longitude,
  Value<double?> altitude,
  Value<double?> speed,
  Value<double?> accuracy,
  Value<DateTime> timestamp,
});

final class $$JourneyPointsTableReferences
    extends BaseReferences<_$AppDatabase, $JourneyPointsTable, JourneyPoint> {
  $$JourneyPointsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $JourneysTable _journeyIdTable(_$AppDatabase db) =>
      db.journeys.createAlias(
          $_aliasNameGenerator(db.journeyPoints.journeyId, db.journeys.id));

  $$JourneysTableProcessedTableManager get journeyId {
    final $_column = $_itemColumn<int>('journey_id')!;

    final manager = $$JourneysTableTableManager($_db, $_db.journeys)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_journeyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$JourneyPointsTableFilterComposer
    extends Composer<_$AppDatabase, $JourneyPointsTable> {
  $$JourneyPointsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get latitude => $composableBuilder(
      column: $table.latitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get longitude => $composableBuilder(
      column: $table.longitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get altitude => $composableBuilder(
      column: $table.altitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get speed => $composableBuilder(
      column: $table.speed, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get accuracy => $composableBuilder(
      column: $table.accuracy, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnFilters(column));

  $$JourneysTableFilterComposer get journeyId {
    final $$JourneysTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.journeyId,
        referencedTable: $db.journeys,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$JourneysTableFilterComposer(
              $db: $db,
              $table: $db.journeys,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$JourneyPointsTableOrderingComposer
    extends Composer<_$AppDatabase, $JourneyPointsTable> {
  $$JourneyPointsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get latitude => $composableBuilder(
      column: $table.latitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get longitude => $composableBuilder(
      column: $table.longitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get altitude => $composableBuilder(
      column: $table.altitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get speed => $composableBuilder(
      column: $table.speed, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get accuracy => $composableBuilder(
      column: $table.accuracy, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnOrderings(column));

  $$JourneysTableOrderingComposer get journeyId {
    final $$JourneysTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.journeyId,
        referencedTable: $db.journeys,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$JourneysTableOrderingComposer(
              $db: $db,
              $table: $db.journeys,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$JourneyPointsTableAnnotationComposer
    extends Composer<_$AppDatabase, $JourneyPointsTable> {
  $$JourneyPointsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<double> get altitude =>
      $composableBuilder(column: $table.altitude, builder: (column) => column);

  GeneratedColumn<double> get speed =>
      $composableBuilder(column: $table.speed, builder: (column) => column);

  GeneratedColumn<double> get accuracy =>
      $composableBuilder(column: $table.accuracy, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  $$JourneysTableAnnotationComposer get journeyId {
    final $$JourneysTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.journeyId,
        referencedTable: $db.journeys,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$JourneysTableAnnotationComposer(
              $db: $db,
              $table: $db.journeys,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$JourneyPointsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $JourneyPointsTable,
    JourneyPoint,
    $$JourneyPointsTableFilterComposer,
    $$JourneyPointsTableOrderingComposer,
    $$JourneyPointsTableAnnotationComposer,
    $$JourneyPointsTableCreateCompanionBuilder,
    $$JourneyPointsTableUpdateCompanionBuilder,
    (JourneyPoint, $$JourneyPointsTableReferences),
    JourneyPoint,
    PrefetchHooks Function({bool journeyId})> {
  $$JourneyPointsTableTableManager(_$AppDatabase db, $JourneyPointsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JourneyPointsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$JourneyPointsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$JourneyPointsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> journeyId = const Value.absent(),
            Value<double> latitude = const Value.absent(),
            Value<double> longitude = const Value.absent(),
            Value<double?> altitude = const Value.absent(),
            Value<double?> speed = const Value.absent(),
            Value<double?> accuracy = const Value.absent(),
            Value<DateTime> timestamp = const Value.absent(),
          }) =>
              JourneyPointsCompanion(
            id: id,
            journeyId: journeyId,
            latitude: latitude,
            longitude: longitude,
            altitude: altitude,
            speed: speed,
            accuracy: accuracy,
            timestamp: timestamp,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int journeyId,
            required double latitude,
            required double longitude,
            Value<double?> altitude = const Value.absent(),
            Value<double?> speed = const Value.absent(),
            Value<double?> accuracy = const Value.absent(),
            Value<DateTime> timestamp = const Value.absent(),
          }) =>
              JourneyPointsCompanion.insert(
            id: id,
            journeyId: journeyId,
            latitude: latitude,
            longitude: longitude,
            altitude: altitude,
            speed: speed,
            accuracy: accuracy,
            timestamp: timestamp,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$JourneyPointsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({journeyId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (journeyId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.journeyId,
                    referencedTable:
                        $$JourneyPointsTableReferences._journeyIdTable(db),
                    referencedColumn:
                        $$JourneyPointsTableReferences._journeyIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$JourneyPointsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $JourneyPointsTable,
    JourneyPoint,
    $$JourneyPointsTableFilterComposer,
    $$JourneyPointsTableOrderingComposer,
    $$JourneyPointsTableAnnotationComposer,
    $$JourneyPointsTableCreateCompanionBuilder,
    $$JourneyPointsTableUpdateCompanionBuilder,
    (JourneyPoint, $$JourneyPointsTableReferences),
    JourneyPoint,
    PrefetchHooks Function({bool journeyId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SavedMapsTableTableManager get savedMaps =>
      $$SavedMapsTableTableManager(_db, _db.savedMaps);
  $$TroupesTableTableManager get troupes =>
      $$TroupesTableTableManager(_db, _db.troupes);
  $$JourneysTableTableManager get journeys =>
      $$JourneysTableTableManager(_db, _db.journeys);
  $$PinsTableTableManager get pins => $$PinsTableTableManager(_db, _db.pins);
  $$PinMediasTableTableManager get pinMedias =>
      $$PinMediasTableTableManager(_db, _db.pinMedias);
  $$JourneyPointsTableTableManager get journeyPoints =>
      $$JourneyPointsTableTableManager(_db, _db.journeyPoints);
}
