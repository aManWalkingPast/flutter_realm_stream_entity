part of 'catalog_cubit.dart';

@immutable
abstract class CatalogState {}

class CatalogInitial extends CatalogState {}

class CatalogHasDataStream extends CatalogState {
  late List<CatalogEntity?> _catalog;
  List<CatalogEntity?> get catalog => _catalog;

  CatalogHasDataStream(this._catalog);
}

class CatalogNoDataStream extends CatalogState {}
