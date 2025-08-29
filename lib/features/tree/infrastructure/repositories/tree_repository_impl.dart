import 'package:treesense/features/tree/domain/entities/tree.dart';
import 'package:treesense/features/tree/domain/entities/attribute_value.dart';
import 'package:treesense/features/tree/domain/entities/species_value.dart';
import 'package:treesense/features/tree/domain/repositories/tree_repository.dart';
import 'package:treesense/features/tree/infrastructure/datasources/tree_datasource.dart';

class TreeRepositoryImpl implements TreeRepository {
  final TreeDatasource datasource;

  TreeRepositoryImpl(this.datasource);

  @override
  Future<String> saveTree(Tree tree) async {
    return await datasource.saveTree(tree);
  }

  @override
  Future<List<AttributeValue>> getAttributeValues(String attributeName) {
    return datasource.getAttributeValues(attributeName);
  }

  @override
  Future<List<SpeciesValue>> getSpeciesValues() {
    return datasource.getSpeciesValues();
  }

  @override
  Future<List<Tree>> getUploadedTreeByUser() async {
    return await datasource.getUploadedTreeByUser();
  }
}
