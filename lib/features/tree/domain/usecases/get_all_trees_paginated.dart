import 'package:treesense/features/tree/domain/repositories/tree_repository.dart';
import 'package:treesense/features/tree/infrastructure/models/paginated_trees.dart';

class GetAllTreesPaginatedParams {
  final int offset, limit;
  GetAllTreesPaginatedParams({required this.offset, required this.limit});
}

class GetAllTreesPaginated {
  final TreeRepository repository;
  GetAllTreesPaginated(this.repository);

  Future<PaginatedTrees> call(GetAllTreesPaginatedParams p) {
    return repository.listAll(offset: p.offset, limit: p.limit);
  }
}
