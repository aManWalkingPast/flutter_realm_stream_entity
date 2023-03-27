import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_realm_stream_entity/data/datasources/local_datasources.dart';
import 'package:flutter_realm_stream_entity/data/repositories/catalog_repository_impl.dart';
import 'package:flutter_realm_stream_entity/domain/entities/catalog_entiity.dart';
import 'package:flutter_realm_stream_entity/domain/entities/category_entity.dart';
import 'package:flutter_realm_stream_entity/domain/entities/product_offering_entity.dart';
import 'package:flutter_realm_stream_entity/domain/entities/valid_for_entity.dart';
import 'package:flutter_realm_stream_entity/domain/repositories/catalog_repository.dart';
import 'package:flutter_realm_stream_entity/domain/usecases/add_catalog_usecase.dart';
import 'package:flutter_realm_stream_entity/domain/usecases/get_catalog_query_id_usecase.dart';
import 'package:flutter_realm_stream_entity/domain/usecases/get_catalog_query_usecase.dart';
import 'package:flutter_realm_stream_entity/domain/usecases/get_catalog_stream_usecase.dart';
import 'package:flutter_realm_stream_entity/domain/usecases/get_category_all_stream_usecase.dart';
import 'package:flutter_realm_stream_entity/presentation/bloc/cubit/catalog_cubit.dart';
import 'package:flutter_realm_stream_entity/schemas/valid_for_schema.dart';

class UserPage extends StatefulWidget {
  late final LocalDataSource localDataSource;
  UserPage({
    super.key,
    required this.localDataSource,
  });

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late final CatalogRepository _catalogRepository;
  CatalogEntity? _catalogEntity;
  Stream<CatalogEntity?>? _catalogEntityStream;
  Stream<List<CatalogEntity?>>? _catalogEntityListStream;
  Stream<List<CategoryEntity?>>? _categoryEntityAllStream;
  late final CatalogCubit _catalogCubit;

  TextStyle textSize = const TextStyle(fontSize: 20);

  @override
  void initState() {
    _catalogRepository = CatalogRepositoryImpl(widget.localDataSource);
    _catalogCubit = CatalogCubit(_catalogRepository);
    super.initState();
  }

  void addCatalog() {
    AddCatalogUseCase addCatalogUseCase = AddCatalogUseCase(_catalogRepository);
    CatalogEntity catalogEntity = CatalogEntity(
      '1',
      'Package',
      [
        CategoryEntity('catagory 1', 'name 1', [
          ProductOfferingEntity('product offering 1', 'name 1'),
        ]),
        CategoryEntity('catagory 2', 'name 2', [
          ProductOfferingEntity('product offering 2', 'name 2'),
          ProductOfferingEntity('product offering 3', 'name 3'),
        ]),
      ],
    );
    catalogEntity.validForEntity = ValidForEntity(
      DateTime.now(),
      DateTime.now(),
    );
    addCatalogUseCase.execute(catalogEntity);
  }

  void getCatalog() {
    setState(() {
      // // find
      // _catalogEntity = GetCatalogUseCase(_catalogRepository).execute('1');

      // find and stream
      _catalogEntityStream =
          GetCatalogStreamUseCase(_catalogRepository).execute('1');

      // query and stream
      _catalogEntityStream =
          GetCatalogQueryIdUseCase(_catalogRepository).execute('1');

      // query with list of data and stream
      _catalogEntityListStream =
          GetCatalogQueryUseCase(_catalogRepository).execute();
    });
  }

  void getCategoryAll() {
    setState(() {
      // all and stream
      _categoryEntityAllStream =
          GetCategoryAllStreamUseCase(_catalogRepository).execute();
    });
  }

  void getCatalogFromBloc() {
    _catalogCubit.getCatalog();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                ElevatedButton(
                  onPressed: addCatalog,
                  child: const Text('Add Catalog'),
                ),
                ElevatedButton(
                  onPressed: getCatalog,
                  child: const Text('Get Catalog'),
                ),
                ElevatedButton(
                  onPressed: getCategoryAll,
                  child: const Text('Get Category'),
                ),
              ],
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: getCatalogFromBloc,
                  child: const Text('Get Catalog Bloc'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (_catalogEntityStream != null)
              StreamBuilder(
                stream: _catalogEntityStream,
                builder: (context, AsyncSnapshot<CatalogEntity?> snapshot) {
                  if (snapshot.hasData) {
                    CatalogEntity catalog = snapshot.data!;
                    return Column(
                      children: [
                        const Text(
                          'Stream Catalog By Id',
                          style: TextStyle(fontSize: 25, color: Colors.red),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'catalog id: ${catalog.id}',
                          style: textSize,
                        ),
                        Text(
                          'catalog name: ${catalog.name}',
                          style: textSize,
                        ),
                        const SizedBox(height: 10),
                        if (catalog.validForEntity != null)
                          const Text(
                            'Valid for',
                            style: TextStyle(fontSize: 25, color: Colors.red),
                          ),
                        if (catalog.validForEntity != null)
                          Text(
                            'valid for start: ${catalog.validForEntity!.start}',
                            style: textSize,
                          ),
                        if (catalog.validForEntity != null)
                          Text(
                            'valid for end: ${catalog.validForEntity!.end}',
                            style: textSize,
                          ),
                        const SizedBox(height: 10),
                        Column(
                          children: [
                            for (CategoryEntity categoryEntity
                                in catalog.categoryEntity)
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 10),
                                    const Text(
                                      'Categoriy',
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.red),
                                    ),
                                    Text(
                                      'cateogry id: ${categoryEntity.id}',
                                      style: textSize,
                                    ),
                                    Text(
                                      'cateogry name: ${categoryEntity.name}',
                                      style: textSize,
                                    ),
                                    for (ProductOfferingEntity productOfferingEntity
                                        in categoryEntity.productOfferingEntity)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Column(
                                          children: [
                                            const SizedBox(height: 10),
                                            const Text(
                                              'Product Offering',
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  color: Colors.red),
                                            ),
                                            Text(
                                              'product offering id: ${productOfferingEntity.id}',
                                              style: textSize,
                                            ),
                                            Text(
                                              'product offering name: ${productOfferingEntity.name}',
                                              style: textSize,
                                            ),
                                          ],
                                        ),
                                      )
                                  ],
                                ),
                              )
                          ],
                        ),
                        const SizedBox(height: 10),
                      ],
                    );
                  }
                  return const Text('No data found.');
                },
              ),
            const SizedBox(height: 30),
            if (_catalogEntityListStream != null)
              StreamBuilder(
                stream: _catalogEntityListStream,
                builder:
                    (context, AsyncSnapshot<List<CatalogEntity?>> snapshot) {
                  if (snapshot.hasData) {
                    List<CatalogEntity?>? catalogEntities = snapshot.data;
                    if (catalogEntities != null) {
                      return Column(
                        children: [
                          const Divider(
                            height: 2,
                            thickness: 2,
                            indent: 0,
                            endIndent: 0,
                            color: Colors.blue,
                          ),
                          if (catalogEntities.length > 0)
                            const Text(
                              'Stream Query list of Catalog',
                              style: TextStyle(fontSize: 25, color: Colors.red),
                            ),
                          Column(
                            children: [
                              for (CatalogEntity? catalogEntitiy
                                  in catalogEntities)
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 10),
                                      Text(
                                        'catalog id: ${catalogEntitiy?.id}',
                                        style: textSize,
                                      ),
                                      Text(
                                        'catalog name: ${catalogEntitiy?.name}',
                                        style: textSize,
                                      ),
                                      if (catalogEntitiy != null &&
                                          catalogEntitiy.validForEntity != null)
                                        const Text(
                                          'Valid for',
                                          style: TextStyle(
                                              fontSize: 25, color: Colors.red),
                                        ),
                                      if (catalogEntitiy != null &&
                                          catalogEntitiy.validForEntity != null)
                                        Text(
                                          'valid for start: ${catalogEntitiy.validForEntity!.start}',
                                          style: textSize,
                                        ),
                                      if (catalogEntitiy != null &&
                                          catalogEntitiy.validForEntity != null)
                                        Text(
                                          'valid for end: ${catalogEntitiy.validForEntity!.end}',
                                          style: textSize,
                                        ),
                                      const SizedBox(height: 10),
                                      if (catalogEntitiy != null)
                                        for (CategoryEntity categoryEntities
                                            in catalogEntitiy.categoryEntity)
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Column(
                                              children: [
                                                const SizedBox(height: 10),
                                                const Text(
                                                  'Category',
                                                  style: TextStyle(
                                                      fontSize: 25,
                                                      color: Colors.red),
                                                ),
                                                Text(
                                                  'category id: ${categoryEntities.id}',
                                                  style: textSize,
                                                ),
                                                Text(
                                                  'category name: ${categoryEntities.name}',
                                                  style: textSize,
                                                ),
                                              ],
                                            ),
                                          )
                                    ],
                                  ),
                                )
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      );
                    }
                  }
                  return const Text('No data found.');
                },
              ),
            const SizedBox(height: 30),
            if (_categoryEntityAllStream != null)
              StreamBuilder(
                stream: _categoryEntityAllStream,
                builder:
                    (context, AsyncSnapshot<List<CategoryEntity?>> snapshot) {
                  if (snapshot.hasData) {
                    List<CategoryEntity?>? catalogEntities = snapshot.data;
                    if (catalogEntities != null) {
                      return Column(
                        children: [
                          const Divider(
                            height: 2,
                            thickness: 2,
                            indent: 0,
                            endIndent: 0,
                            color: Colors.blue,
                          ),
                          if (catalogEntities.length > 0)
                            const Text(
                              'Stream Categories All',
                              style: TextStyle(fontSize: 25, color: Colors.red),
                            ),
                          Column(
                            children: [
                              for (CategoryEntity? categoryEntity
                                  in catalogEntities)
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 10),
                                      const Text(
                                        'Category',
                                        style: TextStyle(
                                            fontSize: 25, color: Colors.red),
                                      ),
                                      Text(
                                        'cateogry id: ${categoryEntity?.id}',
                                        style: textSize,
                                      ),
                                      Text(
                                        'cateogry name: ${categoryEntity?.name}',
                                        style: textSize,
                                      ),
                                      if (categoryEntity != null)
                                        for (ProductOfferingEntity productOfferingEntity
                                            in categoryEntity
                                                .productOfferingEntity)
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Column(
                                              children: [
                                                const SizedBox(height: 10),
                                                const Text(
                                                  'Product Offering',
                                                  style: TextStyle(
                                                      fontSize: 25,
                                                      color: Colors.red),
                                                ),
                                                Text(
                                                  'product offering id: ${productOfferingEntity.id}',
                                                  style: textSize,
                                                ),
                                                Text(
                                                  'product offering name: ${productOfferingEntity.name}',
                                                  style: textSize,
                                                ),
                                              ],
                                            ),
                                          )
                                    ],
                                  ),
                                )
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      );
                    }
                  }
                  return const Text('No data found.');
                },
              ),
            BlocBuilder<CatalogCubit, CatalogState>(
              bloc: _catalogCubit,
              builder: (context, state) {
                if (state is CatalogHasDataStream) {
                  List<CatalogEntity?>? catalogEntities = state.catalog;
                  if (catalogEntities != null) {
                    return Column(
                      children: [
                        const Divider(
                          height: 2,
                          thickness: 2,
                          indent: 0,
                          endIndent: 0,
                          color: Colors.blue,
                        ),
                        if (catalogEntities.length > 0)
                          const Text(
                            'Stream Query list of Catalog',
                            style: TextStyle(fontSize: 25, color: Colors.red),
                          ),
                        Column(
                          children: [
                            for (CatalogEntity? catalogEntitiy
                                in catalogEntities)
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  children: [
                                    Text(
                                      'catalog id: ${catalogEntitiy?.id}',
                                      style: textSize,
                                    ),
                                    Text(
                                      'catalog name: ${catalogEntitiy?.name}',
                                      style: textSize,
                                    ),
                                    if (catalogEntitiy != null &&
                                        catalogEntitiy.validForEntity != null)
                                      const Text(
                                        'Valid for',
                                        style: TextStyle(
                                            fontSize: 25, color: Colors.red),
                                      ),
                                    if (catalogEntitiy != null &&
                                        catalogEntitiy.validForEntity != null)
                                      Text(
                                        'valid for start: ${catalogEntitiy.validForEntity!.start}',
                                        style: textSize,
                                      ),
                                    if (catalogEntitiy != null &&
                                        catalogEntitiy.validForEntity != null)
                                      Text(
                                        'valid for end: ${catalogEntitiy.validForEntity!.end}',
                                        style: textSize,
                                      ),
                                    const SizedBox(height: 10),
                                    if (catalogEntitiy != null)
                                      for (CategoryEntity categoryEntities
                                          in catalogEntitiy.categoryEntity)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Column(
                                            children: [
                                              const SizedBox(height: 10),
                                              const Text(
                                                'Category',
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    color: Colors.red),
                                              ),
                                              Text(
                                                'category id: ${categoryEntities.id}',
                                                style: textSize,
                                              ),
                                              Text(
                                                'category name: ${categoryEntities.name}',
                                                style: textSize,
                                              ),
                                            ],
                                          ),
                                        )
                                  ],
                                ),
                              )
                          ],
                        ),
                        const SizedBox(height: 10),
                      ],
                    );
                  }
                }
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }
}
