import 'package:treesense/features/tree/domain/entities/tree.dart';
import 'package:treesense/core/theme/format.dart';
import 'package:treesense/shared/utils/app_utils.dart';

class TreeValidator {
  ////// TypePage fields validation //////

  // TypeId validation (mandatory for every registry)
  static String? validateTypeId(Tree tree) {
    final value = tree.typeId;

    if (value == null || value.trim().isEmpty) {
      return MessageLoader.get('validateTypeId_required');
    }

    const validTypes = {
      typeIdCodePlanter,
      typeIdCodeTree,
      typeIdCodePlanterTree,
    };

    if (!validTypes.contains(value.trim())) {
      final validTypesStr = validTypes.join(', ');
      final msgTemplate = MessageLoader.get('validateTypeId_invalid');
      return msgTemplate.replaceAll('{{validTypes}}', validTypesStr);
    }

    return null;
  }

  ////// LocationPage fields validation //////

  // TODO: Restringir a latitud y longitud en Lomas de Zamora
  // Latitude validation (mandatory for every registry)
  static String? validateLatitude(Tree tree) {
    final value = tree.latitude;
    if (value == null) return MessageLoader.get('validateLatitude_required');
    if (value < latitudeMin || value > latitudeMax) {
      return MessageLoader.get('validateLatitude_range');
    }
    return null;
  }

  // Longitude validation (mandatory for every registry)
  static String? validateLongitude(Tree tree) {
    final value = tree.longitude;
    if (value == null) return MessageLoader.get('validateLongitude_required');
    if (value < longitudeMin || value > longitudeMax) {
      return MessageLoader.get('validateLongitude_range');
    }
    return null;
  }

  // District ID validation (mandatory for every registry)
  static String? validateDistrict(Tree tree) {
    final value = tree.districtId?.trim();

    if (value == null || value.isEmpty) {
      return MessageLoader.get('validateDistrict_required');
    }
    return null;
  }

  // Street Width validation (optional for every regisrty)
  static String? validateStreetWidth(Tree tree) {
    final value = tree.streetWidth;
    if (value == null) return null;

    if (value <= 0) return MessageLoader.get('validateStreetWidth_min');
    if (value > streetWidthMax) {
      return MessageLoader.get('validateStreetWidth_max');
    }

    return null;
  }

  // Planter Shape ID validation (optional for P or PT, null for T)
  static String? validatePlanterShapeId(Tree tree) {
    final value = tree.planterShapeId?.trim();

    if (tree.typeId == typeIdCodeTree) {
      if (value != null && value.isNotEmpty) {
        return MessageLoader.get('validatePlanterShapeId_tree');
      }
      return null;
    }
    if (value == null || value.isEmpty) {
      return null;
    }
    return null;
  }

  // Planter Level Id validation (optional for P and PT, null for T)
  static String? validatePlanterLevelId(Tree tree) {
    final value = tree.planterLevelId?.trim();

    if (tree.typeId == typeIdCodeTree) {
      if (value != null && value.isNotEmpty) {
        return MessageLoader.get('validatePlanterLevelId_tree');
      }
      return null;
    }
    if (value == null || value.isEmpty) {
      return null;
    }
    return null;
  }

  // Planter Location ID validation (optional when P or PT, null when T)
  static String? validatePlanterLocationId(Tree tree) {
    final value = tree.planterLocationId?.trim();
    if (tree.typeId == typeIdCodeTree) {
      if (value != null && value.isNotEmpty) {
        return MessageLoader.get('validatePlanterLocationId_tree');
      }
      return null;
    }
    if (value == null || value.isEmpty) {
      return null;
    }
    return null;
  }

  // Validation for Planter Length (optional when P or PT, null when T)
  static String? validatePlanterLength(Tree tree) {
    final value = tree.planterLength;
    if (tree.typeId == typeIdCodeTree) {
      if (value != null) return MessageLoader.get('validatePlanterLength_tree');
      return null;
    }

    if (value == null) return null;

    if (value <= 0) return MessageLoader.get('validatePlanterLength_min');
    if (value > planterLengthMax) {
      return MessageLoader.get('validatePlanterLength_max');
    }

    return null;
  }

  // Validation for planterWidth (optional)
  static String? validatePlanterWidth(Tree tree) {
    final value = tree.planterWidth;
    if (tree.typeId == typeIdCodeTree) {
      if (value != null) return MessageLoader.get('validatePlanterWidth_tree');
      return null;
    }

    if (value == null) return null;

    if (value <= 0) return MessageLoader.get('validatePlanterWidth_min');
    if (value > planterWidthMax) {
      return MessageLoader.get('validatePlanterWidth_max');
    }

    return null;
  }

  ////// CharacteristicsPage fields validation //////

  // Species ID validation (mandatory when T or PT, null when P)
  static String? validateSpeciesId(Tree tree) {
    final value = tree.speciesId;
    if (tree.typeId == typeIdCodePlanter) {
      if (value != null) return MessageLoader.get('validateSpeciesId_planter');
      return null;
    }
    if (value == null || value.trim().isEmpty) {
      return MessageLoader.get('validateSpeciesId_required');
    }
    if (value.trim().length < 2) {
      return MessageLoader.get('validateSpeciesId_minLength');
    }
    return null;
  }

  // Valition for Canopy Management ID (optional when T or PT, null when P)
  static String? validateCanopyManagementId(Tree tree) {
    final list = tree.canopyManagementId;
    if (tree.typeId == typeIdCodePlanter) {
      if (list != null) {
        return MessageLoader.get('validateCanopyManagementId_planter');
      }
      return null;
    }
    // No obligatorio: permitir null o lista vacía
    return null;
  }

  // Validation for Canopy Type ID (optional when T or PT, null when P)
  static String? validateCanopyTypeId(Tree tree) {
    final value = tree.canopyTypeId;
    if (tree.typeId == typeIdCodePlanter) {
      if (value != null) {
        return MessageLoader.get('validateCanopyTypeId_planter');
      }
      return null;
    }
    if (value == null || value.isEmpty) return null;

    return null;
  }

  // Validation for Tree State ID (optional when T or PT, null when P)
  static String? validateTreeStateId(Tree tree) {
    final value = tree.treeStateId?.trim();

    if (tree.typeId == typeIdCodePlanter) {
      if (value != null) {
        return MessageLoader.get('validateTreeStateId_planter');
      }
      return null;
    }

    if (value == null || value.isEmpty) return null;

    return null;
  }

  // Validation for Height (mandatory when T or PT, null when P)
  static String? validateHeight(Tree tree) {
    final value = tree.height;
    if (tree.typeId == typeIdCodePlanter) {
      if (value != null) return MessageLoader.get('validateHeight_planter');
      return null;
    }
    if (value == null) return MessageLoader.get('validateHeight_required');
    if (value <= 0) return MessageLoader.get('validateHeight_min');
    if (value > heightMax) return MessageLoader.get('validateHeight_max');
    return null;
  }

  // Validation for Stem Perimeter (mandatory when T or PT, optional when P)
  static String? validateStemPerimeter(Tree tree) {
    final value = tree.stemPerimeter;
    if (tree.typeId == typeIdCodePlanter) {
      if (value != null) {
        return MessageLoader.get('validateStemPerimeter_planter');
      }
      return null;
    }
    if (value == null) {
      return MessageLoader.get('validateStemPerimeter_required');
    }
    if (value <= 0) return MessageLoader.get('validateStemPerimeter_min');
    if (value > stemPerimeterMax) {
      return MessageLoader.get('validateStemPerimeter_max');
    }
    return null;
  }

  // Validation for shaftsId (optional when T or PT, null when P)
  static String? validateShaftsId(Tree tree) {
    final value = tree.shaftsId;
    if (tree.typeId == typeIdCodePlanter) {
      if (value != null) return MessageLoader.get('validateShaftsId_planter');
      return null;
    }
    if (value == null || value.isEmpty) return null;

    return null;
  }

  // Validation for isStrainPresent (optional when T or PT, null when P)
  static String? validateIsStrainPresent(Tree tree) {
    final value = tree.isStrainPresent;
    if (tree.typeId == typeIdCodePlanter) {
      if (value != null) {
        return MessageLoader.get('validateIsStrainPresent_planter');
      }
      return null;
    }
    if (value != null && value is! bool) {
      return MessageLoader.get('validateIsStrainPresent_invalid');
    }
    return null;
  }

  // Validation for isStandingDry (mandatory when T or PT, null when P)
  static String? validateIsStandingDry(Tree tree) {
    final value = tree.isStandingDry;
    if (tree.typeId == typeIdCodePlanter) {
      if (value != null) {
        return MessageLoader.get('validateIsStandingDry_planter');
      }
      return null;
    }
    if (value == null) {
      return MessageLoader.get('validateIsStandingDry_required');
    }
    if (value is! bool) {
      return MessageLoader.get('validateIsStandingDry_invalid');
    }
    return null;
  }

  //Validation for isStumpPresent (optional when T or PT, null when P)
  static String? validateIsStumpPresent(Tree tree) {
    final value = tree.isStumpPresent;
    if (tree.typeId == typeIdCodePlanter) {
      if (value != null) {
        return MessageLoader.get('validateIsStumpPresent_planter');
      }
      return null;
    }
    if (value != null && value is! bool) {
      return MessageLoader.get('validateIsStumpPresent_invalid');
    }
    return null;
  }

  ////// DefectsPage fields validation //////

  // Rot Type ID validation (optional when T or PT, null when P)
  static String? validateRotTypeId(Tree tree) {
    final list = tree.rotTypeId;
    if (tree.typeId == typeIdCodePlanter) {
      if (list != null) {
        return MessageLoader.get('validateRotTypeId_planter');
      }
      return null;
    }
    return null;
  }

  // Cracks Type ID validation (optional when T or PT, null when P)
  static String? validateCracksTypeId(Tree tree) {
    final list = tree.cracksTypeId;
    if (tree.typeId == typeIdCodePlanter) {
      if (list != null) {
        return MessageLoader.get('validateCracksTypeId_planter');
      }
      return null;
    }
    return null;
  }

  // Stem Inclination validation (optional when T or PT, null when P)
  static String? validateStemInclination(Tree tree) {
    final value = tree.stemInclination;
    if (tree.typeId == typeIdCodePlanter) {
      if (value != null) {
        return MessageLoader.get('validateStemInclination_planter');
      }

      return null;
    }

    if (value == null) return null;

    if (value < 0 || value > stemInclinationMax) {
      return MessageLoader.get('validateStemInclination_range');
    }

    return null;
  }

  // Is Bark Present validation (optional when T or PT, null when P)
  static String? validateIsBarkPresent(Tree tree) {
    final value = tree.isBarkPresent;
    if (tree.typeId == typeIdCodePlanter) {
      if (value != null) {
        return MessageLoader.get('validateIsBarkPresent_planter');
      }

      return null;
    }
    if (value != null && value is! bool) {
      return MessageLoader.get('validateIsBarkPresent_bool');
    }
    return null;
  }

  // Is Suckers Present validation (optional when T or PT, null when P)
  static String? validateIsSuckersPresent(Tree tree) {
    final value = tree.isSuckersPresent;
    if (tree.typeId == typeIdCodePlanter) {
      if (value != null) {
        return MessageLoader.get('validateIsSuckersPresent_planter');
      }

      return null;
    }
    if (value != null && value is! bool) {
      return MessageLoader.get('validateIsSuckersPresent_bool');
    }
    return null;
  }

  // Is Cankers Present validation (optional when T or PT, null when P)
  static String? validateIsCankersPresent(Tree tree) {
    final value = tree.isCankersPresent;
    if (tree.typeId == typeIdCodePlanter) {
      if (value != null) {
        return MessageLoader.get('validateIsCankersPresent_planter');
      }

      return null;
    }
    if (value != null && value is! bool) {
      return MessageLoader.get('validateIsCankersPresent_bool');
    }
    return null;
  }

  // Is Mechanical Wounds Present validation (optional when T or PT, null when P)
  static String? validateIsMechanicalWoundsPresent(Tree tree) {
    final value = tree.isMechanicalWoundsPresent;
    if (tree.typeId == typeIdCodePlanter) {
      if (value != null) {
        return MessageLoader.get('validateIsMechanicalWoundsPresent_planter');
      }
      return null;
    }
    if (value != null && value is! bool) {
      return MessageLoader.get('validateIsMechanicalWoundsPresent_bool');
    }
    return null;
  }

  // Is Root Issue Present validation (optional when T or PT, null when P)
  static String? validateIsRootIssuePresent(Tree tree) {
    final value = tree.isRootIssuePresent;
    if (tree.typeId == typeIdCodePlanter) {
      if (value != null) {
        return MessageLoader.get('validateIsRootIssuePresent_planter');
      }
      return null;
    }
    if (value != null && value is! bool) {
      return MessageLoader.get('validateIsRootIssuePresent_bool');
    }
    return null;
  }

  // Is Branch Issue Present validation (optional when T or PT, null when P)
  static String? validateIsBranchIssuePresent(Tree tree) {
    final value = tree.isBranchIssuePresent;
    if (tree.typeId == typeIdCodePlanter) {
      if (value != null) {
        return MessageLoader.get('validateIsBranchIssuePresent_planter');
      }
      return null;
    }
    if (value != null && value is! bool) {
      return MessageLoader.get('validateIsBranchIssuePresent_bool');
    }
    return null;
  }

  ////// PhotoPage fields validation //////

  // Photos Base64 validation (optional for every registry)
  static String? validatePhotosBase64(Tree tree) {
    final photos = tree.photosBase64;

    if (photos == null || photos.isEmpty) {
      return null;
    }

    if (photos.length > photosMax) {
      return MessageLoader.get('validatePhotosBase64_max');
    }

    for (int i = 0; i < photos.length; i++) {
      final photo = photos[i].trim();

      if (photo.isEmpty) {
        return 'Photo ${i + 1} is empty';
      }

      if (!_isValidBase64(photo)) {
        return 'Photo ${i + 1} is not a valid base64 string';
      }
    }

    return null;
  }

  // base64 auxiliary validation method
  static bool _isValidBase64(String value) {
    try {
      // base64 basic pattern
      final base64Pattern = RegExp(r'^[A-Za-z0-9+/]*={0,2}$');
      return base64Pattern.hasMatch(value) && value.length % 4 == 0;
    } catch (e) {
      return false;
    }
  }

  ////// ObservationsPage fields validation //////

  // Observations validation (optional for every registry)
  static String? validateObservations(Tree tree) {
    final value = tree.observations;

    if (value == null || value.trim().isEmpty) {
      return null;
    }

    if (value.trim().length > charactersMax) {
      return MessageLoader.get('validateObservations_max');
    }

    return null;
  }

  // Method for multiple simultaneous validation
  static Map<String, String?> validateMultipleFields(
    List<String> fields,
    Tree tree,
  ) {
    final errors = <String, String?>{};

    for (final fieldName in fields) {
      String? error;

      switch (fieldName) {
        case 'typeId':
          error = validateTypeId(tree);
          break;
        case 'latitude':
          error = validateLatitude(tree);
          break;
        case 'longitude':
          error = validateLongitude(tree);
          break;
        case 'districtId':
          error = validateDistrict(tree);
          break;
        case 'streetWidth':
          error = validateStreetWidth(tree);
          break;
        case 'planterShapeId':
          error = validatePlanterShapeId(tree);
          break;
        case 'planterLevelId':
          error = validatePlanterLevelId(tree);
          break;
        case 'planterLocationId':
          error = validatePlanterLocationId(tree);
          break;
        case 'planterLength':
          error = validatePlanterLength(tree);
          break;
        case 'planterWidth':
          error = validatePlanterWidth(tree);
          break;
        case 'speciesId':
          error = validateSpeciesId(tree);
          break;
        case 'canopyManagementId':
          error = validateCanopyManagementId(tree);
          break;
        case 'canopyTypeId':
          error = validateCanopyTypeId(tree);
          break;
        case 'treeStateId':
          error = validateTreeStateId(tree);
          break;
        case 'height':
          error = validateHeight(tree);
          break;
        case 'stemPerimeter':
          error = validateStemPerimeter(tree);
          break;
        case 'shaftsId':
          error = validateShaftsId(tree);
          break;
        case 'isStrainPresent':
          error = validateIsStrainPresent(tree);
          break;
        case 'isStandingDry':
          error = validateIsStandingDry(tree);
          break;
        case 'isStumpPresent':
          error = validateIsStumpPresent(tree);
          break;
        case 'rotTypeId':
          error = validateRotTypeId(tree);
          break;
        case 'cracksTypeId':
          error = validateCracksTypeId(tree);
          break;
        case 'stemInclination':
          error = validateStemInclination(tree);
          break;
        case 'isBarkPresent':
          error = validateIsBarkPresent(tree);
          break;
        case 'isSuckersPresent':
          error = validateIsSuckersPresent(tree);
          break;
        case 'isCankersPresent':
          error = validateIsCankersPresent(tree);
          break;
        case 'isMechanicalWoundsPresent':
          error = validateIsMechanicalWoundsPresent(tree);
          break;
        case 'isRootIssuePresent':
          error = validateIsRootIssuePresent(tree);
          break;
        case 'isBranchIssuePresent':
          error = validateIsBranchIssuePresent(tree);
          break;
        case 'photosBase64':
          error = validatePhotosBase64(tree);
          break;
        case 'observations':
          error = validateObservations(tree);
          break;
      }

      if (error != null) {
        errors[fieldName] = error;
      }
    }

    return errors;
  }

  // Method for a full Tree registry validation
  static List<String> validateTree(Tree tree) {
    final allFields = <String>[
      'typeId',
      'latitude',
      'longitude',
      'districtId',
      'streetWidth',
      'planterShapeId',
      'planterLevelId',
      'planterLocationId',
      'planterLength',
      'planterWidth',
      'speciesId',
      'canopyManagementId',
      'canopyTypeId',
      'treeStateId',
      'height',
      'stemPerimeter',
      'shaftsId',
      'isStrainPresent',
      'isStandingDry',
      'isStumpPresent',
      'rotTypeId',
      'cracksTypeId',
      'stemInclination',
      'isBarkPresent',
      'isSuckersPresent',
      'isCankersPresent',
      'isMechanicalWoundsPresent',
      'isRootIssuePresent',
      'isBranchIssuePresent',
      'photosBase64',
      'observations',
    ];

    final fieldErrors = validateMultipleFields(allFields, tree);
    return fieldErrors.values.whereType<String>().toList();
  }

  static List<String> _validatePage(List<String> fields, Tree tree) {
    final fieldErrors = validateMultipleFields(fields, tree);
    return fieldErrors.values.whereType<String>().toList();
  }

  static List<String> validateTypePage(Tree tree) {
    final error = validateTypeId(tree);
    return error == null ? [] : [error];
  }

  static List<String> validateLocationPage(Tree tree) {
    return _validatePage([
      'latitude',
      'longitude',
      'districtId',
      'streetWidth',
      'planterShapeId',
      'planterLevelId',
      'planterLocationId',
      'planterLength',
      'planterWidth',
    ], tree);
  }

  static List<String> validateCharecteristicsPage(Tree tree) {
    return _validatePage([
      'speciesId',
      'canopyManagementId',
      'canopyTypeId',
      'treeStateId',
      'height',
      'stemPerimeter',
      'shaftsId',
      'isStrainPresent',
      'isStandingDry',
      'isStumpPresent',
    ], tree);
  }

  static List<String> validateDefectsPage(Tree tree) {
    return _validatePage([
      'rotTypeId',
      'cracksTypeId',
      'stemInclination',
      'isBarkPresent',
      'isSuckersPresent',
      'isCankersPresent',
      'isMechanicalWoundsPresent',
      'isRootIssuePresent',
      'isBranchIssuePresent',
    ], tree);
  }

  static List<String> validatePhotosPage(Tree tree) {
    return _validatePage(['photosBase64'], tree);
  }

  static List<String> validateObservationsPage(Tree tree) {
    return _validatePage(['observations'], tree);
  }
}
