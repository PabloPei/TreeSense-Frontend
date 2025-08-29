import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treesense/features/tree/domain/usecases/save_tree.dart';
import 'package:treesense/features/tree/infrastructure/models/tree_impl.dart';
import 'package:treesense/features/tree/presentation/state/tree_state.dart';

class TreeCensusController extends StateNotifier<TreeCensusState> {
  final SaveTree saveTreeData;

  TreeCensusController(this.saveTreeData) : super(TreeCensusState());

  void reset() {
    state = TreeCensusState();
  }

  TreeImpl getTreeData() {
    return state.treeData ?? TreeImpl();
  }

  void updateTreeData({
    String? species,
    bool updateSpecies = false,
    String? type,
    String? district,
    bool updateDistrict = false,
    double? latitude,
    double? longitude,
    bool? isStandingDry,
    bool updateIsStandingDry = false,
    bool? isStumpPresent,
    bool updateIsStumpPresent = false,
    double? streetWidth,
    bool updateStreetWidth = false,
    double? height,
    bool updateHeight = false,
    double? stemPerimeter,
    bool updateStemPerimeter = false,
    bool? isMechanicalWoundsPresent,
    bool updateIsMechanicalWoundsPresent = false,
    bool? isStrainPresent,
    bool updateIsStrainPresent = false,
    String? canopyTypeId,
    bool updateCanopyType = false,
    String? shaftsId,
    bool updateShaftsId = false,
    bool? isRootIssuePresent,
    bool updateIsRootIssuePresent = false,
    bool? isBranchIssuePresent,
    bool updateIsBranchIssuePresent = false,
    bool? isCankersPresent,
    bool updateIsCankersPresent = false,
    bool? isSuckersPresent,
    bool updateIsSuckersPresent = false,
    int? stemInclination,
    bool updateStemInclination = false,
    bool? isBarkPresent,
    bool updateIsBarkPresent = false,
    String? planterShapeId,
    bool updatePlanterShape = false,
    String? planterLevelId,
    bool updatePlanterLevel = false,
    double? planterLength,
    bool updatePlanterLength = false,
    double? planterWidth,
    bool updatePlanterWidth = false,
    String? planterLocationId,
    bool updatePlanterLocation = false,
    String? treeState,
    bool updateTreeState = false,
    List<String>? rotType,
    bool updateRotType = false,
    List<String>? cracksType,
    bool updateCracksType = false,
    List<String>? previousCanopyManagement,
    bool updateCanopyManagement = false,
    List<String>? photosBase64,
    bool updatePhotos = false,
    String? observations,
    bool updateObservations = false,
    DateTime? createdAt,
  }) {
    final current = state.treeData;

    final updatedTree =
        (current is TreeImpl)
            ? TreeImpl(
              speciesId: updateSpecies ? species : current.speciesId,
              typeId: type ?? current.typeId,
              districtId: updateDistrict ? district : current.districtId,
              latitude: latitude ?? current.latitude,
              longitude: longitude ?? current.longitude,
              isStandingDry:
                  updateIsStandingDry ? isStandingDry : current.isStandingDry,
              isStumpPresent:
                  updateIsStumpPresent
                      ? isStumpPresent
                      : current.isStumpPresent,
              streetWidth:
                  updateStreetWidth ? streetWidth : current.streetWidth,
              height: updateHeight ? height : current.height,
              stemPerimeter:
                  updateStemPerimeter ? stemPerimeter : current.stemPerimeter,
              isMechanicalWoundsPresent:
                  updateIsMechanicalWoundsPresent
                      ? isMechanicalWoundsPresent
                      : current.isMechanicalWoundsPresent,
              isStrainPresent:
                  updateIsStrainPresent
                      ? isStrainPresent
                      : current.isStrainPresent,
              canopyTypeId:
                  updateCanopyType ? canopyTypeId : current.canopyTypeId,
              shaftsId: updateShaftsId ? shaftsId : current.shaftsId,
              isRootIssuePresent:
                  updateIsRootIssuePresent
                      ? isRootIssuePresent
                      : current.isRootIssuePresent,
              isBranchIssuePresent:
                  updateIsBranchIssuePresent
                      ? isBranchIssuePresent
                      : current.isBranchIssuePresent,
              isCankersPresent:
                  updateIsCankersPresent
                      ? isCankersPresent
                      : current.isCankersPresent,
              isSuckersPresent:
                  updateIsSuckersPresent
                      ? isSuckersPresent
                      : current.isSuckersPresent,
              stemInclination:
                  updateStemInclination
                      ? stemInclination
                      : current.stemInclination,
              isBarkPresent:
                  updateIsBarkPresent ? isBarkPresent : current.isBarkPresent,
              treeStateId: updateTreeState ? treeState : current.treeStateId,
              rotTypeId: updateRotType ? rotType : current.rotTypeId,
              cracksTypeId:
                  updateCracksType ? cracksType : current.cracksTypeId,
              canopyManagementId:
                  updateCanopyManagement
                      ? previousCanopyManagement
                      : current.canopyManagementId,
              photosBase64: updatePhotos ? photosBase64 : current.photosBase64,
              observations:
                  updateObservations ? observations : current.observations,
              planterLevelId:
                  updatePlanterLevel ? planterLevelId : current.planterLevelId,
              planterShapeId:
                  updatePlanterShape ? planterShapeId : current.planterShapeId,
              planterLength:
                  updatePlanterLength ? planterLength : current.planterLength,
              planterWidth:
                  updatePlanterWidth ? planterWidth : current.planterWidth,
              planterLocationId:
                  updatePlanterLocation
                      ? planterLocationId
                      : current.planterLocationId,
            )
            : TreeImpl(
              speciesId: species,
              typeId: type,
              districtId: district,
              latitude: latitude,
              longitude: longitude,
              isStandingDry: isStandingDry,
              isStumpPresent: isStumpPresent,
              streetWidth: streetWidth,
              height: height,
              stemPerimeter: stemPerimeter,
              isStrainPresent: isStrainPresent,
              canopyTypeId: canopyTypeId,
              shaftsId: shaftsId,
              isRootIssuePresent: isRootIssuePresent,
              isBranchIssuePresent: isBranchIssuePresent,
              isMechanicalWoundsPresent: isMechanicalWoundsPresent,
              isCankersPresent: isCankersPresent,
              isSuckersPresent: isSuckersPresent,
              stemInclination: stemInclination,
              isBarkPresent: isBarkPresent,
              treeStateId: treeState,
              rotTypeId: rotType,
              cracksTypeId: cracksType,
              canopyManagementId: previousCanopyManagement,
              photosBase64: photosBase64,
              observations: observations,
              planterLevelId: planterLevelId,
              planterShapeId: planterShapeId,
              planterLength: planterLength,
              planterWidth: planterWidth,
              planterLocationId: planterLocationId,
            );

    state = state.copyWith(treeData: updatedTree);

    print(
      '🌳 [TreeState] updated: ${state.treeData}',
    ); //TODO: BORRAR, ES UN PRINT DE DEBUG
  }

  Future<String> saveTree() async {
    try {
      final responseMessage = await saveTreeData(state.treeData!);
      return responseMessage;
    } catch (e) {
      rethrow;
    }
  }
}
