import 'package:flutter_realm_stream_entity/domain/entities/category_entity.dart';
import 'package:flutter_realm_stream_entity/domain/repositories/catalog_repository.dart';

class GetCategoryAllStreamUseCase {
  final CatalogRepository _catalogRepository;

  GetCategoryAllStreamUseCase(this._catalogRepository);

  Stream<List<CategoryEntity?>>? execute() {
    return _catalogRepository.getCategoryStreamAll();
  }
}
