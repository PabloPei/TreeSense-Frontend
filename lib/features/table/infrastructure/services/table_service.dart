import 'package:treesense/features/tree/infrastructure/models/paginated_trees.dart';
import 'package:treesense/features/tree/domain/usecases/get_all_trees_paginated.dart';

class TableService {
  final GetAllTreesPaginated _getAll;
  TableService(this._getAll);

  Future<PaginatedTrees> fetch({required int offset, required int limit}) {
    return _getAll(GetAllTreesPaginatedParams(offset: offset, limit: limit));
  }
}
