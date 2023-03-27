import 'package:flutter_realm_stream_entity/data/datasources/local_datasources.dart';
import 'package:flutter_realm_stream_entity/domain/entities/catalog_entiity.dart';
import 'package:flutter_realm_stream_entity/domain/entities/category_entity.dart';
import 'package:flutter_realm_stream_entity/domain/entities/product_offering_entity.dart';
import 'package:flutter_realm_stream_entity/domain/entities/valid_for_entity.dart';
import 'package:flutter_realm_stream_entity/domain/repositories/catalog_repository.dart';
import 'package:flutter_realm_stream_entity/schemas/catalog_schema.dart';
import 'package:flutter_realm_stream_entity/schemas/category_schema.dart';
import 'package:flutter_realm_stream_entity/schemas/product_offering_schema.dart';
import 'package:realm/realm.dart';

class CatalogRepositoryImpl implements CatalogRepository {
  final LocalDataSource localDataSource;

  CatalogRepositoryImpl(this.localDataSource);

  @override
  void addCatalog(CatalogEntity catalogEntity) {
    localDataSource.addCatalog(catalogEntity);
  }

  @override
  CatalogEntity? getCatalogById(String catalogId) {
    Catalog? catalog = localDataSource.getCatalogById(catalogId);
    if (catalog != null) {
      List<CategoryEntity> categoryEntities = [];
      for (Category category in catalog.categories) {
        List<ProductOfferingEntity> productOfferingEntity = [];
        for (ProductOffering productOffering in category.productOffering) {
          productOfferingEntity.add(
              ProductOfferingEntity(productOffering.id, productOffering.name));
        }
        categoryEntities.add(
            CategoryEntity(category.id, category.name, productOfferingEntity));
      }
      CatalogEntity catalogEntity = CatalogEntity(
        catalog.id,
        catalog.name,
        categoryEntities,
      );
      if (catalog.validFor != null) {
        catalogEntity.validForEntity =
            ValidForEntity(catalog.validFor!.start, catalog.validFor!.end);
      }
      return catalogEntity;
    }
    return null;
  }

  @override
  Stream<CatalogEntity?>? getCatalogStreamById(String catalogId) {
    Catalog? catalog = localDataSource.getCatalogById(catalogId);

    if (catalog != null) {
      return catalog.changes.asyncMap<CatalogEntity?>((event) {
        if (event.isDeleted) {
          return null;
        }
        // HasData
        List<CategoryEntity> categoryEntities = [];
        for (Category category in event.object.categories) {
          List<ProductOfferingEntity> productOfferingEntity = [];
          for (ProductOffering productOffering in category.productOffering) {
            productOfferingEntity.add(ProductOfferingEntity(
                productOffering.id, productOffering.name));
          }
          categoryEntities.add(CategoryEntity(
              category.id, category.name, productOfferingEntity));
        }
        CatalogEntity catalogEntity = CatalogEntity(
          catalog.id,
          catalog.name,
          categoryEntities,
        );
        if (catalog.validFor != null) {
          catalogEntity.validForEntity = ValidForEntity(
            catalog.validFor!.start,
            catalog.validFor!.end,
          );
        }
        return catalogEntity;
      });
    }
    return null;
  }

  @override
  Stream<CatalogEntity?>? getCatalogQueryStreamById(String catalogId) {
    RealmResults<Catalog?> catalog =
        localDataSource.getCatalogQueryById(catalogId);
    if (catalog.isNotEmpty) {
      return catalog.changes.asyncMap<CatalogEntity?>((event) {
        Catalog? _catalog = event.results.first; // first only
        if (_catalog != null) {
          List<Category> categories = _catalog.categories;
          List<CategoryEntity> categoryEntities = [];
          for (Category? category in categories) {
            if (category == null) continue;
            List<ProductOfferingEntity> productOfferingEntity = [];
            for (ProductOffering productOffering in category.productOffering) {
              productOfferingEntity.add(ProductOfferingEntity(
                  productOffering.id, productOffering.name));
            }
            categoryEntities.add(CategoryEntity(
                category.id, category.name, productOfferingEntity));
          }

          CatalogEntity catalogEntity = CatalogEntity(
            _catalog.id,
            _catalog.name,
            categoryEntities,
          );
          if (_catalog.validFor != null) {
            catalogEntity.validForEntity = ValidForEntity(
              _catalog.validFor!.start,
              _catalog.validFor!.end,
            );
          }
          return catalogEntity;
        }
        return null;
      });
    }
    return null;
  }

  @override
  Stream<List<CatalogEntity?>>? getCatalogQueryStream() {
    RealmResults<Catalog?> catalog = localDataSource.getCatalogQuery();
    if (catalog.isNotEmpty) {
      return catalog.changes.asyncMap<List<CatalogEntity?>>((event) {
        List<CatalogEntity?> catalogEntities = [];
        if (event.results.isNotEmpty) {
          for (Catalog? _catalog in event.results.toList()) {
            if (_catalog != null) {
              List<CategoryEntity> categoryEntities = [];
              for (Category? category in _catalog.categories) {
                if (category == null) continue;
                List<ProductOfferingEntity> productOfferingEntity = [];
                for (ProductOffering productOffering
                    in category.productOffering) {
                  productOfferingEntity.add(ProductOfferingEntity(
                      productOffering.id, productOffering.name));
                }
                categoryEntities.add(CategoryEntity(
                    category.id, category.name, productOfferingEntity));
              }
              CatalogEntity catalogEntity = CatalogEntity(
                _catalog.id,
                _catalog.name,
                categoryEntities,
              );
              if (_catalog.validFor != null) {
                catalogEntity.validForEntity = ValidForEntity(
                  _catalog.validFor!.start,
                  _catalog.validFor!.end,
                );
              }
              catalogEntities.add(catalogEntity);
            }
          }
        }
        return catalogEntities;
      });
    }
    return null;
  }

  @override
  Stream<List<CategoryEntity?>>? getCategoryStreamAll() {
    RealmResults<Category?> category = localDataSource.getCategoryAll();
    if (category.isNotEmpty) {
      return category.changes.asyncMap<List<CategoryEntity?>>((event) {
        List<CategoryEntity> categoryEntities = [];
        for (Category? category in event.results.toList()) {
          if (category == null) continue;
          List<ProductOfferingEntity> productOfferingEntity = [];
          for (ProductOffering productOffering in category.productOffering) {
            productOfferingEntity.add(ProductOfferingEntity(
                productOffering.id, productOffering.name));
          }
          categoryEntities.add(CategoryEntity(
              category.id, category.name, productOfferingEntity));
        }
        return categoryEntities;
      });
    }
    return null;
  }

  @override
  Stream<CategoryEntity?>? getCategoryStreamById(String categoryId) {
    Category? catalog = localDataSource.getCategoryById(categoryId);

    if (catalog != null) {
      return catalog.changes.asyncMap<CategoryEntity?>((event) {
        if (event.isDeleted) {
          return null;
        }
        // HasData
        Category category = event.object;
        List<ProductOfferingEntity> productOfferingEntity = [];
        for (ProductOffering productOffering in category.productOffering) {
          productOfferingEntity.add(
              ProductOfferingEntity(productOffering.id, productOffering.name));
        }
        return CategoryEntity(
            category.id, category.name, productOfferingEntity);
      });
    }
    return null;
  }
}
