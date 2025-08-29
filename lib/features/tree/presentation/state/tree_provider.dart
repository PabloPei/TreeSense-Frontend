import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treesense/features/tree/domain/usecases/get_attribute_values.dart';
import 'package:treesense/features/tree/domain/usecases/get_species_values.dart';
import 'package:treesense/features/tree/domain/usecases/get_uploaded_tree_byuser.dart';
import 'package:treesense/features/tree/infrastructure/datasources/tree_datasource.dart';
import 'package:treesense/features/tree/domain/repositories/tree_repository.dart';
import 'package:treesense/features/tree/infrastructure/repositories/tree_repository_impl.dart';
import 'package:treesense/features/tree/domain/usecases/save_tree.dart';
import 'package:treesense/features/tree/presentation/state/tree_controller.dart';
import 'package:treesense/features/tree/presentation/state/tree_state.dart';
import 'package:treesense/features/tree/domain/entities/tree.dart';
import 'package:treesense/features/tree/domain/entities/attribute_value.dart';
import 'package:treesense/features/tree/domain/entities/species_value.dart';

// Datasources
final treeDatasourceProvider = Provider<TreeDatasource>((ref) {
  return TreeDatasource();
});

// Repositories
final treeRepositoryProvider = Provider<TreeRepository>((ref) {
  final datasource = ref.read(treeDatasourceProvider);
  return TreeRepositoryImpl(datasource);
});

// Use Cases
final saveTreeUseCaseProvider = Provider<SaveTree>((ref) {
  final repository = ref.read(treeRepositoryProvider);
  return SaveTree(repository);
});

final getAttributeValuesUseCaseProvider = Provider<GetAttributeValues>((ref) {
  final repository = ref.read(treeRepositoryProvider);
  return GetAttributeValues(repository);
});

final getSpeciesValuesUseCaseProvider = Provider<GetSpeciesValues>((ref) {
  final repository = ref.read(treeRepositoryProvider);
  return GetSpeciesValues(repository);
});

final getTreesUploadedByUserUseCaseProvider = Provider<GetUploadedTreeByuser>((
  ref,
) {
  final repository = ref.read(treeRepositoryProvider);
  return GetUploadedTreeByuser(repository);
});

// Tree Providers
enum TreeCensusType {
  arbolConPlantera,
  arbolSinPlantera,
  planteraVacia,
} //TODO: Ver si sacar esto de aca

final planterTypeProvider = StateProvider<TreeCensusType?>((ref) => null);

final treeCensusControllerProvider =
    StateNotifierProvider<TreeCensusController, TreeCensusState>((ref) {
      final saveTreeUseCase = ref.read(saveTreeUseCaseProvider);
      return TreeCensusController(saveTreeUseCase);
    });

final treeUploadedByUser = AutoDisposeFutureProvider<List<Tree>>((ref) async {
  final getUploadedTreeByUserUseCase = ref.read(
    getTreesUploadedByUserUseCaseProvider,
  );
  return await getUploadedTreeByUserUseCase();
});

// Tree attributes FutureProviders
final speciesProvider = AutoDisposeFutureProvider<List<SpeciesValue>>((
  ref,
) async {
  final useCase = ref.read(getSpeciesValuesUseCaseProvider);
  return await useCase();
});
final planterShapeProvider = AutoDisposeFutureProvider<List<AttributeValue>>((
  ref,
) async {
  final useCase = ref.read(getAttributeValuesUseCaseProvider);
  return await useCase("planter_shape");
});

final planterLevelProvider = AutoDisposeFutureProvider<List<AttributeValue>>((
  ref,
) async {
  final useCase = ref.read(getAttributeValuesUseCaseProvider);
  return await useCase("planter_level");
});

final planterLocationProvider = AutoDisposeFutureProvider<List<AttributeValue>>(
  (ref) async {
    final useCase = ref.read(getAttributeValuesUseCaseProvider);
    return await useCase("planter_location");
  },
);

final canopyTypeProvider = AutoDisposeFutureProvider<List<AttributeValue>>((
  ref,
) async {
  final useCase = ref.read(getAttributeValuesUseCaseProvider);
  return await useCase("canopy_type");
});

final shaftsProvider = AutoDisposeFutureProvider<List<AttributeValue>>((
  ref,
) async {
  final useCase = ref.read(getAttributeValuesUseCaseProvider);
  return await useCase("shafts");
});

final districtProvider = AutoDisposeFutureProvider<List<AttributeValue>>((
  ref,
) async {
  final useCase = ref.read(getAttributeValuesUseCaseProvider);
  return await useCase("district");
});

final treeStateProvider = AutoDisposeFutureProvider<List<AttributeValue>>((
  ref,
) async {
  final useCase = ref.read(getAttributeValuesUseCaseProvider);
  return await useCase("state");
});

final canopyManagementProvider =
    AutoDisposeFutureProvider<List<AttributeValue>>((ref) async {
      final useCase = ref.read(getAttributeValuesUseCaseProvider);
      return await useCase("canopy_management");
    });

final cracksTypeProvider = AutoDisposeFutureProvider<List<AttributeValue>>((
  ref,
) async {
  final useCase = ref.read(getAttributeValuesUseCaseProvider);
  return await useCase("cracks_type");
});

final rotTypeProvider = AutoDisposeFutureProvider<List<AttributeValue>>((
  ref,
) async {
  final useCase = ref.read(getAttributeValuesUseCaseProvider);
  return await useCase("rot_type");
});

final treeTypeProvider = AutoDisposeFutureProvider<List<AttributeValue>>((
  ref,
) async {
  final useCase = ref.read(getAttributeValuesUseCaseProvider);
  return await useCase("type");
});
