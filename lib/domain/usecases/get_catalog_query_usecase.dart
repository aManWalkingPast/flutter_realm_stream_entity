import 'package:flutter_realm_stream_entity/domain/entities/catalog_entiity.dart';
import 'package:flutter_realm_stream_entity/domain/repositories/catalog_repository.dart';

class GetCatalogQueryUseCase {
  final CatalogRepository _catalogRepository;

  GetCatalogQueryUseCase(this._catalogRepository);

  Stream<List<CatalogEntity?>>? execute() {
    return _catalogRepository.getCatalogQueryStream();
  }
}
