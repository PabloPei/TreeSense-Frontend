import 'package:treesense/features/tree/domain/entities/tree.dart';

class PaginatedTrees {
  final List<Tree> items;
  final int total; // TODO: mandar total desde backend
  PaginatedTrees({required this.items, required this.total});
}
