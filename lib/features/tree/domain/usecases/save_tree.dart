import 'package:treesense/features/tree/domain/entities/tree.dart';
import 'package:treesense/features/tree/domain/repositories/tree_repository.dart';

class SaveTree {
  final TreeRepository repository;

  SaveTree(this.repository);

  Future<String> call(Tree tree) async {
    return await repository.saveTree(tree);
  }
}
