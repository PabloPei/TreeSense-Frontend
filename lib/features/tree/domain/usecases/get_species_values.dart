import 'package:treesense/features/tree/domain/entities/species_value.dart';
import 'package:treesense/features/tree/domain/repositories/tree_repository.dart';

class GetSpeciesValues {
  final TreeRepository repository;

  GetSpeciesValues(this.repository);

  Future<List<SpeciesValue>> call() {
    return repository.getSpeciesValues();
  }
}
