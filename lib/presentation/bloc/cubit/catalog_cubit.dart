import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_realm_stream_entity/domain/entities/catalog_entiity.dart';
import 'package:flutter_realm_stream_entity/domain/repositories/catalog_repository.dart';
import 'package:flutter_realm_stream_entity/domain/usecases/get_catalog_query_usecase.dart';

part 'catalog_state.dart';

class CatalogCubit extends Cubit<CatalogState> {
  Stream<List<CatalogEntity?>>? _catalogStream;
  CatalogRepository _catalogRepository;

  CatalogCubit(this._catalogRepository) : super(CatalogInitial());

  void getCatalog() {
    _catalogStream = GetCatalogQueryUseCase(_catalogRepository).execute();
    if (_catalogStream != null) {
      _catalogStream!.listen((event) {
        emit(CatalogHasDataStream(event.toList()));
      });
    } else {
      emit(CatalogNoDataStream());
    }
  }
}
