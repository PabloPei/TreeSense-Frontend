import 'dart:math';

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

  static List<TreeRowVM> sample(int count) {
    final rnd = Random(42);
    String pad2(int n) => n.toString().padLeft(2, '0');

    return List.generate(count, (i) {
      final id = 'uuid-${i.toString().padLeft(6, '0')}';
      final height = rnd.nextBool() ? (rnd.nextDouble() * 20 + 2) : null;
      final canopy = rnd.nextBool() ? (rnd.nextDouble() * 10 + 1) : null;
      final date = DateTime(2025, rnd.nextInt(8) + 1, rnd.nextInt(28) + 1);
      final createdShort = '${date.year}-${pad2(date.month)}-${pad2(date.day)}';
      final lists = [
        if (rnd.nextBool()) 'Podas previas',
        if (rnd.nextBool()) 'Hongos',
        if (rnd.nextBool()) 'Grietas',
      ].join(', ');

      return TreeRowVM(
        id: id,
        idShort: id.substring(0, 8),
        typeId: ['T', 'P', 'PT'][rnd.nextInt(3)],
        speciesName:
            ['Tipuana', 'Jacarandá', 'Fresno', 'Plátano'][rnd.nextInt(4)],
        districtName: ['Centro', 'Norte', 'Sur', 'Oeste'][rnd.nextInt(4)],
        heightDisplay: height == null ? '' : height.toStringAsFixed(2),
        canopyDiameterDisplay: canopy == null ? '' : canopy.toStringAsFixed(2),
        isRootIssuePresent: rnd.nextBool(),
        isBranchIssuePresent: rnd.nextBool(),
        listsCommaSeparated: lists,
        photosCount: rnd.nextInt(5),
        createdAtShort: createdShort,
        createdAtIso: date.toIso8601String(),
      );
    });
  }
}
