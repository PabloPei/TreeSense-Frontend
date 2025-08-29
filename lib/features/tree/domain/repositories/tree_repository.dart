import 'package:treesense/features/tree/domain/entities/tree.dart';
import 'package:treesense/features/tree/domain/entities/attribute_value.dart';
import 'package:treesense/features/tree/domain/entities/species_value.dart';

abstract class TreeRepository {
  Future<String> saveTree(Tree tree);
  Future<List<AttributeValue>> getAttributeValues(String attributeName);
  Future<List<SpeciesValue>> getSpeciesValues();
  Future<List<Tree>> getUploadedTreeByUser();
}
