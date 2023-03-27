import 'package:realm/realm.dart';

part 'product_offering_schema.g.dart';

@RealmModel()
class $ProductOffering {
  @PrimaryKey()
  late String id;
  late String name;
}