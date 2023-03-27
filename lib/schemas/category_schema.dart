import 'package:flutter_realm_stream_entity/schemas/product_offering_schema.dart';
import 'package:realm/realm.dart';

part 'category_schema.g.dart';

@RealmModel()
class $Category {
  @PrimaryKey()
  late String id;
  late String name;
  late List<$ProductOffering> productOffering = [];
}
