import 'package:treesense/features/tree/domain/entities/tree.dart';
import 'package:treesense/shared/utils/app_utils.dart';

class TreeImpl implements Tree {
  // TODO: Revisar campos obligatorios y agregar validaciones que se llaman desde el updateTree del controller.
  @override
  final String? id;
  @override
  final String? speciesId;
  @override
  final String? typeId;
  @override
  final String? districtId;
  @override
  final double? latitude;
  @override
  final double? longitude;

  @override
  final double? height;
  @override
  final double? stemPerimeter;
  @override
  final int? stemInclination;
  @override
  final double? streetWidth;

  @override
  final bool? isStandingDry;
  @override
  final bool? isStumpPresent;
  @override
  final bool? isBarkPresent;
  @override
  final bool? isSuckersPresent;
  @override
  final bool? isCankersPresent;
  @override
  final bool? isMechanicalWoundsPresent;
  @override
  final bool? isStrainPresent;
  @override
  final String? canopyTypeId;
  @override
  final String? shaftsId;
  @override
  final bool? isRootIssuePresent;

  @override
  final bool? isBranchIssuePresent;

  @override
  final String? treeStateId;
  @override
  final String? planterShapeId;
  @override
  final String? planterLevelId;
  @override
  final double? planterLength;
  @override
  final double? planterWidth;
  @override
  final String? planterLocationId;

  @override
  final List<String>? canopyManagementId;
  @override
  final List<String>? rotTypeId;
  @override
  final List<String>? cracksTypeId;

  @override
  final String? observations;

  @override
  DateTime? createdAt;

  @override
  DateTime? updatedAt;

  @override
  List<String>? photosBase64;

  TreeImpl({
    this.id,
    this.speciesId,
    this.typeId,
    this.districtId,
    this.latitude,
    this.longitude,
    this.createdAt,
    this.updatedAt,
    this.height,
    this.stemPerimeter,
    this.stemInclination,
    this.streetWidth,
    this.isStandingDry,
    this.isStumpPresent,
    this.isBarkPresent,
    this.isSuckersPresent,
    this.isCankersPresent,
    this.isMechanicalWoundsPresent,
    this.isStrainPresent,
    this.canopyTypeId,
    this.shaftsId,
    this.isRootIssuePresent,
    this.isBranchIssuePresent,
    this.treeStateId,
    this.planterShapeId,
    this.planterLevelId,
    this.planterLength,
    this.planterWidth,
    this.planterLocationId,
    this.canopyManagementId,
    this.rotTypeId,
    this.cracksTypeId,
    this.observations,
    this.photosBase64,
  });

  factory TreeImpl.fromJson(Map<String, dynamic> json) {
    return TreeImpl(
      id: json['treeId'] as String,
      speciesId: json['treeSpeciesId'] as String?,
      typeId: json['typeId'] as String?,
      districtId: json['districtId'] as String?,
      latitude: json['latitude'],
      longitude: json['longitude'],
      height: (json['height'] as num?)?.toDouble(),
      stemPerimeter: (json['stemPerimeter'] as num?)?.toDouble(),
      stemInclination: json['stemInclination'] as int?,
      streetWidth: (json['streetWidth'] as num?)?.toDouble(),
      isStandingDry: json['isStandingDry'] as bool?,
      isStumpPresent: json['isStumpPresent'] as bool?,
      isBarkPresent: json['isBarkPresent'] as bool?,
      isSuckersPresent: json['isSuckersPresent'] as bool?,
      isCankersPresent: json['isCankersPresent'] as bool?,
      isMechanicalWoundsPresent: json['isMechanicalWoundsPresent'] as bool?,
      isStrainPresent: json['isStrainPresent'] as bool?,
      canopyTypeId: json['canopyType'] as String?,
      shaftsId: json['shafts'] as String?,
      isRootIssuePresent: json['isRootIssuePresent'] as bool?,
      isBranchIssuePresent: json['isBranchIssuePresent'] as bool?,
      treeStateId: json['treeState'] as String?,
      planterShapeId: json['planterShape'] as String?,
      planterLevelId: json['planterLevel'] as String?,
      planterLength: (json['planterLength'] as num?)?.toDouble(),
      planterWidth: (json['planterWidth'] as num?)?.toDouble(),
      planterLocationId: json['planterLocation'] as String?,
      canopyManagementId:
          (json['previousCanopyManagement'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList(),
      rotTypeId:
          (json['rotType'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList(),
      cracksTypeId:
          (json['cracksType'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList(),
      observations: json['observations'] as String?,
      createdAt: parsePreservingLocalTime(
        json['createdAt'] ?? DateTime.now().toIso8601String(),
      ),
      updatedAt: parsePreservingLocalTime(
        json['updatedAt'] ?? DateTime.now().toIso8601String(),
      ),
      photosBase64:
          (json['photo'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );
  }

  TreeImpl copyWith({
    String? speciesId,
    String? typeId,
    String? districtId,
    double? latitude,
    double? longitude,
    double? height,
    DateTime? createdAt,
    DateTime? updatedAt,
    double? stemPerimeter,
    int? stemInclination,
    double? streetWidth,
    bool? isStandingDry,
    bool? isStumpPresent,
    bool? isBarkPresent,
    bool? isSuckersPresent,
    bool? isCankersPresent,
    bool? isMechanicalWoundsPresent,
    bool? isStrainPresent,
    String? canopyTypeId,
    String? shaftsId,
    bool? isRootIssuePresent,
    bool? isBranchIssuePresent,
    String? treeStateId,
    String? planterShapeId,
    String? planterLevelId,
    double? planterLength,
    double? planterWidth,
    String? planterLocationId,
    List<String>? canopyManagementId,
    List<String>? rotTypeId,
    List<String>? cracksTypeId,
    String? observations,
    List<String>? photosBase64,
  }) {
    return TreeImpl(
      id: id,
      speciesId: speciesId,
      typeId: typeId ?? this.typeId,
      districtId: districtId,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      height: height,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      stemPerimeter: stemPerimeter,
      stemInclination: stemInclination,
      streetWidth: streetWidth,
      isStandingDry: isStandingDry,
      isStumpPresent: isStumpPresent,
      isBarkPresent: isBarkPresent,
      isSuckersPresent: isSuckersPresent,
      isCankersPresent: isCankersPresent,
      isMechanicalWoundsPresent: isMechanicalWoundsPresent,
      isStrainPresent: isStrainPresent,
      canopyTypeId: canopyTypeId,
      shaftsId: shaftsId,
      isRootIssuePresent: isRootIssuePresent,
      isBranchIssuePresent: isBranchIssuePresent,
      treeStateId: treeStateId,
      planterShapeId: planterShapeId,
      planterLevelId: planterLevelId,
      planterLength: planterLength,
      planterWidth: planterWidth,
      planterLocationId: planterLocationId,
      canopyManagementId: canopyManagementId,
      rotTypeId: rotTypeId,
      cracksTypeId: cracksTypeId,
      observations: observations ?? this.observations,
      photosBase64: photosBase64 ?? this.photosBase64,
    );
  }

  @override
  String toString() {
    return 'TreeImpl{'
        'id: $id, '
        'speciesId: $speciesId, '
        'typeId: $typeId, '
        'districtId: $districtId, '
        'latitude: $latitude, '
        'longitude: $longitude, '
        'height: $height, '
        'stemPerimeter: $stemPerimeter, '
        'stemInclination: $stemInclination, '
        'streetWidth: $streetWidth, '
        'isStandingDry: $isStandingDry, '
        'isStumpPresent: $isStumpPresent, '
        'isBarkPresent: $isBarkPresent, '
        'isSuckersPresent: $isSuckersPresent, '
        'isCankersPresent: $isCankersPresent, '
        'isMechanicalWoundsPresent: $isMechanicalWoundsPresent, '
        'isStrainPresent: $isStrainPresent, '
        'canopyType: $canopyTypeId, '
        'shaftsId: $shaftsId, '
        'isRootIssuePresent: $isRootIssuePresent, '
        'isBranchIssuePresent: $isBranchIssuePresent, '
        'treeStateId: $treeStateId, '
        'planterShapeId: $planterShapeId, '
        'planterLevelId: $planterLevelId, '
        'planterLength: $planterLength, '
        'planterWidth: $planterWidth, '
        'planterLocation: $planterLocationId, '
        'canopyManagementId: $canopyManagementId, '
        'rotTypeId: $rotTypeId, '
        'cracksTypeId: $cracksTypeId, '
        'observations: $observations, '
        'createdAt: $createdAt, '
        'updatedAt: $updatedAt, '
        'photosBase64: ${photosBase64?.length ?? 0} photos'
        '}';
  }
}
