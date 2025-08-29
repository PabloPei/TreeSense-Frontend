abstract class Tree {
  // Identificadores
  String? get id;
  String? get speciesId;
  String? get typeId;
  String? get districtId;

  // Ubicación
  double? get latitude;
  double? get longitude;

  // Datos físicos
  double? get height;
  double? get stemPerimeter;
  int? get stemInclination;

  // Estado físico
  bool? get isStandingDry;
  bool? get isStumpPresent;
  bool? get isBarkPresent;
  bool? get isSuckersPresent;
  bool? get isCankersPresent;
  bool? get isMechanicalWoundsPresent;
  bool? get isStrainPresent;
  String? get canopyTypeId;
  String? get shaftsId;
  bool? get isRootIssuePresent;
  bool? get isBranchIssuePresent;

  // Plantera
  String? get planterShapeId;
  String? get planterLevelId;
  double? get planterLength;
  double? get planterWidth;
  String? get planterLocationId;

  // Relaciones con otras entidades
  String? get treeStateId;
  List<String>? get canopyManagementId;
  List<String>? get rotTypeId;
  List<String>? get cracksTypeId;
  double? get streetWidth;

  // Metadata
  String? get observations;
  DateTime? get createdAt;
  DateTime? get updatedAt;

  // Visuales / UI
  List<String>? get photosBase64;
}
