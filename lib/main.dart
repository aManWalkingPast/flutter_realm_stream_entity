import 'package:flutter/material.dart';
import 'package:flutter_realm_stream_entity/data/datasources/local_datasources.dart';
import 'package:flutter_realm_stream_entity/presentation/pages/user_page.dart';
import 'package:flutter_realm_stream_entity/schemas/catalog_schema.dart';
import 'package:flutter_realm_stream_entity/schemas/category_schema.dart';
import 'package:flutter_realm_stream_entity/schemas/product_offering_schema.dart';
import 'package:flutter_realm_stream_entity/schemas/valid_for_schema.dart';
import 'package:realm/realm.dart';

late Realm realm;
late LocalDataSource localDataSource;
void main() {
  LocalConfiguration config = Configuration.local(
    [
      Catalog.schema,
      Category.schema,
      ProductOffering.schema,
      ValidFor.schema,
    ],
  );
  realm = Realm(config);
  print(realm.config.path);

  localDataSource = LocalDataSourceImpl(realm);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UserPage(
        localDataSource: localDataSource,
      ),
    );
  }
}
