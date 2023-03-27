import 'package:flutter_realm_stream_entity/domain/entities/catalog_entiity.dart';
import 'package:flutter_realm_stream_entity/domain/repositories/catalog_repository.dart';

class AddCatalogUseCase {
  final CatalogRepository _catalogRepository;

  AddCatalogUseCase(this._catalogRepository);

  void execute(CatalogEntity catalogEntity) {
    _catalogRepository.addCatalog(catalogEntity);
  }
}
