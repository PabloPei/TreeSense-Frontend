class TreeRowVM {
  final String id;
  final String idShort;
  final String? typeId;
  final String? speciesName;
  final String? districtName;
  final String heightDisplay;
  final String canopyDiameterDisplay;
  final bool isRootIssuePresent;
  final bool isBranchIssuePresent;
  final String listsCommaSeparated;
  final int photosCount;
  final String createdAtShort;
  final String createdAtIso;

  const TreeRowVM({
    required this.id,
    required this.idShort,
    required this.typeId,
    required this.speciesName,
    required this.districtName,
    required this.heightDisplay,
    required this.canopyDiameterDisplay,
    required this.isRootIssuePresent,
    required this.isBranchIssuePresent,
    required this.listsCommaSeparated,
    required this.photosCount,
    required this.createdAtShort,
    required this.createdAtIso,
  });
}
