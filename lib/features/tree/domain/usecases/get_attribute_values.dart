import 'package:treesense/features/tree/domain/entities/attribute_value.dart';
import 'package:treesense/features/tree/domain/repositories/tree_repository.dart';

class GetAttributeValues {
  final TreeRepository repository;

  GetAttributeValues(this.repository);

  Future<List<AttributeValue>> call(String attributeName) {
    return repository.getAttributeValues(attributeName);
  }
}
