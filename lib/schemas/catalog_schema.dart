import 'package:flutter_realm_stream_entity/schemas/category_schema.dart';
import 'package:flutter_realm_stream_entity/schemas/valid_for_schema.dart';
import 'package:realm/realm.dart';

part 'catalog_schema.g.dart';

@RealmModel()
class $Catalog {
  @PrimaryKey()
  late String id;
  late String name;
  late List<$Category> categories = [];
  late $ValidFor? validFor;
}
