import 'package:flutter_realm_stream_entity/domain/entities/catalog_entiity.dart';
import 'package:flutter_realm_stream_entity/domain/repositories/catalog_repository.dart';

class GetCatalogUseCase {
  final CatalogRepository _catalogRepository;

  GetCatalogUseCase(this._catalogRepository);

  CatalogEntity? execute(String catalogId) {
    return _catalogRepository.getCatalogById(catalogId);
  }
}
