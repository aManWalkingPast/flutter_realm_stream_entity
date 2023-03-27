// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_offering_schema.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class ProductOffering extends $ProductOffering
    with RealmEntity, RealmObjectBase, RealmObject {
  ProductOffering(
    String id,
    String name,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
  }

  ProductOffering._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  Stream<RealmObjectChanges<ProductOffering>> get changes =>
      RealmObjectBase.getChanges<ProductOffering>(this);

  @override
  ProductOffering freeze() =>
      RealmObjectBase.freezeObject<ProductOffering>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(ProductOffering._);
    return const SchemaObject(
        ObjectType.realmObject, ProductOffering, 'ProductOffering', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
    ]);
  }
}
