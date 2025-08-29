import 'package:treesense/features/tree/domain/entities/attribute_value.dart';

class AttributeValueImpl implements AttributeValue {
  @override
  final String id;

  @override
  final String? description;

  AttributeValueImpl({required this.id, this.description});

  factory AttributeValueImpl.fromJson(Map<String, dynamic> json) {
    return AttributeValueImpl(
      id: json['id'] as String,
      description: json['description'] as String?, // puede ser null
    );
  }

  @override
  String toString() {
    return 'AttributeValueImpl{id: $id, description: $description}';
  }
}
