import 'package:flutter/material.dart';

class CenteredHeader extends StatelessWidget {
  final String title;
  final bool isSorted;
  const CenteredHeader(this.title, {this.isSorted = false});

  @override
  Widget build(BuildContext context) {
    final double rightPad = isSorted ? 20.0 : 0.0;
    return Padding(
      padding: EdgeInsets.only(right: rightPad),
      child: Align(
        alignment: Alignment.center,
        child: Text(title, textAlign: TextAlign.center),
      ),
    );
  }
}
