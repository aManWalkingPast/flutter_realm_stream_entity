import 'package:flutter_realm_stream_entity/domain/entities/catalog_entiity.dart';
import 'package:flutter_realm_stream_entity/domain/repositories/catalog_repository.dart';

class GetCatalogStreamUseCase {
  final CatalogRepository _catalogRepository;

  GetCatalogStreamUseCase(this._catalogRepository);

  Stream<CatalogEntity?>? execute(String catalogId) {
    return _catalogRepository.getCatalogStreamById(catalogId);
  }
}
