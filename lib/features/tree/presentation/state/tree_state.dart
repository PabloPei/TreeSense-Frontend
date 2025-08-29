import 'package:treesense/features/tree/infrastructure/models/tree_impl.dart';

enum TreeCensusFormStep {
  typeSelection,
  location,
  characteristics,
  defects,
  photo,
  observations,
  summary,
}

class TreeCensusState {
  final TreeCensusFormStep step;
  final TreeImpl? treeData;

  TreeCensusState({
    this.step = TreeCensusFormStep.typeSelection,
    this.treeData,
  });

  TreeCensusState copyWith({TreeCensusFormStep? step, TreeImpl? treeData}) {
    return TreeCensusState(
      step: step ?? this.step,
      treeData: treeData ?? this.treeData,
    );
  }
}
