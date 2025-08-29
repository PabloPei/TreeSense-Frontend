import 'package:treesense/features/tree/domain/entities/tree.dart';
import 'package:treesense/features/tree/domain/repositories/tree_repository.dart';

class GetUploadedTreeByuser {
  final TreeRepository repository;

  GetUploadedTreeByuser(this.repository);

  Future<List<Tree>> call() async {
    return await repository.getUploadedTreeByUser();
  }
}
