import 'package:flutter_realm_stream_entity/domain/entities/category_entity.dart';
import 'package:flutter_realm_stream_entity/domain/repositories/catalog_repository.dart';

class GetCategoryStreamUseCase {
  final CatalogRepository _catalogRepository;

  GetCategoryStreamUseCase(this._catalogRepository);

  Stream<CategoryEntity?>? execute(String categoryId) {
    return _catalogRepository.getCategoryStreamById(categoryId);
  }
}
