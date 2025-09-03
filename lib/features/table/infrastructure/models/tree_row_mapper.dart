import 'package:treesense/features/tree/domain/entities/tree.dart';
import 'package:treesense/features/table/infrastructure/models/view_models/tree_row_vm.dart';

class TreeRowMapper {
  static TreeRowVM fromDomain(Tree t) {
    String short(String? id) =>
        (id == null || id.isEmpty)
            ? ''
            : id.substring(0, id.length < 8 ? id.length : 8);

    String ymd(DateTime? d) {
      if (d == null) return '';
      final m = d.month.toString().padLeft(2, '0');
      final day = d.day.toString().padLeft(2, '0');
      return "${d.year}-$m-$day";
    }

    return TreeRowVM(
      id: t.id ?? '',
      idShort: short(t.id),
      typeId: t.typeId,
      speciesName: t.speciesId,
      districtName: t.districtId,
      heightDisplay: t.height?.toStringAsFixed(2) ?? '',
      canopyDiameterDisplay: '',
      isRootIssuePresent: t.isRootIssuePresent ?? false,
      isBranchIssuePresent: t.isBranchIssuePresent ?? false,
      listsCommaSeparated: [
        ...(t.canopyManagementId ?? const []),
        ...(t.rotTypeId ?? const []),
        ...(t.cracksTypeId ?? const []),
      ].join(', '),
      photosCount: t.photosBase64?.length ?? 0,
      createdAtShort: ymd(t.createdAt),
      createdAtIso: t.createdAt?.toIso8601String() ?? '',
    );
  }
}
