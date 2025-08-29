import 'package:flutter/material.dart';
import 'package:treesense/core/theme/app_theme.dart';

class MiniActionsPopover extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onClose;

  const MiniActionsPopover({
    super.key,
    required this.onEdit,
    required this.onDelete,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              tooltip: 'Editar',
              onPressed: onEdit,
              icon: Icon(Icons.edit, size: 18, color: rowActionColor),
              visualDensity: VisualDensity.compact,
            ),
            IconButton(
              tooltip: 'Borrar',
              onPressed: onDelete,
              icon: Icon(Icons.delete_outline, size: 18, color: rowActionColor),
              visualDensity: VisualDensity.compact,
            ),
            IconButton(
              tooltip: 'Cerrar',
              onPressed: onClose,
              icon: Icon(Icons.close, size: 18, color: rowActionColor),
              visualDensity: VisualDensity.compact,
            ),
          ],
        ),
      ),
    );
  }
}
