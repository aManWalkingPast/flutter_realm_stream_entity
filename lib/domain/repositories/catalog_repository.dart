import 'package:flutter_realm_stream_entity/domain/entities/catalog_entiity.dart';
import 'package:flutter_realm_stream_entity/domain/entities/category_entity.dart';

abstract class CatalogRepository {
  void addCatalog(CatalogEntity catalogEntity);

  CatalogEntity? getCatalogById(String catalogId);

  Stream<CatalogEntity?>? getCatalogStreamById(String catalogId);

  Stream<CatalogEntity?>? getCatalogQueryStreamById(String catalogId);
  Stream<List<CatalogEntity?>>? getCatalogQueryStream();

  Stream<CategoryEntity?>? getCategoryStreamById(String categoryId);
  Stream<List<CategoryEntity?>>? getCategoryStreamAll();
}
