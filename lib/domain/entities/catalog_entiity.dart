import 'package:flutter_realm_stream_entity/domain/entities/category_entity.dart';
import 'package:flutter_realm_stream_entity/domain/entities/valid_for_entity.dart';

class CatalogEntity {
  late String id;
  late String name;
  late List<CategoryEntity> categoryEntity;
  ValidForEntity? validForEntity;

  CatalogEntity(this.id, this.name, this.categoryEntity);
}
