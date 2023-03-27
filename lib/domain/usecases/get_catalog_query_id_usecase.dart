import 'package:flutter_realm_stream_entity/domain/entities/catalog_entiity.dart';
import 'package:flutter_realm_stream_entity/domain/repositories/catalog_repository.dart';

class GetCatalogQueryIdUseCase {
  final CatalogRepository _catalogRepository;

  GetCatalogQueryIdUseCase(this._catalogRepository);

  Stream<CatalogEntity?>? execute(String catalogId) {
    return _catalogRepository.getCatalogQueryStreamById(catalogId);
  }
}
