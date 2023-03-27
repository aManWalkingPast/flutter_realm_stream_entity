import 'package:flutter_realm_stream_entity/domain/entities/product_offering_entity.dart';

class CategoryEntity {
  late String id;
  late String name;
  late List<ProductOfferingEntity> productOfferingEntity;

  CategoryEntity(this.id, this.name, this.productOfferingEntity);
}
