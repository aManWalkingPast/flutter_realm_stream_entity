// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog_schema.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Catalog extends $Catalog with RealmEntity, RealmObjectBase, RealmObject {
  Catalog(
    String id,
    String name, {
    ValidFor? validFor,
    Iterable<Category> categories = const [],
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'validFor', validFor);
    RealmObjectBase.set<RealmList<Category>>(
        this, 'categories', RealmList<Category>(categories));
  }

  Catalog._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  RealmList<Category> get categories =>
      RealmObjectBase.get<Category>(this, 'categories') as RealmList<Category>;
  @override
  set categories(covariant RealmList<Category> value) =>
      throw RealmUnsupportedSetError();

  @override
  ValidFor? get validFor =>
      RealmObjectBase.get<ValidFor>(this, 'validFor') as ValidFor?;
  @override
  set validFor(covariant ValidFor? value) =>
      RealmObjectBase.set(this, 'validFor', value);

  @override
  Stream<RealmObjectChanges<Catalog>> get changes =>
      RealmObjectBase.getChanges<Catalog>(this);

  @override
  Catalog freeze() => RealmObjectBase.freezeObject<Catalog>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Catalog._);
    return const SchemaObject(ObjectType.realmObject, Catalog, 'Catalog', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('categories', RealmPropertyType.object,
          linkTarget: 'Category', collectionType: RealmCollectionType.list),
      SchemaProperty('validFor', RealmPropertyType.object,
          optional: true, linkTarget: 'ValidFor'),
    ]);
  }
}
