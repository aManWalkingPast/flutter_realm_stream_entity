// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'valid_for_schema.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class ValidFor extends $ValidFor
    with RealmEntity, RealmObjectBase, RealmObject {
  ValidFor(
    DateTime start,
    DateTime end,
  ) {
    RealmObjectBase.set(this, 'start', start);
    RealmObjectBase.set(this, 'end', end);
  }

  ValidFor._();

  @override
  DateTime get start =>
      RealmObjectBase.get<DateTime>(this, 'start') as DateTime;
  @override
  set start(DateTime value) => RealmObjectBase.set(this, 'start', value);

  @override
  DateTime get end => RealmObjectBase.get<DateTime>(this, 'end') as DateTime;
  @override
  set end(DateTime value) => RealmObjectBase.set(this, 'end', value);

  @override
  Stream<RealmObjectChanges<ValidFor>> get changes =>
      RealmObjectBase.getChanges<ValidFor>(this);

  @override
  ValidFor freeze() => RealmObjectBase.freezeObject<ValidFor>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(ValidFor._);
    return const SchemaObject(ObjectType.realmObject, ValidFor, 'ValidFor', [
      SchemaProperty('start', RealmPropertyType.timestamp),
      SchemaProperty('end', RealmPropertyType.timestamp),
    ]);
  }
}
