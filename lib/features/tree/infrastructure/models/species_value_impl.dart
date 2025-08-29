import 'package:treesense/features/tree/domain/entities/species_value.dart';

class SpeciesValueImpl implements SpeciesValue {
  @override
  final String id;
  @override
  final String? commonName;
  @override
  final String? description;

  SpeciesValueImpl({required this.id, this.commonName, this.description});

  factory SpeciesValueImpl.fromJson(Map<String, dynamic> json) {
    final rawId = json['treeSpeciesId'];
    if (rawId == null || rawId.toString().trim().isEmpty) {
      throw Exception(
        "species item without id",
      ); // se valida en datasource también
    }

    return SpeciesValueImpl(
      id: rawId as String,
      commonName: json['treeSpeciesCommonName'] as String?,
      description: json['description'] as String?,
    );
  }
}
