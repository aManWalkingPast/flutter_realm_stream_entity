// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_schema.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Category extends $Category
    with RealmEntity, RealmObjectBase, RealmObject {
  Category(
    String id,
    String name, {
    Iterable<ProductOffering> productOffering = const [],
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set<RealmList<ProductOffering>>(
        this, 'productOffering', RealmList<ProductOffering>(productOffering));
  }

  Category._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  RealmList<ProductOffering> get productOffering =>
      RealmObjectBase.get<ProductOffering>(this, 'productOffering')
          as RealmList<ProductOffering>;
  @override
  set productOffering(covariant RealmList<ProductOffering> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<Category>> get changes =>
      RealmObjectBase.getChanges<Category>(this);

  @override
  Category freeze() => RealmObjectBase.freezeObject<Category>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Category._);
    return const SchemaObject(ObjectType.realmObject, Category, 'Category', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('productOffering', RealmPropertyType.object,
          linkTarget: 'ProductOffering',
          collectionType: RealmCollectionType.list),
    ]);
  }
}
