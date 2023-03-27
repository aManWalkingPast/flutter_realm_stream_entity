// import 'package:flutter/foundation.dart';
import 'package:flutter_realm_stream_entity/domain/entities/catalog_entiity.dart';
import 'package:flutter_realm_stream_entity/domain/entities/category_entity.dart';
import 'package:flutter_realm_stream_entity/domain/entities/product_offering_entity.dart';
import 'package:flutter_realm_stream_entity/schemas/catalog_schema.dart';
import 'package:flutter_realm_stream_entity/schemas/category_schema.dart';
import 'package:flutter_realm_stream_entity/schemas/product_offering_schema.dart';
import 'package:flutter_realm_stream_entity/schemas/valid_for_schema.dart';
import 'package:realm/realm.dart';

abstract class LocalDataSource {
  void addCatalog(CatalogEntity catalogEntity);

  Catalog? getCatalogById(String catalogId);
  RealmResults<Catalog?> getCatalogQuery();
  RealmResults<Catalog?> getCatalogQueryById(String catalogId);

  Category? getCategoryById(String categoryId);
  RealmResults<Category?> getCategoryAll();
}

class LocalDataSourceImpl extends LocalDataSource {
  final Realm _realm;
  LocalDataSourceImpl(this._realm);

  @override
  void addCatalog(CatalogEntity catalogEntity) {
    _realm.write(() {
      List<Category> catagories = [];
      for (CategoryEntity categoryEntity in catalogEntity.categoryEntity) {
        List<ProductOffering> productOffering = [];
        for (ProductOfferingEntity productOfferingEntity
            in categoryEntity.productOfferingEntity) {
          productOffering.add(ProductOffering(
              productOfferingEntity.id, productOfferingEntity.name));
        }
        catagories.add(Category(categoryEntity.id, categoryEntity.name,
            productOffering: productOffering));
      }
      ValidFor? validFor;
      if (catalogEntity.validForEntity != null) {
        validFor = ValidFor(
          catalogEntity.validForEntity!.start,
          catalogEntity.validForEntity!.end,
        );
      }
      _realm.add(
        Catalog(
          catalogEntity.id,
          catalogEntity.name,
          categories: catagories,
          validFor: validFor,
        ),
      );
    });
  }

  @override
  Catalog? getCatalogById(String catalogId) {
    return _realm.find<Catalog>(catalogId);
  }

  @override
  RealmResults<Catalog?> getCatalogQueryById(String catalogId) {
    return _realm.query<Catalog>("id='$catalogId'");
  }

  @override
  RealmResults<Catalog?> getCatalogQuery() {
    return _realm.query<Catalog>("name CONTAINS[c] 'Package'");
  }

  @override
  Category? getCategoryById(String categoryId) {
    return _realm.find<Category>(categoryId);
  }

  @override
  RealmResults<Category?> getCategoryAll() {
    return _realm.all<Category>();
  }
}
